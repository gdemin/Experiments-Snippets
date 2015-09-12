# -*- coding: utf-8 -*-
"""
Created on Tue Sep  1 20:44:19 2015

@author: gregory

http://www.paulgraham.com/accgen.html

Мне показалось довольно странным решение для Питона
через объекты, поэтому я стал проверять, можно ли это
сделать более нормально. Выяснилось, что легко...

"""

def foo(n):
    return lambda i: n + i
    

aaa = foo(5)

aaa(3)
aaa(5)

bbb = foo(10)

bbb(3)
bbb(5)