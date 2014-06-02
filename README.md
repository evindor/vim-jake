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

![image](https://cloud.githubusercontent.com/assets/822951/3149009/06e06b44-ea67-11e3-8f96-202af8fa4828.png)
