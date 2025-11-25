/* SCRIPT DE POVOAMENTO FINAL - IsepBricolage
   Grupo: João Vaz e Martim Alves
   Este script popula a BD e gera automaticamente a logística para as queries.
*/

USE IsepBricolage;
GO

-- =================================================================
-- 0. LIMPEZA TOTAL (Ordem correta para evitar erros de FK)
-- =================================================================
DELETE FROM Transporte_Conteudo;
DELETE FROM Transporte;
DELETE FROM Guia_Saida_Detalhe;
DELETE FROM Guia_Saida;
DELETE FROM Nota_Encomenda_Detalhe;
DELETE FROM Nota_Encomenda;
DELETE FROM Stock_Armazem;
DELETE FROM Historico_Preco;
DELETE FROM Funcionario;
-- Nota: Não apagamos Clientes, Artigos, Zonas e Armazéns para manter a estrutura base,
-- mas inserimos apenas se não existirem (ver abaixo).

-- =================================================================
-- 1. ARMAZENS
-- =================================================================
IF NOT EXISTS (SELECT 1 FROM Armazem WHERE cod_armazem = 1)
INSERT INTO Armazem (cod_armazem, nome, morada, loc_geo_wgs84) VALUES
(1, 'Armazém Porto Norte', 'Rua do ISEP, 123, Porto', '41.178, -8.608'),
(2, 'Armazém Lisboa Oriente', 'Av. das Nações, 45, Lisboa', '38.760, -9.100'),
(3, 'Armazém Braga Minho', 'Lugar do Monte, Braga', '41.545, -8.426');

-- =================================================================
-- 2. ZONAS FÍSICAS (30 Zonas compatíveis com a fórmula automática)
-- =================================================================
-- A fórmula usa (Armazem * 100) + (1 a 9), logo precisamos das zonas x01 a x09.
IF NOT EXISTS (SELECT 1 FROM Zona_Fisica WHERE id_zona = 101)
BEGIN
    INSERT INTO Zona_Fisica (id_zona, nome_zona, cod_armazem, capacidade_volume) VALUES
    (101, 'Corredor A', 1, 500), (102, 'Corredor B', 1, 300), (103, 'Corredor C', 1, 1000),
    (104, 'Corredor D', 1, 400), (105, 'Corredor E', 1, 400), (106, 'Corredor F', 1, 400),
    (107, 'Corredor G', 1, 400), (108, 'Corredor H', 1, 400), (109, 'Corredor I', 1, 400), (110, 'Rececao 1', 1, 200),
    
    (201, 'Prateleira A', 2, 200), (202, 'Prateleira B', 2, 2000), (203, 'Prateleira C', 2, 500),
    (204, 'Prateleira D', 2, 500), (205, 'Prateleira E', 2, 500), (206, 'Prateleira F', 2, 500),
    (207, 'Prateleira G', 2, 500), (208, 'Prateleira H', 2, 500), (209, 'Prateleira I', 2, 500), (210, 'Rececao 2', 2, 300),

    (301, 'Zona A', 3, 600), (302, 'Zona B', 3, 600), (303, 'Zona C', 3, 600),
    (304, 'Zona D', 3, 600), (305, 'Zona E', 3, 600), (306, 'Zona F', 3, 600),
    (307, 'Zona G', 3, 600), (308, 'Zona H', 3, 600), (309, 'Zona I', 3, 600), (310, 'Rececao 3', 3, 400);
END

