import PyPDF2
import camelot
import pandas as pd
import numpy as np

def extract_data(pdf_file):
    """
    Extrai dados de um arquivo PDF.

    Args:
        pdf_file (str): Caminho para o arquivo PDF.

    Returns:
        pandas.DataFrame: DataFrame contendo os dados extraídos.
    """
    try:
        tables = camelot.read_pdf(pdf_file, flavor='stream')
        if tables:
            df = tables[0].df # Assumir que a tabela relevante é o primeiro
        return df
    except Exception as e:
        print(f"Erro ao extrair tabelas:{e}")

    try:
        # Abrir o PDF
        with open(pdf_file, 'rb') as pdf_reader:
            reader = PyPDF2.PdfReader(pdf_reader)

            # Extrair texto de todas as páginas (ajuste conforme necessário)
            all_text = ''
            for page_num in range(len(reader.pages)):
                page = reader.pages[page_num]
                all_text += page.extract_text()

            # Exemplo simples de extração de dados do texto usando regex
            import re
            pattern = r"(\d{2}/\d{2}/\d{4})\s+(\w+)\s+(d+))"
            matches = re.findall(pattern, all_text)
            df = pd.DataFrame(matches, columns=['data', 'name_empresa', 'cod_vendedor'])

            return
    except Exception as e:
        print(f"Erro ao extrair texto: {e}")

    # Se não conseguir extrair nem tabelas, nem texto, retornar dataframe vazio
    return

# Exemplo de uso
pdf_file = '/home/lrocio@TRE-AC/Documentos/destino/P-2024/tre-ac-portaria-presidencia-99-2024.pdf'
df = extract_data(pdf_file)
print(df)
