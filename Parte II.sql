/* ===============================================================
   SCRIPT 3: INTERROGAÇÕES (DQL)
   Ficheiro: Parte II.sql
   =============================================================== */
USE IsepBricolage;
GO

/* 2.1. Artigo mais encomendado e respetivas zonas */
WITH SaidasPorZona AS (
    SELECT 
        GS.id_zona,
        GS.referencia_artigo,
        SUM(GS.quantidade_retirada) as Total_Retirado
    FROM Guia_Saida_Detalhe GS
    GROUP BY GS.id_zona, GS.referencia_artigo
),
RankingZonas AS (
    SELECT 
        id_zona,
        referencia_artigo,
        Total_Retirado,
        RANK() OVER (PARTITION BY id_zona ORDER BY Total_Retirado DESC) as Posicao
    FROM SaidasPorZona
)
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

/* 2.2. Armazéns com Stock Completo */
SELECT nome AS Armazem_Completo
FROM Armazem A
WHERE NOT EXISTS (
    SELECT referencia_artigo
    FROM Stock_Armazem
    WHERE quantidade_total > 0
      AND cod_armazem = (
          SELECT TOP 1 cod_armazem
          FROM Funcionario
          GROUP BY cod_armazem
          ORDER BY COUNT(num_funcionario) DESC
      )
    EXCEPT
    SELECT referencia_artigo
    FROM Stock_Armazem
    WHERE cod_armazem = A.cod_armazem
      AND quantidade_total > 0
);

/* 2.3. Zonas com Maior Stock */
SELECT 
    Z.nome_zona,
    CASE 
        WHEN SUM(S.quantidade_total) = 0 OR SUM(S.quantidade_total) IS NULL 
        THEN 'ZONA FISICA SEM STOCK'
        ELSE CAST(SUM(S.quantidade_total) AS VARCHAR)
    END AS Quantidade_Stock
FROM Zona_Fisica Z
JOIN Armazem A ON Z.cod_armazem = A.cod_armazem
LEFT JOIN Stock_Armazem S ON A.cod_armazem = S.cod_armazem
WHERE A.nome = 'Armazém Porto Norte'
GROUP BY Z.nome_zona
HAVING SUM(S.quantidade_total) >= ALL (
    SELECT ISNULL(SUM(S2.quantidade_total), 0)
    FROM Zona_Fisica Z2
    LEFT JOIN Stock_Armazem S2 ON Z2.cod_armazem = S2.cod_armazem
    JOIN Armazem A2 ON Z2.cod_armazem = A2.cod_armazem
    WHERE A2.nome = 'Armazém Porto Norte'
    GROUP BY Z2.nome_zona
);

/* 2.4. Zonas Cheias (Volume Ocupado) */
SELECT 
    A.cod_armazem, 
    Z.nome_zona
FROM Zona_Fisica Z
JOIN Armazem A ON Z.cod_armazem = A.cod_armazem
JOIN Stock_Armazem S ON A.cod_armazem = S.cod_armazem
GROUP BY A.cod_armazem, Z.nome_zona, Z.capacidade_volume
HAVING SUM(S.quantidade_total) >= Z.capacidade_volume 
ORDER BY A.cod_armazem ASC, Z.nome_zona DESC;

/* 2.5. Armazéns com mais encomendas pendentes */
SELECT
    A.nome AS Nome_Armazem,
    COUNT(NE.num_encomenda) AS Total_Pendentes
FROM
    Armazem A
JOIN
    Funcionario F ON A.cod_armazem = F.cod_armazem
JOIN
    Nota_Encomenda NE ON F.num_funcionario = NE.num_vendedor
WHERE
    NE.estado = 'Pendente' 
    AND NE.data_encomenda BETWEEN '2018-03-01' AND '2018-10-15'
GROUP BY
    A.cod_armazem, A.nome
HAVING
    COUNT(NE.num_encomenda) > (
        SELECT MAX(Contagem_Porto.Total_Pendentes_Porto)
        FROM (
            SELECT COUNT(NE_Porto.num_encomenda) AS Total_Pendentes_Porto
            FROM Armazem A_Porto
            JOIN Funcionario F_Porto ON A_Porto.cod_armazem = F_Porto.cod_armazem
            JOIN Nota_Encomenda NE_Porto ON F_Porto.num_funcionario = NE_Porto.num_vendedor
            WHERE (A_Porto.morada LIKE '%Porto%' OR A_Porto.loc_geo_wgs84 LIKE '%Porto%')
              AND NE_Porto.estado = 'Pendente'
              AND NE_Porto.data_encomenda BETWEEN '2018-03-01' AND '2018-10-15'
            GROUP BY A_Porto.cod_armazem
        ) AS Contagem_Porto
    )
