-- Valor total das vendas e dos fretes por produto e ordem de venda
SELECT
  produtoid,
  C.data AS data_vendas,
  clienteid,
  SUM(valor) AS valor_vendas,
  SUM(valorfrete) AS valor_frete
FROM
  FatoDetalhes_DadosModelagem D
INNER JOIN FatoCabecalho_DadosModelagem C
  ON D.cupomid = C.cupomid
GROUP BY
  produtoid
ORDER BY
	SUBSTR(data_vendas, 7, 4) || '/' || SUBSTR(data_vendas, 4, 2) || '/' || SUBSTR(data_vendas, 1, 2) 

-- Valor de venda por tipo de produto
-- (não há campo de tipo de produto ou semelhante, entao usei o campo 'produtoid')
SELECT 
  DISTINCT(produtoid),
  SUM(valor) AS venda_valor
FROM 
  FatoDetalhes_DadosModelagem 
GROUP BY 
  produtoid

-- Quantidade e valor das vendas por dia, mês, ano

-- Lucro dos meses
-- Venda por produto
-- Venda por cliente, cidade do cliente e estado
-- Média de produtos vendidos
-- Média de compras que um cliente faz
