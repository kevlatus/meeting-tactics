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
  console.log('starting Angular build');
  execSync('npm run build');

  console.log('copying build output to temp dir');
  fs.copySync(path.join('./dist', name), TEMP_DIR);

  execSync('git checkout gh-pages');

  console.log('deleting existing files.');
  const files = getFiles('./');
  for (const f of files) {
    fs.unlinkSync(f);
  }

  console.log('copying built files to current directory.');
  fs.copySync(TEMP_DIR, './');

  execSync('git add .');
  execSync('git commit -m "update gh page"');
  execSync('git push origin gh-pages');
  execSync('git checkout master');
}
finally {
  console.log('deleting temporary directory');
  fs.removeSync(TEMP_DIR);
}
