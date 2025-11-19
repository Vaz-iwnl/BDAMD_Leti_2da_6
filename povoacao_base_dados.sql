/* SCRIPT DE POVOAMENTO COMPLETO - IsepBricolage
   Estado: Final (30+ tuplos por tabela)
*/

USE IsepBricolage;
GO

-- ==========================================
-- 1. ARMAZENS (3 Inseridos)
-- ==========================================
-- Verifica se já existe o ID 1, se não existir, insere.
IF NOT EXISTS (SELECT 1 FROM Armazem WHERE cod_armazem = 1)
INSERT INTO Armazem (cod_armazem, nome, morada, loc_geo_wgs84) VALUES
(1, 'Armazém Porto Norte', 'Rua do ISEP, 123, Porto', '41.178, -8.608'),
(2, 'Armazém Lisboa Oriente', 'Av. das Nações, 45, Lisboa', '38.760, -9.100'),
(3, 'Armazém Braga Minho', 'Lugar do Monte, Braga', '41.545, -8.426');

-- ==========================================
-- 2. ZONAS FÍSICAS (30 Inseridas)
-- ==========================================
IF NOT EXISTS (SELECT 1 FROM Zona_Fisica WHERE id_zona = 101)
BEGIN
    INSERT INTO Zona_Fisica (id_zona, nome_zona, cod_armazem, capacidade_volume) VALUES
    (101, 'Corredor A - Ferragens', 1, 500.00),
    (102, 'Corredor B - Tintas', 1, 300.00),
    (103, 'Zona Externa - Jardim', 1, 1000.00),
    (104, 'Corredor C', 1, 400.00), (105, 'Corredor D', 1, 400.00),
    (106, 'Corredor E', 1, 400.00), (107, 'Corredor F', 1, 400.00),
    (108, 'Corredor G', 1, 400.00), (109, 'Corredor H', 1, 400.00),
    (110, 'Armazem 1 - Rececao', 1, 200.00),
    (201, 'Prateleira 1 - Eletrónica', 2, 200.00),
    (202, 'Zona Cargas Pesadas', 2, 2000.00),
    (203, 'Corredor A2', 2, 500.00), (204, 'Corredor B2', 2, 500.00),
    (205, 'Corredor C2', 2, 500.00), (206, 'Corredor D2', 2, 500.00),
    (207, 'Corredor E2', 2, 500.00), (208, 'Corredor F2', 2, 500.00),
    (209, 'Corredor G2', 2, 500.00), (210, 'Armazem 2 - Rececao', 2, 300.00),
    (301, 'Zona A', 3, 600.00), (302, 'Zona B', 3, 600.00),
    (303, 'Zona C', 3, 600.00), (304, 'Zona D', 3, 600.00),
    (305, 'Zona E', 3, 600.00), (306, 'Zona F', 3, 600.00),
    (307, 'Zona G', 3, 600.00), (308, 'Zona H', 3, 600.00),
    (309, 'Zona I', 3, 600.00), (310, 'Armazem3 - Rececao', 3, 400.00);
END

-- ==========================================
-- 3. ARTIGOS (30 Inseridos)
-- ==========================================
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
    (5004, 'Produto espetacular.', 'Teste especial', 500.00, 1200.00, 'unidade'); -- Para query 2.6
END

-- ==========================================
-- 4. STOCK_ARMAZEM (90+ Linhas Inseridas)
-- ==========================================
DELETE FROM Stock_Armazem;

INSERT INTO Stock_Armazem (cod_armazem, referencia_artigo, stock_minimo, quantidade_total)
SELECT a.cod_armazem, art.referencia, 10, 100
FROM Armazem a
CROSS JOIN Artigo art;

UPDATE Stock_Armazem SET quantidade_total = 2, stock_minimo = 5
WHERE cod_armazem = 1 AND referencia_artigo = 2;


