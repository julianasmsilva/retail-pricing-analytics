sql
-- PROJETO: Análise de Vendas e Desvios de Preço (Caso Prático)
-- AUTOR: Juliana Silva

-- 1. Identificar produtos que foram vendidos com preços diferentes no mesmo dia
SELECT id_produto, COUNT(DISTINCT preco_unitario) AS total_precos_diferentes
FROM vendas_lojas
GROUP BY id_produto
HAVING COUNT(DISTINCT preco_unitario) > 1;


-- 2. Calcular a receita total e quantidade vendida por categoria de produto
SELECT categoria, 
       SUM(quantidade) AS total_itens_vendidos,
       SUM(quantidade * preco_unitario) AS receita_total
FROM vendas_lojas
GROUP BY categoria
ORDER BY receita_total DESC;


-- 3. Filtrar apenas as categorias que geraram mais de 5.000€ em receita
SELECT categoria, SUM(quantidade * preco_unitario) AS receita_total
FROM vendas_lojas
GROUP BY categoria
HAVING SUM(quantidade * preco_unitario) > 5000;
