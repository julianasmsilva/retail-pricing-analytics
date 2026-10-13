sql
-- Projeto: Análise de Competitividade de Preços
-- Autor: Juliana Silva

-- QUERY 1: Identificar desvios de preços críticos face à concorrência
SELECT 
    c.id_concorrente,
    p.id_produto,
    p.categoria,
    p.preco_base AS nosso_preco,
    c.preco_concorrente AS preco_mercado,
    ROUND(((p.preco_base - c.preco_concorrente) / p.preco_base) * 100, 2) AS percentagem_desvio
FROM produtos p
JOIN trends_pricing c ON p.id_produto = c.id_produto
WHERE c.preco_concorrente < (p.preco_base * 0.80)
ORDER BY percentagem_desvio DESC;

-- QUERY 2: Obter o preço monitorizado mais recente por produto usando Window Functions
WITH ranking_precos AS (
    SELECT 
        id_produto, 
        id_concorrente,
        preco_concorrente, 
        data_verificacao,
        ROW_NUMBER() OVER(PARTITION BY id_produto, id_concorrente ORDER BY data_verificacao DESC) AS rn
    FROM trends_pricing
)
SELECT id_produto, id_concorrente, preco_concorrente, data_verificacao
FROM ranking_precos
WHERE rn = 1;
