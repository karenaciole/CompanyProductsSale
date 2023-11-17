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
  produtoid,
  SUM(valor) AS venda_valor
FROM 
  FatoDetalhes_DadosModelagem 
GROUP BY 
  produtoid

-- Quantidade e valor das vendas por dia, mês, ano
SELECT
  SUBSTR(data, 1, 2) AS dia,
  SUBSTR(data, 4, 2) AS mes,
  SUBSTR(data, 7, 4) AS ano,
  COUNT(*) AS quantidade_vendas,
  SUM(valor) AS valor_vendas
FROM
  FatoDetalhes_DadosModelagem D
INNER JOIN FatoCabecalho_DadosModelagem C
  ON D.cupomid = C.cupomid
GROUP BY
  ano,
  mes,
  dia

-- Lucro dos meses
SELECT 
  SUBSTR(data, 4, 2) AS mes,
  SUM(valorliquido) as lucro
FROM FatoCabecalho_DadosModelagem C
INNER JOIN FatoDetalhes_DadosModelagem D 
	ON C.cupomid = D.cupomid
GROUP BY 
	mes
	
-- Venda por produto 
SELECT 
  produtoid,
  SUM(quantidade) AS quantidade_vendas
FROM 
  FatoDetalhes_DadosModelagem 
GROUP BY 
  produtoid

-- Venda por cliente, cidade do cliente e estado 
-- não consta campo 'estado', utilizei o campo 'pais'
SELECT 
    D.cliente,
    D.cidade,
    D.pais,
    C.cupomid as quantidade_vendas
 FROM FatoCabecalho_DadosModelagem C
 LEFT JOIN Dimensoes_DadosModelagem D ON 
 	D.clienteid = C.clienteid
 GROUP BY
   D.clienteid
ORDER BY 
   quantidade_vendas
 
-- Média de produtos vendidos
SELECT
  AVG(quantidade) AS media_produtos_vendidos
FROM
   FatoDetalhes_DadosModelagem 

-- Média de compras que um cliente faz
SELECT
  C.clienteid,
  ROUND(AVG(D.quantidade)) AS media_compras_por_cliente
FROM FatoDetalhes_DadosModelagem D
LEFT JOIN FatoCabecalho_DadosModelagem C ON 
  D.cupomid = C.cupomid
GROUP BY 
  C.clienteid
