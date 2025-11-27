use IsepBricolage
go

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
3.3 Listar o nome do artigo, referencia e a quantidade atual em stock para todos os artigos
que estão em stock crítico (quantidade em stock <= stock mínimo) no 'Armazém Braga Minho'.
*/
SELECT
    A.nome AS Nome_Artigo,
    SA.referencia_artigo AS Referencia_Artigo,
    SA.quantidade_total AS Stock_Atual,
    SA.stock_minimo AS Stock_Minimo
FROM
    Artigo A
JOIN
    Stock_Armazem SA ON A.referencia = SA.referencia_artigo
JOIN
    Armazem Ar ON SA.cod_armazem = Ar.cod_armazem
WHERE
    Ar.nome = 'Armazém Braga Minho' 
    AND SA.quantidade_total <= SA.stock_minimo 
ORDER BY
    SA.quantidade_total ASC;
GO