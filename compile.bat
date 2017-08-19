@echo off
luajit %URN%\bin\urn.lua main.lisp -t -o vim -O4 && copy /Y vim.lua C:\Users\becar\AppData\Roaming\ccemux\computer\0\vim