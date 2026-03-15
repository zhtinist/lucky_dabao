/**
 * 本地加密脚本
 * 用法: node encrypt-local.js
 * 读取 src/ 下所有文件，加密后输出到 encrypted/，同时生成 file-tree.json
 */

const CryptoJS = require('crypto-js');
const fs = require('fs');
const path = require('path');
const readline = require('readline');

const sourceDir  = './src';
const outputDir  = './encrypted';

async function getPassword() {
  const rl = readline.createInterface({ input: process.stdin, output: process.stdout });
  return new Promise(resolve => rl.question('请输入加密密码 (回车读取 website_key.txt): ', ans => {
    rl.close();
    if (ans.trim()) { resolve(ans.trim()); return; }
    // 回车留空，读取 ../website_key.txt
    const keyFile = path.resolve(__dirname, '../website_key.txt');
    if (fs.existsSync(keyFile)) {
      const pwd = fs.readFileSync(keyFile, 'utf8').trim();
      if (pwd) { console.log('✓ 已从 website_key.txt 读取密码'); resolve(pwd); return; }
    }
    console.error('website_key.txt 不存在或为空');
    resolve('');
  }));
}

function encryptDir(dir, baseDir, password) {
  fs.readdirSync(dir).forEach(name => {
    const full = path.join(dir, name);
    const rel  = path.relative(baseDir, full);
    if (fs.statSync(full).isDirectory()) {
      encryptDir(full, baseDir, password);
    } else {
      const content   = fs.readFileSync(full, 'utf8').replace(/^\uFEFF/, '');
      const encrypted = CryptoJS.AES.encrypt(content, password).toString();
      const dest      = path.join(outputDir, rel + '.enc');
      fs.mkdirSync(path.dirname(dest), { recursive: true });
      fs.writeFileSync(dest, encrypted);
      console.log('✓', rel);
    }
  });
}

const DIR_ORDER = ['腾讯','YouTube','抖音','Bilibili','快手','小红书'];

function buildTree(dir, baseDir) {
  const entries = fs.readdirSync(dir).sort((a, b) => {
    const ai = DIR_ORDER.indexOf(a), bi = DIR_ORDER.indexOf(b);
    if (ai !== -1 && bi !== -1) return ai - bi;
    if (ai !== -1) return -1;
    if (bi !== -1) return 1;
    return a.localeCompare(b);
  });
  return entries.map(name => {
    const full = path.join(dir, name);
    const rel  = path.relative(baseDir, full);
    if (fs.statSync(full).isDirectory()) {
      return { type: 'dir', name, children: buildTree(full, baseDir) };
    }
    return { type: 'file', name, path: rel.replace(/\\/g, '/') + '.enc' };
  });
}

(async () => {
  if (!fs.existsSync(sourceDir)) {
    console.error('src/ 目录不存在');
    process.exit(1);
  }

  const password = await getPassword();
  if (!password) { console.error('密码不能为空'); process.exit(1); }

  // 清空旧的加密文件
  if (fs.existsSync(outputDir)) fs.rmSync(outputDir, { recursive: true });
  fs.mkdirSync(outputDir, { recursive: true });

  console.log('\n加密中...');
  encryptDir(sourceDir, sourceDir, password);

  const tree = buildTree(sourceDir, sourceDir);
  fs.writeFileSync('file-tree.json', JSON.stringify(tree, null, 2));

  console.log('\n✅ 加密完成，file-tree.json 已生成');
  console.log('现在运行 quick-update.bat 推送即可');
})();
