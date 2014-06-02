Vim-jake
========

Interactive javascript REPL

Installation
============
vim-jake depends on [vimproc](https://github.com/Shougo/vimproc.vim). Install it first. Then install vim-jake with any vim package manager.

You'll need nREPL to connect to:
```shell
npm install -g simple-nrepl
```

Usage
=====

Start nREPL in your project directory with `nrepl 5000`
Open vim, type `:JakeConnect`

You'll have the following bindings available in your javascript files:
```
cpp - to evaluate line
cpp (in visual mode) - evaluate selection
```

![jake](https://cloud.githubusercontent.com/assets/822951/3149038/65608e42-ea67-11e3-97ae-97aa1973f39d.png)

