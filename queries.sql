-- PROJETO: Análise de Vendas e Desvios de Preço (Caso Prático)
-- AUTOR: Juliana Silva

------------------------------------------------------------
-- 1. ESTRUTURAÇÃO DO CENÁRIO (Criação e Inserção de Dados)
------------------------------------------------------------

-- Criar a tabela de vendas
CREATE TABLE vendas_lojas (
    id_venda INT PRIMARY KEY,
    data_venda DATE,
    id_produto VARCHAR(10),
    categoria VARCHAR(50),
    quantidade INT,
    preco_unitario DECIMAL(10, 2)
);

-- Inserir dados de teste (Retalho / E-commerce)
INSERT INTO vendas_lojas (id_venda, data_venda, id_produto, categoria, quantidade, preco_unitario) VALUES
(1001, '2026-10-01', 'P045', 'Vestuário', 2, 29.99),
(1002, '2026-10-01', 'P045', 'Vestuário', 1, 19.99), -- Anomalia: preço diferente no mesmo dia
(1003, '2026-10-02', 'P088', 'Calçado', 1, 79.99),
(1004, '2026-10-02', 'P012', 'Vestuário', 3, 45.00),
(1005, '2026-10-03', 'P099', 'Malas', 1, 120.00),
(1006, '2026-10-03', 'P012', 'Vestuário', 2, 45.00);

------------------------------------------------------------
-- 2. QUERIES ANALÍTICAS (Respostas às Perguntas de Negócio)
------------------------------------------------------------

-- Pergunta A: Identificar produtos vendidos com preços diferentes no mesmo dia (Deteção de Anomalias)
SELECT id_produto, COUNT(DISTINCT preco_unitario) AS total_precos_diferentes
FROM vendas_lojas
GROUP BY id_produto
HAVING COUNT(DISTINCT preco_unitario) > 1;


-- Pergunta B: Calcular a receita total e quantidade vendida por categoria de produto
SELECT categoria, 
       SUM(quantidade) AS total_itens_vendidos,
       SUM(quantidade * preco_unitario) AS receita_total
FROM vendas_lojas
GROUP BY categoria
ORDER BY receita_total DESC;


-- Pergunta C: Filtrar apenas as categorias que geraram mais de 100€ em receita (Ajustado para os dados de teste)
SELECT categoria, SUM(quantidade * preco_unitario) AS receita_total
FROM vendas_lojas
GROUP BY categoria
HAVING SUM(quantidade * preco_unitario) > 100;
