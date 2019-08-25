const {execSync} = require('child_process');
const fs = require('fs-extra');
const os = require('os');
const path = require('path');

const {name} = require('./package.json');

const TEMP_DIR = fs.mkdtempSync(path.join(os.tmpdir(), name), {recursive: true});

console.log(`Creating temp dir at ${TEMP_DIR}`);

function getFiles(p) {
  const names = fs.readdirSync(p);
  return names
    .filter(n => fs.statSync(path.join(p, n)).isFile())
    .map(n => path.join(p, n));
}

try {
  console.log('Starting Angular build');
  execSync('npm run build');

  console.log('Copying build output to temp dir');
  fs.copySync(path.join('./dist', name), TEMP_DIR);

  execSync('git checkout gh-pages');

  const files = getFiles('./');
  for (const f of files) {
    fs.unlinkSync(f);
  }

  fs.copySync(TEMP_DIR, './')
}
finally {
  fs.removeSync(TEMP_DIR);
}
