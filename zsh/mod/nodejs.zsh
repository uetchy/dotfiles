alias npm-list="npm list -g --depth 0"
alias npm-precheck="npm pack --json | jq '.[0].files[].path' -r | sort"
alias dev="yarn dev || yarn start || yarn watch || yarn develop || vc dev"

alias y="yarn"
alias yu="yarn upgrade"
alias yui="yarn upgrade-interactive"
alias yuil="yarn upgrade-interactive --latest"
alias ya="yarn add"
alias yad="yarn add -D"
alias yw="yarn workspaces"
alias yr="yarn run"
alias yb="yarn build"
alias yt="yarn test"
alias fp="fixpack"
alias prettier-all='prettier --write "(!({lib,dist,coverage})**).{{t,j}s{,x},json,md,html?}"'

# usage:
# 1. $ n 15
# 3. `use node 15` -> .envrc
export N_PREFIX=$HOME/.n
export NODE_VERSIONS=$N_PREFIX/n/versions/node
export NODE_VERSION_PREFIX=

yat() {
  yarn add -D ${@/#/@types/}
}

init-npm() {
  init-git

  if ! grep -Fxqs 'layout node' .envrc; then echo 'layout node' >>.envrc; fi
  direnv allow

  local name=$(basename $PWD)
  local user=$(git config github.user)
  local gh_repo="https://github.com/$user/$name"
  [ ! -f package.json ] && yarn init -y
  [ "$(npe description)" = "undefined" ] && npe description $name
  [ "$(npe keywords)" = "undefined" ] && npe keywords $name
  [ "$(npe repository.type)" = "undefined" ] && npe repository.type git
  [ "$(npe repository.url)" = "undefined" ] && npe repository.url $gh_repo.git
  [ "$(npe homepage)" = "undefined" ] && npe homepage $gh_repo
  [ "$(npe bugs.url)" = "undefined" ] && npe bugs.url $gh_repo/issues
  [ "$(npe scripts.build)" = "undefined" ] && npe scripts.build "npm run tsup -- --minify --dts"
  [ "$(npe scripts.clean)" = "undefined" ] && npe scripts.clean "shx rm -rf lib"
  [ "$(npe scripts.dev)" = "undefined" ] && npe scripts.dev "npm run tsup -- --watch"
  [ "$(npe scripts.prepublishOnly)" = "undefined" ] && npe scripts.prepublishOnly "npm run clean && npm run build"
  [ "$(npe scripts.test)" = "undefined" ] && npe scripts.test "jest"
  [ "$(npe scripts.tsup)" = "undefined" ] && npe scripts.tsup "tsup src/index.ts -d lib"
  [ "$(npe types)" = "undefined" ] && npe types "lib/index.d.ts"
  [ "$(npe main)" = "undefined" ] && npe main "lib/index.js"
  [ "$(npe files)" = "undefined" ] && npe files lib
  [ "$(npe engines.node)" = "undefined" ] && npe engines.node ">= 12.18.3" # lts
  yarn add -D typescript ts-node @types/node jest ts-jest @types/jest shx tsup
  fixpack

  cat <<'EOD' > .gitignore
.vscode
package-lock.json
yarn.lock
.envrc
EOD
  gig node

  mkdir src types tests
  touch src/index.ts tests/index.test.ts
  echo '{}' > .prettierrc

  yarn tsc --init
  gsed -i 's|"compilerOptions"|"exclude": ["tests", "lib"],\n  "compilerOptions"|' tsconfig.json
  gsed -i 's|"target": "es5"|"target": "es2018"|' tsconfig.json
  gsed -i 's|// "rootDir": "./"|"rootDir": "./src"|' tsconfig.json
  gsed -i 's|// "outDir": "./"|"outDir": "./lib"|' tsconfig.json
  gsed -i 's|// "declaration"|"declaration"|' tsconfig.json
  yarn ts-jest config:init
}

init-release-it() {
  yad release-it @release-it/conventional-changelog
  [ "$(npe scripts.release)" = "undefined" ] && npe scripts.release "release-it"
  touch .release-it.yml
}

remove-lockfile() {
  cat <<EOD > .gitignore
package-lock.json
yarn.lock
$(cat .gitignore)
EOD
  git rm --cached yarn.lock
  git rm --cached package-lock.json
}
