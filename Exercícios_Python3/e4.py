"""
Aula 40 sintaxe for / else


from ast import Break


variavel = ['joão', 'maria', 'josé']
# verdade = False

for i in variavel:
    if i.lower().startswith('j'):
        variavel = i.upper().startswith()
        print(f'letra {1} palavra {variavel}')
        Break
        verdade = True

if verdade:
    print('existe')
else:
    print('não encontrou')
"""

"""
Aula 41 - sintaxe Split, Join, Enumerate
identifica os marcadores que podem ser utilizados para separar ou juntar trechos do conteúdo
"""

trecho = "O Brasil é o país do futebol"

trecho_1 = trecho.split(' ')
trecho_2 = trecho.split(';')

for i in trecho_1:
    qtd_vezes = trecho_1.count(1)
    print(i)