-- =================================================================
-- 3. ARTIGOS (30 Artigos)
-- =================================================================
IF NOT EXISTS (SELECT 1 FROM Artigo WHERE referencia = 1)
BEGIN
    INSERT INTO Artigo (referencia, nome, descricao, preco_compra, preco_venda, unidade) VALUES
    (1, 'Alicate Universal', 'Alicate de 6 polegadas', 3.50, 8.99, 'unidade'),
    (2, 'Chave de Fendas 3mm', 'Aço cromo-vanádio', 1.00, 2.50, 'unidade'),
    (3, 'Chave Philips', 'Ponta magnética', 1.20, 3.00, 'unidade'),
    (4, 'Fita Métrica 5m', 'Com travão', 2.00, 5.50, 'unidade'),
    (5, 'Nível de Bolha', '30cm de comprimento', 4.50, 12.00, 'unidade'),
    (6, 'Serrote de Madeira', 'Dentes temperados', 5.00, 11.50, 'unidade'),
    (7, 'Lixa de Parede 100', 'Pacote de 10', 0.50, 1.50, 'pacote'),
    (8, 'Rolo de Pintura', 'Anti-gota 23cm', 3.00, 7.00, 'unidade'),
    (9, 'Pincel 2 polegadas', 'Cerdas naturais', 1.50, 4.00, 'unidade'),
    (10, 'Fita Isoladora', 'Rolo de 20m preto', 0.30, 1.00, 'unidade'),
    (11, 'Lâmpada LED E27', '10W Luz Branca', 1.50, 3.99, 'unidade'),
    (12, 'Lâmpada LED E14', '5W Luz Amarela', 1.20, 3.50, 'unidade'),
    (13, 'Tomada Dupla', 'Embutir branca', 2.50, 6.50, 'unidade'),
    (14, 'Interruptor Simples', 'Embutir branco', 2.00, 5.00, 'unidade'),
    (15, 'Cabo Elétrico 1.5mm', 'Rolo de 100m', 15.00, 35.00, 'rolo'),
    (16, 'Cabo Elétrico 2.5mm', 'Rolo de 100m', 25.00, 55.00, 'rolo'),
    (17, 'Tubo PVC 32mm', 'Barra de 3m', 2.00, 5.00, 'unidade'),
    (18, 'Curva PVC 32mm', '90 graus', 0.20, 0.60, 'unidade'),
    (19, 'Cola PVC', 'Lata 250ml', 3.00, 7.50, 'lata'),
    (20, 'Torneira de Jardim', 'Metal cromado 1/2', 4.00, 9.90, 'unidade'),
    (21, 'Mangueira 15m', 'Reforçada verde', 8.00, 18.00, 'unidade'),
    (22, 'Aspersor Circular', 'Plástico resistente', 3.50, 8.50, 'unidade'),
    (23, 'Vaso de Barro 30cm', 'Terracota', 2.50, 6.00, 'unidade'),
    (24, 'Terra Vegetal 50L', 'Substrato universal', 3.00, 7.00, 'saco'),
    (25, 'Adubo Líquido', 'Plantas verdes 1L', 4.00, 9.50, 'garrafa'),
    (26, 'Cimento Cola', 'Saco 25kg Interior', 2.50, 5.50, 'saco'),
    (27, 'Argamassa', 'Saco 25kg', 2.00, 4.50, 'saco'),
    (28, 'Tijolo 11', 'Tijolo cerâmico', 0.20, 0.50, 'unidade'),
    (29, 'Telha Lusa', 'Cerâmica vermelha', 0.40, 0.90, 'unidade'),
    (30, 'Impermeabilizante', 'Lata 5kg', 15.00, 35.00, 'lata'),
    (5004, 'Produto espetacular.', 'Teste especial', 500.00, 1200.00, 'unidade');
END

-- =================================================================
-- 4. STOCK (PREPARAÇÃO PARA QUERY 2.2 E 2.3)
-- =================================================================
-- 4.1. Encher tudo primeiro
INSERT INTO Stock_Armazem (cod_armazem, referencia_artigo, stock_minimo, quantidade_total)
SELECT a.cod_armazem, art.referencia, 10, 100
FROM Armazem a
CROSS JOIN Artigo art;

-- 4.2. SABOTAGEM EM BRAGA (Para a Query 2.2 funcionar bem)
-- Removemos artigos 1 e 2 de Braga. Assim, Braga não tem "Stock Completo".
DELETE FROM Stock_Armazem WHERE cod_armazem = 3 AND referencia_artigo IN (1, 2);

-- 4.3. AJUSTE PARA QUERY 2.3 (Stock Baixo/Sem Stock)
UPDATE Stock_Armazem SET quantidade_total = 0 WHERE cod_armazem = 1 AND referencia_artigo = 30;
UPDATE Stock_Armazem SET quantidade_total = 2, stock_minimo = 5 WHERE cod_armazem = 1 AND referencia_artigo = 2;

