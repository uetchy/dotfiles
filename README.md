# dotfiles

## Bootstrap

```console
cd ~
git clone -p git@github.com:uetchy/dotfiles.git .dotfiles
cd .dotfiles
./dot link
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

## Edit config

```console
editrc # open zshrc/zshrc
editrc zsh # open zshrc/mod/zsh.zsh
editrc git # open zshrc/mod/git.zsh
reload
```
