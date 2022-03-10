import os

cam = '/home/lrocio/Projetos'

def mostraDir(xargs):
    
    for l1, l2, l3 in os.walk(cam):
        #print(f'{l1} Campo1, {l2} Campo2, {l3} Campo3')
        #print(f'{l1}')
        i = l1
        print(i)

        #for i in l1:
        #    print(i)
        break

mostraDir(cam)