-- 4.4. AJUSTE PARA QUERY 2.4 (Zona Cheia)
-- Vamos encher a Zona 101 virtualmente dando stock suficiente ao artigo que vai para lá (Artigo 4)
UPDATE Stock_Armazem SET quantidade_total = 500 WHERE cod_armazem = 1 AND referencia_artigo = 4;

-- =================================================================
-- 5. CLIENTES E TRANSPORTADORAS
-- =================================================================
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cod_cliente = 1)
BEGIN
    INSERT INTO Cliente (cod_cliente, nome, morada, codigo_postal, telemovel, nif, zona_geografica, tipo_cliente) VALUES
    (1, 'Antonio Silva', 'Rua A', '4000', '91001', 3001, 'Porto', 'Pequeno'),
    (2, 'Beatriz Costa', 'Rua B', '4000', '91002', 3002, 'Lisboa', 'VIP'),
    (3, 'Carlos Sousa', 'Rua C', '4000', '91003', 3003, 'Braga', 'Grande'),
    (4, 'Diana Oliveira', 'Rua D', '4000', '91004', 3004, 'Porto', 'Pequeno'),
    (5, 'Eduardo Lima', 'Rua E', '4000', '91005', 3005, 'Faro', 'Pequeno'),
    (6, 'Fernando Mendes', 'Rua F', '4000', '91006', 3006, 'Lisboa', 'Grande'),
    (7, 'Gabriela Rocha', 'Rua G', '4000', '91007', 3007, 'Porto', 'VIP'),
    (8, 'Hugo Almeida', 'Rua H', '4000', '91008', 3008, 'Aveiro', 'Pequeno'),
    (9, 'Ines Santos', 'Rua I', '4000', '91009', 3009, 'Coimbra', 'Pequeno'),
    (10, 'Joao Pereira', 'Rua J', '4000', '91010', 3010, 'Porto', 'Grande'),
    -- Adicionar restantes até 30 se necessário, simplificado aqui para não estourar caracteres
    (29, 'Mecânica Total', 'Maia', '4470', '222', 5006, 'Porto', 'Pequeno'),
    (30, 'Pinturas & Ca', 'Gaia', '4430', '256', 5007, 'Porto', 'Pequeno');
END

IF NOT EXISTS (SELECT 1 FROM Transportadora WHERE nif = 900100100)
INSERT INTO Transportadora (nif, nome, contacto_telefonico, custo_hora) VALUES
(900100100, 'Transportes Rápidos SA', '22001', 25.50),
(900200200, 'Levatudo Lda', '21002', 15.00),
(900300300, 'Carga Pesada', '21003', 20.00);

-- =================================================================
-- 7. FUNCIONARIOS (Hierarquia necessária para Query 2.2 e 2.8)
-- =================================================================
INSERT INTO Funcionario (num_funcionario, cartao_cidadao, nome, morada, nif, salario_mensal, categoria, cod_supervisor, cod_armazem) VALUES
(1, 1001, 'Carlos Diretor', 'Porto', 2001, 2500.00, 'Diretor', NULL, 1),
(2, 1002, 'Ana Supervisora', 'Porto', 2002, 1800.00, 'Vendedor', 1, 1),
(3, 1003, 'Bruno Supervisor', 'Lisboa', 2003, 1900.00, 'Vendedor', 1, 2),
(4, 1004, 'David Supervisor', 'Braga', 2004, 1750.00, 'Vendedor', 1, 3),
(10, 1010, 'Rui Vendedor', 'Porto', 2010, 1100.00, 'Vendedor', 2, 1),
(11, 1011, 'Marta Vendedora', 'Porto', 2011, 1150.00, 'Vendedor', 2, 1),
(12, 1012, 'Pedro Armazém', 'Lisboa', 2012, 900.00, 'Fiel de Armazém', 3, 2),
(13, 1013, 'Joana Armazém', 'Braga', 2013, 950.00, 'Fiel de Armazém', 4, 3),
(14, 1014, 'Tiago Vendedor', 'Porto', 2014, 1100.00, 'Vendedor', 2, 1),
(15, 1015, 'Sofia Vendedora', 'Lisboa', 2015, 1200.00, 'Vendedor', 3, 2),
(16, 1016, 'Luis Vendedor', 'Braga', 2016, 1100.00, 'Vendedor', 4, 3);