-- ==========================================
-- 5. CLIENTES (30 Inseridos)
-- ==========================================
IF NOT EXISTS (SELECT 1 FROM Cliente WHERE cod_cliente = 1)
BEGIN
    INSERT INTO Cliente (cod_cliente, nome, morada, codigo_postal, telemovel, nif, zona_geografica, tipo_cliente) VALUES
    (1, 'Antonio Silva', 'Rua A, 1', '4000-001', '910000001', 300000001, 'Porto', 'Pequeno'),
    (2, 'Beatriz Costa', 'Rua B, 2', '4000-002', '910000002', 300000002, 'Lisboa', 'VIP'),
    (3, 'Carlos Sousa', 'Rua C, 3', '4000-003', '910000003', 300000003, 'Braga', 'Grande'),
    (4, 'Diana Oliveira', 'Rua D, 4', '4000-004', '910000004', 300000004, 'Porto', 'Pequeno'),
    (5, 'Eduardo Lima', 'Rua E, 5', '4000-005', '910000005', 300000005, 'Faro', 'Pequeno'),
    (6, 'Fernando Mendes', 'Rua F, 6', '4000-006', '910000006', 300000006, 'Lisboa', 'Grande'),
    (7, 'Gabriela Rocha', 'Rua G, 7', '4000-007', '910000007', 300000007, 'Porto', 'VIP'),
    (8, 'Hugo Almeida', 'Rua H, 8', '4000-008', '910000008', 300000008, 'Aveiro', 'Pequeno'),
    (9, 'Ines Santos', 'Rua I, 9', '4000-009', '910000009', 300000009, 'Coimbra', 'Pequeno'),
    (10, 'Joao Pereira', 'Rua J, 10', '4000-010', '910000010', 300000010, 'Porto', 'Grande'),
    (11, 'Lara Martins', 'Rua L, 11', '4000-011', '910000011', 300000011, 'Lisboa', 'VIP'),
    (12, 'Manuel Ferreira', 'Rua M, 12', '4000-012', '910000012', 300000012, 'Braga', 'Pequeno'),
    (13, 'Nuno Rodrigues', 'Rua N, 13', '4000-013', '910000013', 300000013, 'Porto', 'Grande'),
    (14, 'Olivia Gomes', 'Rua O, 14', '4000-014', '910000014', 300000014, 'Setubal', 'Pequeno'),
    (15, 'Alvaro Campos', 'Rua P, 15', '4000-015', '910000015', 300000015, 'Lisboa', 'Pequeno'),
    (16, 'Antonio Vieira', 'Rua Q, 16', '4000-016', '910000016', 300000016, 'Porto', 'VIP'),
    (17, 'Ricardo Reis', 'Rua R, 17', '4000-017', '910000017', 300000017, 'Viseu', 'Grande'),
    (18, 'Sara Ribeiro', 'Rua S, 18', '4000-018', '910000018', 300000018, 'Porto', 'Pequeno'),
    (19, 'Tiago Pinto', 'Rua T, 19', '4000-019', '910000019', 300000019, 'Lisboa', 'Pequeno'),
    (20, 'Ursula Matos', 'Rua U, 20', '4000-020', '910000020', 300000020, 'Leiria', 'VIP'),
    (21, 'Vasco Fernandes', 'Rua V, 21', '4000-021', '910000021', 300000021, 'Porto', 'Grande'),
    (22, 'Xavier Correia', 'Rua X, 22', '4000-022', '910000022', 300000022, 'Faro', 'Pequeno'),
    (23, 'Zulmira Dias', 'Rua Z, 23', '4000-023', '910000023', 300000023, 'Lisboa', 'Pequeno'),
    (24, 'Paulo Bastos', 'Zona Ind 1', '4000-024', '910000024', 500000001, 'Porto', 'Grande'),
    (25, 'Quim Barreiros', 'Zona Ind 2', '4400-002', '910000025', 500000002, 'Lisboa', 'VIP'),
    (26, 'Joao Baiao', 'Zona Ind 3', '4400-003', '910000026', 500000003, 'Braga', 'Pequeno'),
    (27, 'Diana Rocha', 'Centro', '4400-004', '910000027', 500000004, 'Porto', 'Pequeno'),
    (28, 'Timoteo Teodoro', 'Algarve', '8000-001', '910000028', 500000005, 'Faro', 'Grande'),
    (29, 'Mecânica Total', 'Maia', '4470-001', '222000222', 500000006, 'Porto', 'Pequeno'),
    (30, 'Pinturas & Ca', 'Gaia', '4430-001', '256000222', 500000007, 'Porto', 'Pequeno');
