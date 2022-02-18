import os

cam = '/home/lrocio/Projetos'

for l1, l2, l3 in os.walk(cam):
    #print(f'{l1} Campo1, {l2} Campo2, {l3} Campo3')
    for dir, dir1, dir2 in l1():
        print(f'{l1} Campo1')
        print (f'dir, dir1, dir2')