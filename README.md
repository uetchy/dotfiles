# dotfiles

## Bootstrap

```console
brew install ghq
export GHQ_ROOT=~/Repos/src
mkdir -p $GHQ_ROOT
ghq get -p -l -u uetchy/dotfiles
./dot list
./dot link --force
```

## List links

```console
./dot list
```

## Link

```console
./dot link
./dot link --force
```

## Unlink

```console
./dot unlink zsh
```

## Edit config command

```console
editrc # open zshrc/zshrc
editrc zsh # open zshrc/mod/zsh.zsh
editrc git # open zshrc/mod/git.zsh
```