END

-- ==========================================
-- 6. TRANSPORTADORAS (30 Inseridas)
-- ==========================================
IF NOT EXISTS (SELECT 1 FROM Transportadora WHERE nif = 900100100)
BEGIN
    INSERT INTO Transportadora (nif, nome, contacto_telefonico, custo_hora) VALUES
    (900100100, 'Transportes Rápidos SA', '220000001', 25.50),
    (900200200, 'Levatudo Lda', '210000002', 15.00),
    (900300300, 'Carga Pesada', '210000003', 20.00),
    (900400400, 'TransNorte', '220000004', 18.00),
    (900500500, 'TransSul', '289000005', 22.00),
    (900600600, 'Via Rápida', '210000006', 19.50),
    (900700700, 'Logística 24h', '220000007', 30.00),
    (900800800, 'Expresso Azul', '210000008', 16.00),
    (900900900, 'Rodocargo', '220000009', 21.00),
    (901000010, 'TransIbéria', '210000010', 24.00),
    (901100011, 'TransEuropa', '220000011', 28.00),
    (901200012, 'LogiTrans', '210000012', 17.00),
    (901300013, 'CargoMundo', '220000013', 23.00),
    (901400014, 'TransRio', '210000014', 19.00),
    (901500015, 'TransDouro', '220000015', 20.50),
    (901600016, 'TransTejo', '210000016', 18.50),
    (901700017, 'VeloCity', '220000017', 26.00),
    (901800018, 'TransGuadiana', '289000018', 21.50),
    (901900019, 'TransMinho', '253000019', 19.00),
    (902000020, 'TransAlentejo', '266000020', 20.00),
    (902100021, 'TransBeira', '272000021', 18.00),
    (902200022, 'TransCentro', '239000022', 22.50),
    (902300023, 'TransOeste', '262000023', 19.50),
    (902400024, 'TransEstrela', '275000024', 24.50),
    (902500025, 'TransSado', '265000025', 20.00),
    (902600026, 'TransMira', '283000026', 17.50),
    (902700027, 'TransLima', '258000027', 19.00),
    (902800028, 'TransTamega', '255000028', 18.50),
    (902900029, 'TransSousa', '255000029', 21.00),
    (903000030, 'TransAve', '252000030', 20.50);
END

