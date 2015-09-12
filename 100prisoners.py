# -*- coding: utf-8 -*-
"""

Задача про 100 заключенных
Created on Sun Jun 14 18:33:37 2015

@author: gregory
"""

import random
import time
from numba import jit

@jit
def single_experiment(zk_count, max_trial):
    zk_num = list(range(zk_count))
    boxes = list(range(zk_count))
    random.shuffle(boxes)
     
    for zk in zk_num:
        box = zk
        trial = 0
        zk_success = False
        while trial < max_trial:
            if boxes[box] == zk:
                zk_success = True
                break
            else:
                box = boxes[box]
            trial += 1  
            
        if not zk_success: break
    
    return zk_success


experiments = 100000
succ = 0
t = time.time()
for i in range(experiments):
    succ += single_experiment(100,50)
    
print(time.time() - t)    # 26 секунд - медленнее R и Javascript (10 и 14 секунд) (без numba, с нумбой - 22 секунды)
print(succ/experiments)   # 0.31141

###################
# а этот тест быстрее R, причем время не зависит от длины списка (в R зависит), что хорошо.
import random
import time
from numba import jit

vec = list(range(10000))

def funct(times):
    for i in range(times):
        idx = random.randint(0,len(vec) - 1)
        vec[idx] = idx
    

    return None
    
   
vec = [1] * 10000
t = time.time()
for i in range(100): funct(10000)  
print(time.time() - t)

vec = [1] * 100000
t = time.time()
for i in range(100): funct(10000)  
print(time.time() - t)

vec = [1] * 1000000
t = time.time()
for i in range(100): funct(10000)  
print(time.time() - t)

vec = [1] * 10000000
t = time.time()
for i in range(100): funct(10000)  
print(time.time() - t)







