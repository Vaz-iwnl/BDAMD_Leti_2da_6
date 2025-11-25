USE IsepBricolage
GO
--2.5
SELECT
    A.nome AS Nome_Armazem,
    COUNT(NE.num_encomenda) AS Total_Pendentes
FROM
    Armazem A
JOIN
    Nota_Encomenda NE ON A.cod_armazem = NE.cod_armazem
WHERE
    NE.estado = 'Pendente' 
    AND NE.data_encomenda BETWEEN '2018-03-01' AND '2018-10-15'
GROUP BY
    A.cod_armazem, A.nome
HAVING
    COUNT(NE.num_encomenda) > (
        SELECT
            MAX(Contagem_Porto.Total_Pendentes_Porto)
        FROM
            (
                SELECT
                    COUNT(NE_Porto.num_encomenda) AS Total_Pendentes_Porto
                FROM
                    Armazem A_Porto
                JOIN
                    Nota_Encomenda NE_Porto ON A_Porto.cod_armazem = NE_Porto.cod_armazem
                WHERE
                    A_Porto.morada LIKE '%Porto%' -- Armazéns do Porto
                    AND NE_Porto.estado = 'Pendente'
                    AND NE_Porto.data_encomenda BETWEEN '2018-03-01' AND '2018-10-15'
                GROUP BY
                    A_Porto.cod_armazem
            ) AS Contagem_Porto
    )
ORDER BY
    Total_Pendentes DESC;



--2.6
    SELECT
    F.num_funcionario,
    F.nome,
    F.zona_geografica
FROM
    Funcionario F
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
            EXTRACT(YEAR FROM NE.data_encomenda) = 2015
            AND NE.data_encomenda BETWEEN HP.data_inicio AND COALESCE(HP.data_fim, '9999-12-31')
        GROUP BY
            NE.num_encomenda, NE.num_vendedor
        HAVING
            SUM(NED.quantidade * HP.preco_venda) > 1000
    )

    AND F.num_funcionario NOT IN (
        SELECT
            NE_Excluir.num_vendedor
        FROM
            Nota_Encomenda NE_Excluir
        JOIN
            Nota_Encomenda_Detalhe NED_Excluir ON NE_Excluir.num_encomenda = NED_Excluir.num_encomenda
        JOIN
            Artigo A ON NED_Excluir.referencia_artigo = A.referencia
        WHERE
            A.nome = 'Produto espetacular.'
    )
ORDER BY
    F.num_funcionario;


--2.7
    SELECT
    A.nome AS Nome_Produto,
    EXTRACT(MONTH FROM NE.data_encomenda) AS Mes_Encomenda,
    SUM(NED.quantidade) AS Volume_Mensal_Encomendas
FROM
    Artigo A
JOIN
    Nota_Encomenda_Detalhe NED ON A.referencia = NED.referencia_artigo
JOIN
    Nota_Encomenda NE ON NED.num_encomenda = NE.num_encomenda
WHERE
    EXTRACT(YEAR FROM NE.data_encomenda) = 2019
    AND A.referencia IN (
        SELECT
            SA.referencia_artigo
        FROM
            Stock_Armazem SA
        WHERE
            SA.quantidade_stock >= (SA.quantidade_stock_minimo * 1.5)
            AND SA.cod_armazem = NE.cod_armazem
    )
GROUP BY
    A.nome, EXTRACT(MONTH FROM NE.data_encomenda)
ORDER BY
    A.nome, Mes_Encomenda;



--2.8
    SELECT
    F_NS.nome
FROM
    Funcionario F_NS 
JOIN
    Nota_Encomenda NE_NS ON F_NS.num_funcionario = NE_NS.num_funcionario
WHERE
    F_NS.num_funcionario NOT IN (
        SELECT DISTINCT cod_supervisor FROM Funcionario WHERE cod_supervisor IS NOT NULL
    )
GROUP BY
    F_NS.num_funcionario, F_NS.nome
HAVING
    -- 2. O total de encomendas é MAIOR que o máximo de encomendas de QUALQUER supervisor alvo
    COUNT(NE_NS.num_encomenda) > (
        -- Encontrar o Máximo de Encomendas dos Supervisores Alvo (Salário 1000-3000)
        SELECT
            MAX(Contagem_Encomendas)
        FROM
            (
                -- Contar as encomendas de CADA Supervisor Alvo
                SELECT
                    COUNT(NE_S.num_encomenda) AS Contagem_Encomendas
                FROM
                    Funcionario F_S -- Funcionário Supervisor
                JOIN
                    Nota_Encomenda NE_S ON F_S.num_funcionario = NE_S.num_funcionario
                WHERE
                    -- O funcionário É supervisor
                    F_S.num_funcionario IN (
                        SELECT DISTINCT cod_supervisor FROM Funcionario WHERE cod_supervisor IS NOT NULL
                    )
                    -- O salário está entre 1000€ e 3000€
                    AND F_S.salario_mensal BETWEEN 1000 AND 3000
                GROUP BY
                    F_S.num_funcionario
            ) AS Contagem_Supervisores
    );


--2.9
    SELECT
    GS.id_guia
FROM
    Guia_Saida GS
JOIN
    Nota_Encomenda NE ON GS.num_encomenda_origem = NE.num_encomenda
WHERE
    -- 1. Guia emitida entre Junho e Agosto de 2018
    GS.data_guia BETWEEN '2018-06-01 00:00:00' AND '2018-08-31 23:59:59'

    AND
    -- 2. Hora de elaboração inferior às 10h da manhã
    EXTRACT(HOUR FROM GS.data_guia) < 10

    AND
    -- 3. Diferença entre datas superior a 10 dias
    -- (A sintaxe de subtração de datas depende do SGBD - assumindo PostgreSQL ou compatível)
    (
        CAST(GS.data_guia AS DATE) - NE.data_encomenda
    ) > 10
ORDER BY
    GS.id_guia;