-- ==========================================
-- 7. FUNCIONARIOS (30 Inseridos)
-- ==========================================
-- Inserimos primeiro os Diretores (Supervisores de topo)
IF NOT EXISTS (SELECT 1 FROM Funcionario WHERE num_funcionario = 1)
BEGIN
    INSERT INTO Funcionario (num_funcionario, cartao_cidadao, nome, morada, nif, salario_mensal, categoria, cod_supervisor, cod_armazem) VALUES
    (1, 10000001, 'Carlos Diretor', 'Porto', 200000001, 2500.00, 'Diretor', NULL, 1),
    (2, 10000002, 'Ana Supervisora', 'Porto', 200000002, 1800.00, 'Vendedor', 1, 1),
    (3, 10000003, 'Bruno Supervisor', 'Lisboa', 200000003, 1900.00, 'Vendedor', 1, 2),
    (4, 10000004, 'David Supervisor', 'Braga', 200000004, 1750.00, 'Vendedor', 1, 3),
    (5, 10000005, 'Roberto Supervisor', 'Lisboa', 200000005, 1900.00, 'Vendedor', 1, 2),
    (6, 10000006, 'Paulo Supervisor', 'Lisboa', 200000006, 1900.00, 'Vendedor', 1, 2),
    (7, 10000007, 'Paula Supervisor', 'Braga', 200000007, 1700.00, 'Vendedor', 1, 3),
    (8, 10000008, 'Abel Supervisor', 'Braga', 200000008, 1950.00, 'Vendedor', 1, 3),
    (9, 10000009, 'Eva Supervisor', 'Braga', 200000009, 1850.00, 'Vendedor', 1, 3),
    (10, 11111111, 'Rui Vendedor', 'Porto', 211111111, 1100.00, 'Vendedor', 2, 1),
    (11, 11111112, 'Marta Vendedora', 'Gaia', 211111112, 1150.00, 'Vendedor', 2, 1),
    (12, 11111113, 'Pedro Armazém', 'Lisboa', 211111113, 900.00, 'Fiel de Armazém', 3, 2),
    (13, 11111114, 'Joana Armazém', 'Braga', 211111114, 950.00, 'Fiel de Armazém', 4, 3),
    (14, 11111115, 'Tiago Vendedor', 'Porto', 211111115, 1100.00, 'Vendedor', 2, 1),
    (15, 11111116, 'Sofia Vendedora', 'Lisboa', 211111116, 1200.00, 'Vendedor', 3, 2),
    (16, 11111117, 'Luis Vendedor', 'Braga', 211111117, 1100.00, 'Vendedor', 4, 3),
    (17, 11111118, 'Catarina Logística', 'Porto', 211111118, 1000.00, 'Logística', 2, 1),
    (18, 11111119, 'Diogo Logística', 'Lisboa', 211111119, 1050.00, 'Logística', 3, 2),
    (19, 11111120, 'Beatriz Logística', 'Braga', 211111120, 1000.00, 'Logística', 4, 3),
    (20, 11111121, 'Gonçalo Vendedor', 'Porto', 211111121, 1100.00, 'Vendedor', 2, 1),
    (21, 11111122, 'Inês Vendedora', 'Lisboa', 211111122, 1150.00, 'Vendedor', 3, 2),
    (22, 11111123, 'Vasco Vendedor', 'Braga', 211111123, 1100.00, 'Vendedor', 4, 3),
    (23, 11111124, 'Rita Armazém', 'Porto', 211111124, 900.00, 'Fiel de Armazém', 2, 1),
    (24, 11111125, 'André Armazém', 'Lisboa', 211111125, 950.00, 'Fiel de Armazém', 3, 2),
    (25, 11111126, 'Clara Armazém', 'Braga', 211111126, 900.00, 'Fiel de Armazém', 4, 3),
    (26, 11111127, 'Francisco Vendedor', 'Porto', 211111127, 1100.00, 'Vendedor', 2, 1),
    (27, 11111128, 'Alice Vendedora', 'Lisboa', 211111128, 1200.00, 'Vendedor', 3, 2),
    (28, 11111129, 'Tomás Vendedor', 'Braga', 211111129, 1100.00, 'Vendedor', 4, 3),
    (29, 11111130, 'Matilde Logística', 'Porto', 211111130, 1000.00, 'Logística', 2, 1),
    (30, 11111131, 'Guilherme Logística', 'Lisboa', 211111131, 1050.00, 'Logística', 3, 2);
END

-- ==========================================
-- 8. HISTÓRICO DE PREÇOS (Necessário)
-- ==========================================
IF NOT EXISTS (SELECT 1 FROM Historico_Preco WHERE id_historico = 1)
INSERT INTO Historico_Preco (id_historico, referencia_artigo, preco_antigo, data_inicio, data_fim) VALUES
(1, 5004, 1000.00, '2014-01-01', '2015-12-31'),
(2, 5004, 1200.00, '2016-01-01', NULL);

-- ==========================================
-- 9. NOTAS DE ENCOMENDA E DETALHES (30+ Inseridas)
-- ==========================================
-- Limpa tabelas de processo para reinserir sem erros de chave
DELETE FROM Transporte_Conteudo;
DELETE FROM Transporte;
DELETE FROM Guia_Saida_Detalhe;
DELETE FROM Guia_Saida;
DELETE FROM Nota_Encomenda_Detalhe;
DELETE FROM Nota_Encomenda;

