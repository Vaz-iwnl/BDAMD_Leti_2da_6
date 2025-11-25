/* TRABALHO PRÁTICO - PARTE II (Interrogações SQL)
   Base de Dados: IsepBricolage
   Alunos: João Vaz e Martim Alves
*/

-- ===============================================================
-- COMANDO ESSENCIAL: Garante que estamos na BD certa!
-- ===============================================================
USE IsepBricolage;
GO

/* 2.1. Artigo mais encomendado e respetivas zonas
   Nota: Como as vendas são registadas por Armazém (e não por secção),
   o artigo mais vendido é calculado para o Armazém inteiro e listado 
   nas zonas desse armazém.
*/
/* 2.1. (VERSÃO POR ZONA FÍSICA REAL)
   Identifica o artigo com maior volume de saídas registado na Guia de Saída
   para CADA zona física individualmente.
*/
USE IsepBricolage;
GO

WITH SaidasPorZona AS (
    -- 1. Somar quantidades retiradas por Zona e Artigo
    SELECT 
        GS.id_zona,
        GS.referencia_artigo,
        SUM(GS.quantidade_retirada) as Total_Retirado
    FROM Guia_Saida_Detalhe GS
    GROUP BY GS.id_zona, GS.referencia_artigo
),
RankingZonas AS (
    -- 2. Calcular o Nº1 de cada Zona
    SELECT 
        id_zona,
        referencia_artigo,
        Total_Retirado,
        RANK() OVER (PARTITION BY id_zona ORDER BY Total_Retirado DESC) as Posicao
    FROM SaidasPorZona
)
-- 3. Apresentar Resultado Final
SELECT 
    A.nome AS Armazem,
    Z.nome_zona AS Zona_Fisica,
    Art.nome AS Produto_Mais_Retirado_Da_Zona,
    RZ.Total_Retirado AS Quantidade
FROM RankingZonas RZ
JOIN Zona_Fisica Z ON RZ.id_zona = Z.id_zona
JOIN Armazem A ON Z.cod_armazem = A.cod_armazem
JOIN Artigo Art ON RZ.referencia_artigo = Art.referencia
WHERE RZ.Posicao = 1
ORDER BY A.nome, Z.nome_zona;


-- ===============================================================
-- 2.2. Armazéns com Stock Completo
-- Pergunta: "Liste o nome dos armazéns que têm em stock todos os artigos 
-- que existem no armazém que possui o maior número de empregados."
-- ===============================================================
SELECT nome AS Armazem_Completo
FROM Armazem A
WHERE NOT EXISTS (
    -- 1. O Conjunto Alvo: Artigos do Armazém com mais empregados
    SELECT referencia_artigo
    FROM Stock_Armazem
    WHERE quantidade_total > 0
      AND cod_armazem = (
          -- Subquery: Encontra o ID do armazém com mais staff
          SELECT TOP 1 cod_armazem
          FROM Funcionario
          GROUP BY cod_armazem
          ORDER BY COUNT(num_funcionario) DESC
      )
    
    EXCEPT -- A "Subtração" Mágica
    
    -- 2. O Conjunto Candidato: Artigos do armazém atual (A)
    SELECT referencia_artigo
    FROM Stock_Armazem
    WHERE cod_armazem = A.cod_armazem
      AND quantidade_total > 0
);
/* Explicação: Usamos a lógica de "Divisão Relacional" com EXCEPT. 
   Se (Artigos do Top Armazém) MENOS (Artigos do Armazém A) for Vazio, 
   significa que o Armazém A tem tudo o que o outro tem. */


-- ===============================================================
-- 2.3. Zonas com Maior Stock (com mensagem personalizada)
-- Pergunta: "Liste as zonas do armazém XPTO com maior stock. 
-- Se for 0, aparecer 'ZONA FISICA SEM STOCK'."
-- ===============================================================
SELECT 
    Z.nome_zona,
    CASE 
        WHEN SUM(S.quantidade_total) = 0 OR SUM(S.quantidade_total) IS NULL 
        THEN 'ZONA FISICA SEM STOCK'
        ELSE CAST(SUM(S.quantidade_total) AS VARCHAR)
    END AS Quantidade_Stock
FROM Zona_Fisica Z
JOIN Armazem A ON Z.cod_armazem = A.cod_armazem
-- Left Join para incluir zonas mesmo que não tenham stock na tabela
LEFT JOIN Stock_Armazem S ON A.cod_armazem = S.cod_armazem
WHERE A.nome = 'Armazém Porto Norte' -- O nosso "XPTO"
GROUP BY Z.nome_zona
-- Filtra apenas a(s) zona(s) que têm o valor MÁXIMO deste armazém
HAVING SUM(S.quantidade_total) >= ALL (
    SELECT ISNULL(SUM(S2.quantidade_total), 0)
    FROM Zona_Fisica Z2
    LEFT JOIN Stock_Armazem S2 ON Z2.cod_armazem = S2.cod_armazem
    JOIN Armazem A2 ON Z2.cod_armazem = A2.cod_armazem
    WHERE A2.nome = 'Armazém Porto Norte'
    GROUP BY Z2.nome_zona
);


-- ===============================================================
-- 2.4. Zonas Cheias (Volume Ocupado)
-- Pergunta: "Liste as zonas que tenham todo o seu volume ocupado."
-- Ordenação: Armazém Crescente, Zona Decrescente.
-- ===============================================================
SELECT 
    A.cod_armazem, 
    Z.nome_zona
FROM Zona_Fisica Z
JOIN Armazem A ON Z.cod_armazem = A.cod_armazem
JOIN Stock_Armazem S ON A.cod_armazem = S.cod_armazem
GROUP BY A.cod_armazem, Z.nome_zona, Z.capacidade_volume
-- Verifica se a Quantidade de Artigos encheu a Capacidade da Zona
-- Nota: Assumimos que 1 unidade de artigo ocupa 1 unidade de volume,
-- pois a tabela Artigo não tem atributo de dimensões.
HAVING SUM(S.quantidade_total) >= Z.capacidade_volume 
ORDER BY A.cod_armazem ASC, Z.nome_zona DESC;