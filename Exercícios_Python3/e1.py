import os

# cam = '/home/lrocio/Projetos'


cam = captura.get('/home/lrocio/Projetos')

def mostraDir(xargs):
    for l1, l2, l3 in os.walk(cam):
        print(f'{l1} Campo1, {l2} Campo2, {l3} Campo3')
        print()
        print(len(l1))
        for i in l1:
            print(i, type(i))
        break
        #for dir, dir1, dir2 in l1():
        #    print(f'{l1} Campo1')
        #    print (f'dir, dir1, dir2')

mostraDir(cam)
