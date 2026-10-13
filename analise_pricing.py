python
import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import os

# 1. GERAR DADOS FICTÍCIOS DE RETALHO/PRICING
np.random.seed(42)
n_linhas = 500
categorias = ['Vestuário', 'Calçado', 'Acessórios', 'Malas']

produtos_id = [f'P{str(i).zfill(3)}' for i in range(1, 51)]
dados_produtos = {
    'id_produto': produtos_id,
    'categoria': np.random.choice(categorias, 50),
    'preco_base': np.random.uniform(20.0, 300.0, 50).round(2)
}
df_produtos = pd.DataFrame(dados_produtos)

# Gerar histórico de monitorização de concorrentes (com anomalias de preço)
data_inicio = datetime(2026, 10, 1)
dados_concorrentes = []
for i in range(n_linhas):
    prod = df_produtos.sample(1).iloc[0]
    # Simular que 15% das vezes o preço do concorrente está anomalamente baixo ou diferente
    if np.random.rand() < 0.15:
        preco_conc = round(prod['preco_base'] * np.random.choice([0.5, 0.7, 1.3]), 2)
    else:
        preco_conc = round(prod['preco_base'] * np.random.uniform(0.95, 1.05), 2)
        
    dados_concorrentes.append({
        'id_concorrente': np.random.choice(['C_Zara', 'C_Farfetch_Comp', 'C_Asos']),
        'id_produto': prod['id_produto'],
        'preco_concorrente': preco_conc,
        'data_verificacao': (data_inicio + timedelta(days=int(np.random.randint(0, 12)))).strftime('%Y-%m-%d')
    })
df_concorrentes = pd.DataFrame(dados_concorrentes)

# 2. ANÁLISE AUTOMATIZADA EM PANDAS (SIMULANDO EFICIÊNCIA DE ESCALA)
# Cruzar os dados dos nossos produtos com os preços recolhidos da concorrência
df_analise = pd.merge(df_concorrentes, df_produtos, on='id_produto', how='inner')

# Identificar desvios críticos de preço (onde o concorrente está > 20% mais barato)
df_analise['desvio_percentual'] = ((df_analise['preco_base'] - df_analise['preco_concorrente']) / df_analise['preco_base']) * 100
alertas_pricing = df_analise[df_analise['desvio_percentual'] >= 20.0]

print(f"✅ Pipeline executado com sucesso!")
print(f"📊 Total de registos processados automaticamente: {len(df_analise)}")
print(f"⚠️ Alertas críticos de pricing identificados de forma automatizada: {len(alertas_pricing)}")

# Exportar os dados gerados para uma pasta local
os.makedirs('data', exist_ok=True)
df_produtos.to_csv('data/produtos.csv', index=False)
df_concorrentes.to_csv('data/concorrentes_pricing.csv', index=False)
print("💾 Ficheiros de dados guardados com sucesso na pasta 'data/'.")
