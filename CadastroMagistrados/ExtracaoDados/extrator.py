import csv
from bs4 import BeautifulSoup

# Ler o arquivo HTML
with open('FormCadMagistrados.html', 'r', encoding='utf-8') as file:
    html_content = file.read()

# Parsear o HTML
soup = BeautifulSoup(html_content, 'html.parser')

# Lista para armazenar os dados
data = []

# Extrair os dados
for div in soup.find_all('div', style=lambda value: value and 'position:absolute' in value):
    text = div.get_text(strip=True)
    if text:
        data.append(text)

# Organizar os dados em um formato CSV
# Aqui, você precisará ajustar a lógica para extrair os campos específicos
# Este é um exemplo básico e pode precisar de ajustes dependendo da estrutura do HTML

# Exemplo de como organizar os dados em um CSV
with open('output.csv', 'w', newline='', encoding='utf-8') as csvfile:
    csvwriter = csv.writer(csvfile)
    # Escrever o cabeçalho
    csvwriter.writerow(['Matrícula', 'Nome', 'Data de Nascimento', 'CPF', 'PIS/PASEP', 'RG', 'Órgão Expedidor', 'UF', 'Logradouro', 'Bairro', 'Cidade', 'CEP', 'Data de Ingresso', 'Situação', 'Tipo de Servidor'])
    
    # Escrever os dados
    # Aqui, você precisará iterar sobre os dados extraídos e organizá-los nas colunas corretas
    # Este é um exemplo básico e pode precisar de ajustes
    for i in range(0, len(data), 15):  # Ajuste o número de campos conforme necessário
        row = data[i:i+15]  # Ajuste o número de campos conforme necessário
        csvwriter.writerow(row)

print("Arquivo CSV gerado com sucesso!")