-- =================================================================
-- 8. HISTÓRICO DE PREÇOS (Para Query 2.6)
-- =================================================================
INSERT INTO Historico_Preco (id_historico, referencia_artigo, preco_antigo, data_inicio, data_fim) VALUES
(1, 5004, 1000.00, '2014-01-01', '2015-12-31'),
(2, 5004, 1200.00, '2016-01-01', NULL);

-- =================================================================
-- 9. CICLO AUTOMÁTICO (ENCOMENDAS -> GUIAS -> ZONAS)
-- =================================================================

-- 9.1 Inserir Encomendas
INSERT INTO Nota_Encomenda (num_encomenda, data_encomenda, cod_cliente, num_vendedor, estado) VALUES
(501, '2015-05-20', 1, 10, 'Processada'),
(502, '2018-06-15', 2, 12, 'Processada'),
(503, '2025-11-18', 1, 10, 'Pendente'),
(504, '2018-03-01', 3, 13, 'Processada'),
(505, '2018-03-05', 4, 10, 'Pendente'),
(506, '2018-04-10', 5, 10, 'Pendente'),
(507, '2018-10-10', 6, 12, 'Processada'),
(508, '2019-01-15', 7, 10, 'Processada'),
(511, '2024-01-01', 10, 14, 'Processada');

-- 9.2 Inserir Detalhes (Vendas)
INSERT INTO Nota_Encomenda_Detalhe (num_encomenda, referencia_artigo, quantidade) VALUES
(501, 4, 200), (502, 1, 10), (503, 2, 200), 
(504, 3, 5), (505, 2, 50), (506, 5, 100), 
(507, 6, 2), (508, 1, 20), (511, 4, 500); -- Venda grande de Artigo 4 no Porto

-- 9.3 Gerar Guias Automaticamente
INSERT INTO Guia_Saida (id_guia, data_guia, num_encomenda_origem, func_responsavel)
SELECT num_encomenda + 5000, DATEADD(DAY, 1, data_encomenda), num_encomenda, num_vendedor
FROM Nota_Encomenda WHERE estado = 'Processada';

-- 9.4 Gerar Detalhes da Guia (DISTRIBUIÇÃO NAS ZONAS)
-- Esta fórmula mágica garante que a Query 2.1 mostra zonas diferentes
INSERT INTO Guia_Saida_Detalhe (id_guia, referencia_artigo, id_zona, quantidade_retirada)
SELECT 
    GS.id_guia,
    NED.referencia_artigo,
    (F.cod_armazem * 100) + (NED.referencia_artigo % 9) + 1, -- Fórmula: Armazem 1 -> Zonas 1xx
    NED.quantidade
FROM Nota_Encomenda_Detalhe NED
JOIN Nota_Encomenda NE ON NED.num_encomenda = NE.num_encomenda
JOIN Guia_Saida GS ON NE.num_encomenda = GS.num_encomenda_origem
JOIN Funcionario F ON NE.num_vendedor = F.num_funcionario;

-- 9.5 Gerar Transporte
INSERT INTO Transporte (id_transporte, nif_transportadora, cod_cliente_destino, data_transporte, num_horas_utilizacao)
SELECT id_guia + 9000, 900100100, NE.cod_cliente, DATEADD(HOUR, 2, data_guia), 2.5
FROM Guia_Saida GS JOIN Nota_Encomenda NE ON GS.num_encomenda_origem = NE.num_encomenda;

<<<<<<< Updated upstream
INSERT INTO Transporte_Conteudo (id_transporte, id_guia) VALUES
(901, 801);


=======
INSERT INTO Transporte_Conteudo (id_transporte, id_guia)
SELECT id_guia + 9000, id_guia FROM Guia_Saida;
>>>>>>> Stashed changes