ORDER BY
    Total_Pendentes DESC;

/* 2.6. Vendedores Ricos em 2015 */
SELECT
    F.num_funcionario,
    F.nome,
    A.loc_geo_wgs84 AS zona_geografica 
FROM
    Funcionario F
JOIN 
    Armazem A ON F.cod_armazem = A.cod_armazem
WHERE
    F.categoria = 'Vendedor'
    AND F.num_funcionario IN (
        SELECT
            NE.num_vendedor
        FROM
            Nota_Encomenda NE
        JOIN
            Nota_Encomenda_Detalhe NED ON NE.num_encomenda = NED.num_encomenda
        JOIN
            Historico_Preco HP ON NED.referencia_artigo = HP.referencia_artigo
        WHERE
            YEAR(NE.data_encomenda) = 2015
            AND NE.data_encomenda BETWEEN HP.data_inicio AND ISNULL(HP.data_fim, '9999-12-31')
        GROUP BY
            NE.num_encomenda, NE.num_vendedor
        HAVING
            SUM(NED.quantidade * HP.preco_antigo) > 1000
    )
    AND F.num_funcionario NOT IN (
        SELECT
            NE_Excluir.num_vendedor
        FROM
            Nota_Encomenda NE_Excluir
        JOIN
            Nota_Encomenda_Detalhe NED_Excluir ON NE_Excluir.num_encomenda = NED_Excluir.num_encomenda
        JOIN
            Artigo Art ON NED_Excluir.referencia_artigo = Art.referencia
        WHERE
            Art.nome = 'Produto espetacular.'
    )
ORDER BY
    F.num_funcionario;

/* 2.7. Volume Mensal 2019 */
SELECT
    A.nome AS Nome_Produto,
    MONTH(NE.data_encomenda) AS Mes_Encomenda,
    SUM(NED.quantidade) AS Volume_Mensal_Encomendas
FROM
    Artigo A
JOIN
    Nota_Encomenda_Detalhe NED ON A.referencia = NED.referencia_artigo
JOIN
    Nota_Encomenda NE ON NED.num_encomenda = NE.num_encomenda
JOIN
    Funcionario F ON NE.num_vendedor = F.num_funcionario
WHERE
    YEAR(NE.data_encomenda) = 2019
    AND A.referencia IN (
        SELECT
            SA.referencia_artigo
        FROM
            Stock_Armazem SA
        WHERE
            SA.quantidade_total >= (SA.stock_minimo * 1.5) 
            AND SA.cod_armazem = F.cod_armazem
    )
GROUP BY
    A.nome, MONTH(NE.data_encomenda)
ORDER BY
    A.nome, Mes_Encomenda;

/* 2.8. Empregado vs Supervisores */
SELECT
    F_NS.nome
FROM
    Funcionario F_NS 
JOIN
    Nota_Encomenda NE_NS ON F_NS.num_funcionario = NE_NS.num_vendedor
WHERE
    F_NS.num_funcionario NOT IN (
        SELECT DISTINCT cod_supervisor FROM Funcionario WHERE cod_supervisor IS NOT NULL
    )
GROUP BY
    F_NS.num_funcionario, F_NS.nome
HAVING
    COUNT(NE_NS.num_encomenda) > (
        SELECT MAX(Contagem_Encomendas)
        FROM (
            SELECT
                COUNT(NE_S.num_encomenda) AS Contagem_Encomendas
            FROM
                Funcionario F_S
            JOIN
                Nota_Encomenda NE_S ON F_S.num_funcionario = NE_S.num_vendedor
            WHERE
                F_S.num_funcionario IN (
                    SELECT DISTINCT cod_supervisor FROM Funcionario WHERE cod_supervisor IS NOT NULL
                )
                AND F_S.salario_mensal BETWEEN 1000 AND 3000
            GROUP BY
                F_S.num_funcionario
        ) AS Contagem_Supervisores
    );

/* 2.9. Guias com Atraso */
SELECT
    GS.id_guia
FROM
    Guia_Saida GS
JOIN
    Nota_Encomenda NE ON GS.num_encomenda_origem = NE.num_encomenda
WHERE
    GS.data_guia BETWEEN '2018-06-01 00:00:00' AND '2018-08-31 23:59:59'
    AND DATEPART(HOUR, GS.data_guia) < 10
    AND DATEDIFF(DAY, NE.data_encomenda, GS.data_guia) > 10
ORDER BY
    GS.id_guia;