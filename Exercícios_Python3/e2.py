import os
from statistics import mean
""""
Listas em Python
- fatiamento - append, insert, 
aula 38 Listas (Vetor)
fatiamento, append, insert, pop (retira o último), del, clear, extend
min, max, mean (média), range (cria sequencia)

l2 = [1, 2, 3, "nome", 4, 5, True, 6, 7, 8.23, -9]
digitados = []

# l2 = l2.append[10]

for i in l2:
    print(f'O tipo do item {i} é {type(i)}')

    digitados = digitados.append(input('informe o conteúdo: '))




l1 = [12,34,56,78,90,98,76,54,32]

l2 = list(range(21,50,3))

print()

print(f'o valor máximo será: {max(l2)} e o menor: {min(l2)} e a média será: {mean(l2)}')

print()
"""

# Entra com a palavra
palavra = input(f'digite a palavra secreta: ')
chances = input(f'quantas chances serão dadas? ') 
digitada = []

while True:
    letra = input(f'digite a letra a ser buscada na secreta: ')
    
    digitada.append(letra)

    if letra in palavra:
        print(f'Bom, a letra "{letra}" está presente')
    else:
        print(f'Ainda não, a letra "{letra}" ')
        digitada.pop()
     
    

    secreto_temp = ""
    for i in palavra:
        if i in digitada:
            secreto_temp += i
        else:
            secreto_temp += '*'

    if palavra == secreto_temp:
        print(f'acertou')
        break
    
    print(secreto_temp)


print()
print(f'palavra digitada: {adigitada}, chances {chances}, palavra: {palavra}')







