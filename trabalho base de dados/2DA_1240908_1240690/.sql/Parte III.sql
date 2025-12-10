USE IsepBricolage
GO

/*
3.1 Liste o nome do cliente, o nome da transportadora e o custo total estimado (horas × custo/hora) 
para todos os transportes realizados para clientes do tipo 'VIP', onde o custo por hora da 
transportadora utilizada é superior à média do custo por hora de todas as transportadoras registadas.
*/

    SELECT 
    C.nome AS Nome_Cliente,
    T.nome AS Nome_Transportadora,
    (Tr.num_horas_utilizacao * T.custo_hora) AS Custo_Total_Servico
FROM 
    Transporte Tr
JOIN 
    Transportadora T ON Tr.nif_transportadora = T.nif
JOIN 
    Cliente C ON Tr.cod_cliente_destino = C.cod_cliente
WHERE 
    C.tipo_cliente = 'VIP'
    AND T.custo_hora > (
        SELECT 
            AVG(custo_hora)
        FROM 
            Transportadora
    );

/*
 3.2 Liste a referência do artigo, o nome do artigo e a quantidade atual em stock para todos os 
 artigos armazenados no 'Armazém Porto Norte' cuja quantidade em stock é superior à média da 
 quantidade em stock desse mesmo artigo em todos os outros armazéns da empresa.
*/

    SELECT 
    A.referencia AS Referencia_Artigo,
    A.nome AS Nome_Artigo,
    NED.quantidade
FROM 
    Artigo A
JOIN 
    Nota_Encomenda_Detalhe NED ON A.referencia = NED.referencia_artigo
JOIN 
    Nota_Encomenda NE ON NED.num_encomenda = NE.num_encomenda
WHERE 
    NED.quantidade > 5
    AND A.preco_venda > (
        SELECT 
            AVG(preco_venda)
        FROM 
            Artigo
    );

/*
3.3 Listar o nome, salário e contagem de encomendas para vendedores cujo salário é
inferior ao salário médio dos funcionários do seu armazém.
*/
SELECT
    F.nome AS Nome_Vendedor,
    F.salario_mensal AS Salario_Mensal,
    COUNT(NE.num_encomenda) AS Num_Encomendas_Processadas
FROM
    Funcionario F
JOIN
    Nota_Encomenda NE ON F.num_funcionario = NE.num_vendedor
WHERE
    F.categoria = 'Vendedor'
    AND F.salario_mensal < ( 
        SELECT
            AVG(salario_mensal)
        FROM
            Funcionario 
        WHERE
            categoria = 'Vendedor'
    )
GROUP BY
    F.nome, F.salario_mensal
GO