-- Inserção em massa de Encomendas
INSERT INTO Nota_Encomenda (num_encomenda, data_encomenda, cod_cliente, num_vendedor, estado) VALUES
(501, '2015-05-20', 1, 10, 'Processada'),
(502, '2018-06-15', 2, 12, 'Processada'), 
(503, '2025-11-18', 1, 10, 'Pendente'),  
(504, '2018-03-01', 3, 13, 'Processada'), 
(505, '2018-03-05', 4, 10, 'Pendente'),   
(506, '2018-04-10', 5, 10, 'Pendente'),
(507, '2018-10-10', 6, 12, 'Processada'),
(508, '2019-01-15', 7, 10, 'Processada'), 
(509, '2019-02-20', 8, 10, 'Processada'),
(510, '2019-03-25', 9, 10, 'Processada'),
(511, '2024-01-01', 10, 14, 'Processada'),
(512, '2024-01-02', 11, 15, 'Processada'),
(513, '2024-01-03', 12, 16, 'Processada'),
(514, '2024-01-04', 13, 14, 'Processada'),
(515, '2024-01-05', 14, 15, 'Processada'),
(516, '2024-01-06', 15, 16, 'Processada'),
(517, '2024-01-07', 16, 14, 'Processada'),
(518, '2024-01-08', 17, 15, 'Processada'),
(519, '2024-01-09', 18, 16, 'Processada'),
(520, '2024-01-10', 19, 14, 'Processada'),
(521, '2024-01-11', 20, 15, 'Processada'),
(522, '2024-01-12', 21, 16, 'Processada'),
(523, '2024-01-13', 22, 14, 'Processada'),
(524, '2024-01-14', 23, 15, 'Processada'),
(525, '2024-01-15', 24, 16, 'Processada'),
(526, '2024-01-16', 25, 14, 'Processada'),
(527, '2024-01-17', 26, 15, 'Processada'),
(528, '2024-01-18', 27, 16, 'Processada'),
(529, '2024-01-19', 28, 14, 'Processada'),
(530, '2024-01-20', 29, 15, 'Processada');

-- Detalhes das Encomendas
INSERT INTO Nota_Encomenda_Detalhe (num_encomenda, referencia_artigo, quantidade) VALUES
(501, 5004, 2), (502, 1, 10), (503, 2, 200), -- Casos Especiais
(504, 3, 5), (505, 2, 50), (506, 5, 100), (507, 6, 2),
(508, 1, 20), (509, 2, 20), (510, 3, 20),
(511, 4, 1), (512, 5, 2), (513, 6, 3), (514, 7, 4),
(515, 8, 5), (516, 9, 6), (517, 10, 7), (518, 11, 8),
(519, 12, 9), (520, 13, 10), (521, 14, 1), (522, 15, 2),
(523, 16, 3), (524, 17, 4), (525, 18, 5), (526, 19, 6),
(527, 20, 7), (528, 21, 8), (529, 22, 9), (530, 23, 10);

-- ==========================================
-- 10. GUIAS DE SAIDA E TRANSPORTE (Casos de Teste)
-- ==========================================
INSERT INTO Guia_Saida (id_guia, data_guia, num_encomenda_origem, func_responsavel) VALUES
(801, '2018-06-26 09:30:00', 502, 12); -- Guia de 2018 atrasada

INSERT INTO Guia_Saida_Detalhe (id_guia, referencia_artigo, id_zona, quantidade_retirada) VALUES
(801, 1, 201, 10);

INSERT INTO Transporte (id_transporte, nif_transportadora, cod_cliente_destino, data_transporte, num_horas_utilizacao) VALUES
(901, 900100100, 2, '2018-06-27 14:00:00', 2.5);

INSERT INTO Transporte_Conteudo (id_transporte, id_guia) VALUES
(901, 801);