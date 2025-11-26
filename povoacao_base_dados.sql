/* ===============================================================
   SCRIPT FINAL DE POVOAMENTO (DML) - IsepBricolage
   VERSÃO CORRIGIDA: Erros de IDs de Armazém resolvidos.
   =============================================================== */

USE IsepBricolage;
GO

-- =================================================================
-- 0. LIMPEZA TOTAL
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
DELETE FROM Cliente;
DELETE FROM Transportadora;
DELETE FROM Artigo;
DELETE FROM Zona_Fisica;
DELETE FROM Armazem;
GO

-- =================================================================
-- 1. ARMAZENS (1 a 30)
-- =================================================================
INSERT INTO Armazem (cod_armazem, nome, morada, loc_geo_wgs84) VALUES
(1, 'Armazém Porto Norte', 'Rua do ISEP, 123, Porto', '41.178, -8.608'),
(2, 'Armazém Norte Oriente', 'Av. das Nações, 45, Casconha', '41.190, -8.340'),
(3, 'Armazém Braga Minho', 'Lugar do Monte, Braga', '41.545, -8.426'),
(4, 'Armazém Penafiel Vale', 'Rua da Sofia, 50, Penafiel', '41.200, -8.280'),
(5, 'Armazém Paredes Rota', 'Estrada da Penha, 88, Paredes', '41.206, -8.330'),
(6, 'Armazém Aveiro Norte', 'Zona Industrial, 12, Espinho', '41.008, -8.640'),
(7, 'Armazém Sousa Felgueiras', 'Av. da Liberdade, 200, Felgueiras', '41.365, -8.196'),
(8, 'Armazém Viana Lima', 'Av. dos Combatentes, 90, Viana do Castelo', '41.693, -8.828'),
(9, 'Armazém Bragança Frio', 'Av. Sá Carneiro, 15, Bragança', '41.806, -6.757'),
(10, 'Armazém Vila Real Corgo', 'Rua Marechal Teixeira, 40, Vila Real', '41.300, -7.744'),
(11, 'Armazém Guimarães Berço', 'Alameda de S. Dâmaso, 30, Guimarães', '41.442, -8.291'),
(12, 'Armazém Maia Indústria', 'Zona Industrial da Maia, 1, Maia', '41.235, -8.619'),
(13, 'Armazém Matosinhos Mar', 'Estrada da Circunvalação, 99, Matosinhos', '41.182, -8.680'),
(14, 'Armazém Gaia Douro', 'Av. da República, 1500, Gaia', '41.130, -8.610'),
(15, 'Armazém Famalicão Têxtil', 'Rua das Flores, 10, Famalicão', '41.407, -8.518'),
(16, 'Armazém Barcelos Galo', 'Largo do Apoio, 5, Barcelos', '41.530, -8.620'),
(17, 'Armazém Póvoa Varzim', 'Av. do Mar, 20, Póvoa de Varzim', '41.380, -8.760'),
(18, 'Armazém Vila do Conde', 'Rua D. João II, 12, Vila do Conde', '41.350, -8.740'),
(19, 'Armazém Fafe Serra', 'Praça 25 de Abril, 3, Fafe', '41.450, -8.170'),
(20, 'Armazém Chaves Termas', 'Rua de Santo António, 8, Chaves', '41.740, -7.470'),
(21, 'Armazém Mirandela Tua', 'Rua da República, 4, Mirandela', '41.480, -7.180'),
(22, 'Armazém Santo Tirso', 'Largo Coronel Baptista, 6, Santo Tirso', '41.340, -8.470'),
(23, 'Armazém Trofa Ferrovia', 'Rua da Estação, 11, Trofa', '41.330, -8.550'),
(24, 'Armazém Valongo Serras', 'Rua de S. Mamede, 7, Valongo', '41.190, -8.500'),
(25, 'Armazém Gondomar Ouro', 'Rua 25 de Abril, 22, Gondomar', '41.140, -8.530'),
(26, 'Armazém Amarante Tâmega', 'Alameda Teixeira de Pascoaes, 9, Amarante', '41.270, -8.080'),
(27, 'Armazém Marco Canaveses', 'Av. Gago Coutinho, 15, Marco', '41.185, -8.150'),
(28, 'Armazém Lousada Rota', 'Praça das Pocinhas, 2, Lousada', '41.280, -8.280'),
(29, 'Armazém Paços Ferreira', 'Av. dos Templários, 80, Paços de Ferreira', '41.275, -8.380'),
(30, 'Armazém Vizela Termal', 'Rua Dr. Abílio Torres, 30, Vizela', '41.370, -8.300');

-- =================================================================
-- 2. ZONAS FÍSICAS (CORRIGIDO: IDs de Armazém 1 a 30)
-- =================================================================
INSERT INTO Zona_Fisica (id_zona, nome_zona, cod_armazem, capacidade_volume) VALUES
(101, 'Corredor A', 1, 500),  
(201, 'Prateleira A', 2, 200),
(301, 'Zona A', 3, 600),
(401, 'Corredor América', 4, 500),
(501, 'Armazanamento 1', 5, 300), 
(601, 'Prateleira 1', 6, 250), 
(701, 'Área Azul', 7, 600), 
(801, 'Corredor Norte', 8, 450), 
(901, 'Estante A', 9, 350),
(1001, 'Zona Fria', 10, 500),
(1101, 'Corredor 1', 11, 400), 
(1201, 'Box A', 12, 1000), 
(1301, 'Nível 0', 13, 550), 
(1401, 'Zona A', 14, 300), 
(1501, 'Depósito 1', 15, 700),
(1601, 'Corredor Central', 16, 800),
(1701, 'Prateleira X', 17, 200),
(1801, 'Zona Cargas', 18, 500), 
(1901, 'Linha 1', 19, 450), 
(2001, 'Armário A', 20, 150), 
(2101, 'Contentor 1', 21, 900), 
(2201, 'Corredor KGB', 22, 600), 
(2301, 'Secção Ferros', 23, 750), 
(2401, 'Piso Térreo', 24, 1000), 
(2501, 'Zona 1', 25, 500), 
(2601, 'Corredor Coreia', 26, 400), 
(2701, 'Estante Metálica', 27, 300),
(2801, 'Área Técnica', 28, 200), 
(2901, 'Linha Montagem', 29, 600), 
(3001, 'Zona Mar', 30, 500);

-- =================================================================
-- 3. ARTIGOS
-- =================================================================
INSERT INTO Artigo (referencia, nome, descricao, preco_compra, preco_venda, unidade) VALUES
(1, 'Alicate Universal', 'Alicate de 6 polegadas', 3.50, 8.99, 'unidade'),
(2, 'Chave de Fendas 3mm', 'Aço cromo-vanádio', 1.00, 2.50, 'unidade'),
(3, 'Chave Philips', 'Ponta magnética', 1.20, 3.00, 'unidade'),
(4, 'Fita Métrica 5m', 'Com travão', 2.00, 5.50, 'unidade'),
(5, 'Carvão', 'carvão vegetal', 4.50, 12.00, 'kg'),
(6, 'Serrote de Madeira', 'Dentes temperados', 5.00, 11.50, 'unidade'),
(7, 'Lixa de Parede 10', 'Pacote de 10', 0.50, 1.50, 'unidade'),
(8, 'Rolo de Pintura', 'pinta', 3.00, 7.00, 'unidade'),
(9, 'Pincel 2 polegadas', 'Cerdas naturais', 1.50, 4.00, 'unidade'),
(10, 'Fita Isoladora', 'Rolo de 20m preto', 0.30, 1.00, 'metro'),
(11, 'Lâmpada LED E27', '10W Luz Branca', 1.50, 3.99, 'unidade'),
(12, 'Lâmpada LED E14', '5W Luz Amarela', 1.20, 3.50, 'unidade'),
(13, 'Tomada Dupla', 'branca de embutir', 2.50, 6.50, 'unidade'),
(14, 'Interruptor Simples', 'branco de embutir', 2.00, 5.00, 'unidade'),
(15, 'Cabo Elétrico 1.5mm', 'Rolo de 20m', 15.00, 35.00, 'unidade'),
(16, 'Cabo Elétrico 2.5mm', 'Rolo de 20m', 25.00, 55.00, 'unidade'),
(17, 'Tubo PVC 32mm', 'Barra de 3m', 2.00, 5.00, 'unidade'),
(18, 'Curva PVC 32mm', 'tabua bétula', 0.20, 0.60, 'kg'),
(19, 'Cola PVC', 'Lata 250ml', 3.00, 7.50, 'unidade'),
(20, 'Torneira de Jardim', 'Metal cromado 1/2', 4.00, 9.90, 'unidade'),
(21, 'Mangueira', 'flexivel verde', 8.00, 18.00, 'metro'),
(22, 'compressor', 'Plástico resistente', 3.50, 8.50, 'unidade'),
(23, 'Vaso de Barro 30cm', 'Terracota', 2.50, 6.00, 'unidade'),
(24, 'Terra Vegetal 50L', 'Substrato universal', 3.00, 7.00, 'unidade'),
(25, 'Adubo Líquido', 'Plantas verdes 1L', 4.00, 9.50, 'garrafa'),
(26, 'Cimento Cola', 'Saco 25kg Interior', 2.50, 5.50, 'unidade'),
(27, 'Argamassa', 'Saco kg', 2.00, 4.50, 'kg'),
(28, 'Tijolo 11', 'Tijolo cerâmico', 0.20, 0.50, 'unidade'),
(29, 'Telha Lusa', 'Cerâmica vermelha', 0.40, 0.90, 'unidade'),
(30, 'Impermeabilizante', 'Lata 5kg', 15.00, 35.00, 'unidade'),
(5004, 'Produto espetacular.', 'Teste especial', 500.00, 1200.00, 'unidade');

-- =================================================================
-- 4. STOCK
-- =================================================================
INSERT INTO Stock_Armazem (cod_armazem, referencia_artigo, stock_minimo, quantidade_total) VALUES
(1, 1, 10, 10),
(2, 2, 5, 2),
(1, 3, 10, 20),
(2, 4, 10, 500),
(1, 5, 10, 15), (2, 6, 10, 13), (1, 7, 10, 99), (2, 8, 10, 27), (1, 9, 10, 80),
(2, 10, 10, 70), (1, 11, 10, 60), (2, 12, 10, 67), (1, 13, 10, 76), (2, 14, 10, 100),
(1, 15, 10, 100), (2, 16, 10, 80), (1, 17, 10, 40), (2, 18, 10, 24), (1, 19, 10, 47),
(2, 20, 10, 93), (1, 21, 10, 39), (2, 22, 10, 38), (1, 23, 10, 33), (2, 24, 10, 98),
(1, 25, 10, 20), (2, 26, 10, 43), (1, 27, 10, 55), (2, 28, 10, 56), (1, 29, 10, 50),
(2, 30, 10, 0),
(1, 5004, 10, 100);

INSERT INTO Stock_Armazem (cod_armazem, referencia_artigo, stock_minimo, quantidade_total) VALUES
(3, 1, 10, 10), (4, 2, 10, 87), (3, 3, 10, 97), (4, 4, 10, 100), (3, 5, 10, 27),
(4, 6, 10, 100), (3, 7, 10, 100), (4, 8, 10, 100), (3, 9, 10, 100), (4, 10, 10, 100),
(3, 11, 10, 100), (4, 12, 10, 100), (3, 13, 10, 100), (4, 14, 10, 100), (3, 15, 10, 20),
(4, 16, 10, 100), (3, 17, 10, 100), (4, 18, 10, 100), (3, 19, 10, 100), (4, 20, 10, 100),
(3, 21, 10, 100), (4, 22, 10, 100), (3, 23, 10, 100), (4, 24, 10, 100), (3, 25, 10, 100),
(4, 26, 10, 100), (3, 27, 10, 100), (4, 28, 10, 100), (3, 29, 10, 100), (4, 30, 10, 100),
(3, 5004, 10, 100);

INSERT INTO Stock_Armazem (cod_armazem, referencia_artigo, stock_minimo, quantidade_total) VALUES
(5, 3, 10, 100), (6, 4, 10, 100), (5, 5, 10, 100), (6, 6, 10, 100), (5, 7, 10, 100),
(6, 8, 10, 100), (5, 9, 10, 100), (6, 10, 10, 100), (5, 11, 10, 100), (6, 12, 10, 100),
(5, 13, 10, 100), (6, 14, 10, 100), (5, 15, 10, 100), (6, 16, 10, 100), (5, 17, 10, 100),
(6, 18, 10, 100), (5, 19, 10, 100), (6, 20, 10, 100), (5, 21, 10, 100), (6, 22, 10, 100),
(5, 23, 10, 100), (6, 24, 10, 100), (5, 25, 10, 100), (6, 26, 10, 100), (5, 27, 10, 100),
(6, 28, 10, 100), (5, 29, 10, 100), (6, 30, 10, 100), (5, 5004, 10, 100);

INSERT INTO Stock_Armazem (cod_armazem, referencia_artigo, stock_minimo, quantidade_total) VALUES
(7, 5, 10, 100), (9, 10, 10, 100), (12, 5, 10, 100), (17, 10, 10, 100),
(21, 5, 10, 100), (26, 10, 10, 100), (14, 5, 10, 100), (28, 10, 10, 100), 
(30, 5, 10, 100), (15, 10, 10, 100), (22, 5, 10, 100), (29, 10, 10, 100); 
-- =================================================================
-- 5. CLIENTES 
-- =================================================================
INSERT INTO Cliente (cod_cliente, nome, morada, codigo_postal, telemovel, nif, zona_geografica, tipo_cliente) VALUES
(1, 'Antonio Silva', 'Rua de Santa Catarina, 123', '4000', '91001', 3001, 'Porto', 'Pequeno'),
(2, 'Beatriz Costa', 'Av. da Liberdade, 45', '4715', '91002', 3002, 'Braga', 'VIP'),
(3, 'Carlos Sousa', 'Rua da República, 10', '4900', '91003', 3003, 'Viana', 'Grande'),
(4, 'Diana Oliveira', 'Rua do Comércio, 5', '5000', '91004', 3004, 'Vila Real', 'Pequeno'),
(5, 'Eduardo Lima', 'Av. Sá Carneiro, 88', '5300', '91005', 3005, 'Bragança', 'Pequeno'),
(6, 'Fernando Mendes', 'Largo do Toural, 20', '4810', '91006', 3006, 'Guimarães', 'Grande'),
(7, 'Gabriela Rocha', 'Rua D. Afonso Henriques, 9', '4470', '91007', 3007, 'Maia', 'VIP'),
(8, 'Hugo Almeida', 'Estrada da Circunvalação, 100', '4450', '91008', 3008, 'Matosinhos', 'Pequeno'),
(9, 'Ines Santos', 'Av. da República, 150', '4430', '91009', 3009, 'Gaia', 'Pequeno'),
(10, 'Joao Pereira', 'Rua das Flores, 33', '4760', '91010', 3010, 'Famalicão', 'Grande'),
(11, 'Katia Aveiro', 'Largo da Porta Nova, 2', '4750', '91011', 3011, 'Barcelos', 'Pequeno'),
(12, 'Luis Figo', 'Av. dos Banhos, 55', '4490', '91012', 3012, 'Póvoa Varzim', 'VIP'),
(13, 'Maria Leal', 'Rua do Cais, 12', '4480', '91013', 3013, 'Vila do Conde', 'Pequeno'),
(14, 'Nuno Markl', 'Praça 25 de Abril, 7', '4820', '91014', 3014, 'Fafe', 'Grande'),
(15, 'Otavio Monteiro', 'Rua das Termas, 9', '5400', '91015', 3015, 'Chaves', 'VIP'),
(16, 'Pedro Abrunhosa', 'Rua da Alheira, 10', '5370', '91016', 3016, 'Mirandela', 'Grande'),
(17, 'Quim Barreiros', 'Largo Coronel Baptista, 1', '4780', '91017', 3017, 'Santo Tirso', 'Pequeno'),
(18, 'Ricardo Araujo', 'Rua da Estação, 5', '4785', '91018', 3018, 'Trofa', 'Pequeno'),
(19, 'Sara Sampaio', 'Rua de S. Mamede, 88', '4440', '91019', 3019, 'Valongo', 'VIP'),
(20, 'Tiago Bettencourt', 'Rua do Ouro, 33', '4420', '91020', 3020, 'Gondomar', 'Pequeno'),
(21, 'Ursula Corbero', 'Alameda Teixeira Pascoaes, 2', '4600', '91021', 3021, 'Amarante', 'Pequeno'),
(22, 'Vasco Palmeirim', 'Av. Gago Coutinho, 90', '4630', '91022', 3022, 'Marco', 'Grande'),
(23, 'Wilson Manafa', 'Praça das Pocinhas, 4', '4620', '91023', 3023, 'Lousada', 'Pequeno'),
(24, 'Xavier Hernandez', 'Av. dos Templários, 6', '4590', '91024', 3024, 'Paços Ferreira', 'Grande'),
(25, 'Yara Greyjoy', 'Rua Dr. Abílio Torres, 7', '4815', '91025', 3025, 'Vizela', 'VIP'),
(26, 'Zelia Duncan', 'Rua da Sofia, 11', '4560', '91026', 3026, 'Penafiel', 'Pequeno'),
(27, 'Padaria Central', 'Estrada da Penha, 2', '4580', '91027', 5001, 'Paredes', 'Pequeno'),
(28, 'Restaurante O Gancho', 'Zona Industrial, 50', '4500', '91028', 5002, 'Espinho', 'Grande'),
(29, 'Mecânica Total', 'Av. da Liberdade, 200', '4610', '222', 5006, 'Felgueiras', 'Pequeno'),
(30, 'Pinturas & Ca', 'Rua Central, 5', '4575', '256', 5007, 'Casconha', 'Pequeno'),
(31, 'Hotel Solverde', 'Av. da Praia, 100', '4500', '91031', 5008, 'Espinho', 'VIP'),
(32, 'Café Majestic', 'Rua Santa Catarina, 12', '4000', '91032', 5009, 'Porto', 'Grande'),
(33, 'Livraria Lello', 'Rua das Carmelitas, 144', '4050', '91033', 5010, 'Porto', 'VIP'),
(34, 'Oficina do Zé', 'Rua do Souto, 5', '4700', '91034', 5011, 'Braga', 'Pequeno'),
(35, 'Minimercado da Esquina', 'Rua da Bandeira, 2', '4900', '91035', 5012, 'Viana', 'Pequeno'),
(36, 'Farmácia Sá da Bandeira', 'Rua Sá da Bandeira, 20', '4000', '91036', 5013, 'Porto', 'Grande'),
(37, 'Talho do Povo', 'Rua de Soares dos Reis, 8', '4400', '91037', 5014, 'Gaia', 'Pequeno'),
(38, 'Cabeleireiro Chic', 'Av. da República, 5', '4450', '91038', 5015, 'Matosinhos', 'Pequeno'),
(39, 'Ginásio FitPlus', 'Av. da Boavista, 10', '4100', '91039', 5016, 'Porto', 'Grande'),
(40, 'Transportes Velozes', 'Zona Industrial, Lote 4', '4470', '91040', 5017, 'Maia', 'VIP'),
(41, 'Restaurante Douro', 'Cais da Ribeira, 50', '4000', '91041', 5018, 'Porto', 'Grande'),
(42, 'Construções do Minho', 'Zona Industrial, 8', '4700', '91042', 5019, 'Braga', 'VIP'),
(43, 'Café Central', 'Praça da República, 2', '4900', '91043', 5020, 'Viana', 'Pequeno'),
(44, 'Hotel da Serra', 'Rua da Montanha, 10', '5000', '91044', 5021, 'Vila Real', 'Grande'),
(45, 'Padaria Trasmontana', 'Av. Principal, 5', '5300', '91045', 5022, 'Bragança', 'Pequeno'),
(46, 'Clínica de Guimarães', 'Largo do Toural, 15', '4800', '91046', 5023, 'Guimarães', 'VIP'),
(47, 'Oficina MaiaCar', 'Via Norte, 200', '4470', '91047', 5024, 'Maia', 'Grande'),
(48, 'Peixaria do Mar', 'Rua dos Pescadores, 3', '4450', '91048', 5025, 'Matosinhos', 'Pequeno'),
(49, 'Caves de Gaia', 'Rua do Vinho, 88', '4400', '91049', 5026, 'Gaia', 'VIP'),
(50, 'Têxteis Famalicão', 'Rua da Indústria, 44', '4760', '91050', 5027, 'Famalicão', 'Grande'),
(51, 'Artesanato Galo', 'Largo do Município, 1', '4750', '91051', 5028, 'Barcelos', 'Pequeno'),
(52, 'Casino da Póvoa', 'Av. dos Banhos, 100', '4490', '91052', 5029, 'Póvoa Varzim', 'VIP'),
(53, 'Bar do Rio', 'Cais do Ave, 7', '4480', '91053', 5030, 'Vila do Conde', 'Pequeno'),
(54, 'Doçaria de Fafe', 'Praça Velha, 4', '4820', '91054', 5031, 'Fafe', 'Pequeno'),
(55, 'Pastelaria Chaves', 'Rua Direita, 9', '5400', '91055', 5032, 'Chaves', 'Pequeno'),
(56, 'Azeites Mirandela', 'Zona Agrícola, 2', '5370', '91056', 5033, 'Mirandela', 'Grande'),
(57, 'Mosteiro Shop', 'Largo do Mosteiro, 1', '4780', '91057', 5034, 'Santo Tirso', 'Pequeno'),
(58, 'Ferroviária da Trofa', 'Rua da Estação, 8', '4785', '91058', 5035, 'Trofa', 'Grande'),
(59, 'Biscoitos de Valongo', 'Rua da Serra, 12', '4440', '91059', 5036, 'Valongo', 'Pequeno'),
(60, 'Ourivesaria Gondomar', 'Rua do Ouro, 20', '4420', '91060', 5037, 'Gondomar', 'VIP');

-- =================================================================
-- 6. TRANSPORTADORAS 
-- =================================================================
INSERT INTO Transportadora (nif, nome, contacto_telefonico, custo_hora) VALUES
(900100100, 'Transportes Rápidos SA', '22001', 25.50),
(900200200, 'Levatudo Lda', '21002', 15.00),
(900300300, 'Carga Pesada', '21003', 20.00),
(900400400, 'TransIbérica Logística', '22004', 22.50),
(900500500, 'Expresso do Norte', '22005', 18.00),
(900600600, 'Via Rápida Lda', '22006', 30.00),
(900700700, 'Transportes do Douro', '22007', 25.00),
(900800800, 'Carga Segura SA', '22008', 28.50),
(900900900, 'Logística Global', '22009', 35.00),
(901000000, 'TransMinho', '22010', 19.50),
(901100100, 'Rota da Estrela', '22011', 21.00),
(901200200, 'Mudanças & Ca', '22012', 16.50),
(901300300, 'Transportes Lusitanos', '22013', 24.00),
(901400400, 'Falcão da Estrada', '22014', 27.50),
(901500500, 'Expresso 24 Horas', '22015', 40.00),
(901600600, 'TransOceano', '22016', 32.00),
(901700700, 'Leva & Traz Lda', '22017', 14.50),
(901800800, 'Transportes Unidos', '22018', 26.00),
(901900900, 'Logística Central', '22019', 23.50),
(902000000, 'Carga Máxima', '22020', 29.00),
(902100100, 'Transportes da Serra', '22021', 20.50),
(902200200, 'Via Verde Transportes', '22022', 18.50),
(902300300, 'TransPorto SA', '22023', 25.50),
(902400400, 'Expresso Urbano', '22024', 17.00),
(902500500, 'Logística Total', '22025', 31.00),
(902600600, 'Transportes Pontuais', '22026', 22.00),
(902700700, 'Carga Direta', '22027', 19.00),
(902800800, 'TransNacional', '22028', 33.50),
(902900900, 'Rodovia Segura', '22029', 24.50),
(903000000, 'Transportes do Futuro', '22030', 36.00);

-- =================================================================
-- 7. FUNCIONARIOS 
-- =================================================================
INSERT INTO Funcionario (num_funcionario, cartao_cidadao, nome, morada, nif, salario_mensal, categoria, cod_supervisor, cod_armazem) VALUES
(1, 1001, 'Carlos Diretor', 'Porto', 2001, 2500.00, 'Diretor', NULL, 1),
(2, 1002, 'Ana Supervisora', 'Porto', 2002, 1800.00, 'Vendedor', 1, 1),
(3, 1003, 'Bruno Supervisor', 'Casconha', 2003, 1900.00, 'Vendedor', 1, 2),
(4, 1004, 'David Supervisor', 'Braga', 2004, 1750.00, 'Vendedor', 1, 3),
(10, 1010, 'Rui Vendedor', 'Porto', 2010, 1100.00, 'Vendedor', 2, 1),
(11, 1011, 'Marta Vendedora', 'Porto', 2011, 1150.00, 'Vendedor', 2, 1),
(12, 1012, 'Pedro Armazém', 'Barcelos', 2012, 900.00, 'Fiel de Armazém', 3, 2),
(13, 1013, 'Joana Armazém', 'Braga', 2013, 950.00, 'Fiel de Armazém', 4, 3),
(14, 1014, 'Tiago Vendedor', 'Porto', 2014, 1100.00, 'Vendedor', 2, 1),
(15, 1015, 'Sofia Vendedora', 'Povoa do Varzim', 2015, 1200.00, 'Vendedor', 3, 2),
(16, 1016, 'Luis Vendedor', 'Braga', 2016, 1100.00, 'Vendedor', 4, 3),
(17, 1017, 'Rita Viana', 'Viana do Castelo', 2017, 1100.00, 'Vendedor', 4, 8),
(18, 1018, 'Paulo Corgo', 'Vila Real', 2018, 1120.00, 'Vendedor', 4, 10),
(19, 1019, 'Carla Bragança', 'Bragança', 2019, 1050.00, 'Vendedor', 4, 9),
(20, 1020, 'Jorge Guimarães', 'Guimarães', 2020, 1150.00, 'Vendedor', 4, 11),
(21, 1021, 'Sonia Maia', 'Maia', 2021, 1200.00, 'Vendedor', 2, 12),
(22, 1022, 'Miguel Matos', 'Matosinhos', 2022, 1200.00, 'Vendedor', 2, 13),
(23, 1023, 'Andreia Gaia', 'Gaia', 2023, 1180.00, 'Vendedor', 2, 14),
(24, 1024, 'Fabio Têxtil', 'Famalicão', 2024, 1100.00, 'Vendedor', 4, 15),
(25, 1025, 'Helena Barcelos', 'Barcelos', 2025, 1100.00, 'Vendedor', 4, 16),
(26, 1026, 'Ricardo Póvoa', 'Póvoa de Varzim', 2026, 1150.00, 'Vendedor', 2, 17),
(27, 1027, 'Ines Conde', 'Vila do Conde', 2027, 1150.00, 'Vendedor', 2, 18),
(28, 1028, 'Gonçalo Fafe', 'Fafe', 2028, 1080.00, 'Fiel de Armazém', 4, 19),
(29, 1029, 'Daniela Chaves', 'Chaves', 2029, 1080.00, 'Fiel de Armazém', 4, 20),
(30, 1030, 'Manuel Mirandela', 'Mirandela', 2030, 1080.00, 'Fiel de Armazém', 4, 21);

-- =================================================================
-- 8. HISTÓRICO DE PREÇOS 
-- =================================================================
INSERT INTO Historico_Preco (id_historico, referencia_artigo, preco_antigo, data_inicio, data_fim) VALUES
(1, 5004, 800.00, '2013-01-01', '2013-12-31'),
(2, 5004, 1000.00, '2014-01-01', '2015-12-31'),
(3, 5004, 1200.00, '2016-01-01', '2020-12-31'),
(4, 5004, 1150.00, '2021-01-01', NULL),
(5, 4, 6.00, '2014-01-01', '2015-12-31'),
(6, 15, 20.00, '2014-01-01', '2015-12-31'),
(7, 16, 35.00, '2014-01-01', '2015-12-31'),
(8, 30, 25.00, '2014-01-01', '2015-12-31'),
(9, 20, 8.00, '2014-01-01', '2015-12-31'),
(10, 1, 7.00, '2014-01-01', '2015-12-31'),
(11, 1, 7.50, '2020-01-01', '2021-12-31'),
(12, 1, 8.00, '2022-01-01', '2023-06-30'),
(13, 2, 2.00, '2019-01-01', '2022-12-31'),
(14, 3, 2.50, '2020-01-01', '2023-01-01'),
(15, 4, 4.50, '2018-01-01', '2020-12-31'),
(16, 5, 10.00, '2019-01-01', '2021-12-31'),
(17, 6, 9.50, '2020-05-01', '2022-05-01'),
(18, 8, 5.50, '2021-01-01', '2022-12-31'),
(19, 9, 3.00, '2020-01-01', '2023-01-01'),
(20, 11, 4.50, '2018-01-01', '2020-12-31'),
(21, 11, 4.20, '2021-01-01', '2022-12-31'),
(22, 15, 25.00, '2019-01-01', '2021-06-30'),
(23, 15, 30.00, '2021-07-01', '2023-12-31'),
(24, 16, 45.00, '2019-01-01', '2021-06-30'),
(25, 16, 50.00, '2021-07-01', '2023-12-31'),
(26, 17, 4.00, '2020-01-01', '2022-12-31'),
(27, 19, 6.00, '2021-01-01', '2023-01-01'),
(28, 21, 15.00, '2020-03-01', '2022-03-01'),
(29, 24, 5.50, '2021-01-01', '2022-12-31'),
(30, 25, 8.00, '2020-01-01', '2022-06-30');

-- =================================================================
-- 9. ENCOMENDAS 
-- =================================================================
INSERT INTO Nota_Encomenda (num_encomenda, data_encomenda, cod_cliente, num_vendedor, estado) VALUES
(501, '2015-05-20', 1, 10, 'Processada'),
(502, '2018-06-15', 2, 12, 'Processada'),
(503, '2025-11-18', 1, 10, 'Pendente'),
(504, '2018-03-01', 3, 13, 'Processada'),
(505, '2018-03-05', 4, 10, 'Pendente'),
(506, '2018-04-10', 5, 10, 'Pendente'),
(507, '2018-10-10', 6, 12, 'Processada'),
(508, '2019-01-15', 7, 10, 'Processada'),
(511, '2024-01-01', 10, 14, 'Processada'),
(512, '2019-05-12', 11, 17, 'Processada'),
(513, '2019-06-20', 12, 17, 'Processada'),
(514, '2019-08-15', 13, 18, 'Processada'),
(515, '2019-11-02', 14, 18, 'Processada'),
(516, '2020-01-10', 15, 19, 'Processada'),
(517, '2020-02-14', 16, 19, 'Processada'),
(518, '2020-03-30', 17, 20, 'Processada'),
(519, '2020-05-05', 18, 20, 'Pendente'),
(520, '2020-07-20', 19, 21, 'Processada'),
(521, '2020-09-10', 20, 21, 'Processada'),
(522, '2021-01-15', 21, 22, 'Processada'),
(523, '2021-02-28', 22, 22, 'Processada'),
(524, '2021-04-12', 23, 23, 'Pendente'),
(525, '2021-06-01', 24, 23, 'Processada'),
(526, '2021-08-18', 25, 24, 'Processada'),
(527, '2021-10-05', 26, 24, 'Processada'),
(528, '2021-12-20', 27, 25, 'Processada'),
(529, '2022-01-10', 28, 25, 'Processada'),
(530, '2022-03-15', 29, 26, 'Pendente'),
(531, '2022-05-20', 30, 26, 'Processada'),
(532, '2022-07-07', 31, 27, 'Processada'),
(533, '2022-09-09', 32, 27, 'Processada'),
(534, '2022-11-11', 33, 28, 'Processada'),
(535, '2023-01-25', 34, 28, 'Pendente'),
(536, '2023-02-14', 35, 29, 'Processada'),
(537, '2023-03-30', 36, 29, 'Processada'),
(538, '2023-04-15', 37, 30, 'Processada'),
(539, '2023-05-20', 38, 30, 'Processada'),
(540, '2023-06-10', 39, 17, 'Pendente'),
(541, '2023-07-25', 40, 18, 'Processada'),
(542, '2023-08-30', 41, 19, 'Processada'),
(543, '2023-09-15', 42, 20, 'Processada'),
(544, '2023-10-01', 43, 21, 'Pendente'),
(545, '2023-11-20', 44, 22, 'Processada'),
(546, '2023-12-05', 45, 23, 'Processada'),
(547, '2024-01-10', 46, 24, 'Processada'),
(548, '2024-02-15', 47, 25, 'Pendente'),
(549, '2024-03-01', 48, 26, 'Processada'),
(550, '2024-03-20', 49, 27, 'Processada'),
(601, '2018-05-01', 2, 15, 'Pendente'),
(602, '2018-06-01', 6, 15, 'Pendente'), 
(603, '2018-07-01', 2, 15, 'Pendente'), 
(701, '2019-05-20', 1, 2, 'Processada'); 

-- =================================================================
-- 10. DETALHES DAS ENCOMENDAS 
-- =================================================================
INSERT INTO Nota_Encomenda_Detalhe (num_encomenda, referencia_artigo, quantidade) VALUES
(501, 4, 200), (502, 1, 10), (503, 2, 200), (504, 3, 5), (505, 2, 50), (506, 5, 100), 
(507, 6, 2), (508, 1, 20), (511, 4, 500), (512, 10, 50), (512, 11, 20), (513, 15, 5),
(514, 20, 10), (514, 21, 2), (515, 30, 10), (516, 5, 15), (516, 6, 5), (517, 1, 100),
(518, 28, 500), (519, 4, 30), (520, 8, 20), (520, 9, 20), (521, 13, 40), (522, 24, 10), 
(522, 25, 5), (523, 2, 60), (524, 16, 8), (525, 29, 200), (526, 17, 30), (526, 18, 60), 
(526, 19, 5), (527, 26, 20), (528, 22, 15), (529, 3, 100), (530, 12, 50), (531, 7, 10),
(532, 14, 45), (533, 1, 25), (533, 2, 25), (534, 27, 30), (535, 10, 100), (536, 11, 60),
(537, 23, 12), (538, 5, 5), (539, 30, 15), (540, 20, 8), (541, 15, 10), (541, 16, 10),
(542, 25, 20), (543, 6, 15), (544, 9, 50), (545, 4, 40), (546, 21, 25), (547, 8, 30),
(548, 24, 15), (549, 19, 10), (550, 1, 50), 
(601, 1, 10), (602, 1, 10), (603, 1, 10), (701, 1, 5);

-- =================================================================
-- 11. GUIAS DE SAÍDA 
-- =================================================================
INSERT INTO Guia_Saida (id_guia, data_guia, num_encomenda_origem, func_responsavel) VALUES
(5501, '2015-05-21', 501, 10),
(5502, '2018-06-30', 502, 12), 
(5504, '2018-06-02', 504, 13),
(5507, '2018-10-11', 507, 12),
(5508, '2019-01-16', 508, 10),
(5511, '2024-01-02', 511, 14),
(5512, '2019-05-13', 512, 17),
(5513, '2019-06-21', 513, 17),
(5514, '2019-08-16', 514, 18),
(5515, '2019-11-03', 515, 18),
(5516, '2020-01-11', 516, 19),
(5517, '2020-02-15', 517, 19),
(5518, '2020-03-31', 518, 20),
(5520, '2020-07-21', 520, 21),
(5521, '2020-09-11', 521, 21),
(5522, '2021-01-16', 522, 22),
(5523, '2021-03-01', 523, 22),
(5525, '2021-06-02', 525, 23),
(5526, '2021-08-19', 526, 24),
(5527, '2021-10-06', 527, 24),
(5528, '2021-12-21', 528, 25),
(5529, '2022-01-11', 529, 25),
(5531, '2022-05-21', 531, 26),
(5532, '2022-07-08', 532, 27),
(5533, '2022-09-10', 533, 27),
(5534, '2022-11-12', 534, 28),
(5536, '2023-02-15', 536, 29),
(5537, '2023-03-31', 537, 29),
(5538, '2023-04-16', 538, 30),
(5539, '2023-05-21', 539, 30),
(5541, '2023-07-26', 541, 18),
(5542, '2023-08-31', 542, 19),
(5543, '2023-09-16', 543, 20),
(5545, '2023-11-21', 545, 22),
(5546, '2023-12-06', 546, 23),
(5547, '2024-01-11', 547, 24),
(5549, '2024-03-02', 549, 26),
(5550, '2024-03-21', 550, 27),
(5701, '2019-05-21', 701, 2);

-- =================================================================
-- 12. DETALHES DAS GUIAS 
-- =================================================================
INSERT INTO Guia_Saida_Detalhe (id_guia, referencia_artigo, id_zona, quantidade_retirada) VALUES
(5501, 4, 101, 200),
(5502, 1, 101, 10),
(5504, 3, 101, 50),
(5507, 6, 101, 2),
(5508, 1, 101, 20),
(5511, 4, 101, 500),
(5512, 10, 801, 50), 
(5512, 11, 801, 20),
(5513, 15, 801, 5),
(5514, 20, 1001, 10),
(5514, 21, 1001, 2),
(5515, 30, 1001, 10),
(5516, 5, 901, 15),
(5517, 1, 901, 100),
(5518, 28, 1101, 500),
(5520, 8, 1201, 20), (5520, 9, 1201, 20), 
(5521, 13, 1201, 40),
(5522, 24, 1301, 10), (5522, 25, 1301, 5), 
(5523, 2, 1301, 60),
(5525, 29, 1401, 200), 
(5526, 17, 1501, 30), (5526, 18, 1501, 60), (5526, 19, 1501, 5), 
(5527, 26, 1501, 20),
(5528, 22, 1601, 15), 
(5529, 3, 1601, 100),
(5531, 7, 1701, 10), 
(5532, 14, 1801, 45), 
(5533, 1, 1801, 25), (5533, 2, 1801, 25),
(5534, 27, 1901, 30), 
(5536, 11, 2001, 60), 
(5537, 23, 2001, 12),
(5538, 5, 2101, 5), 
(5539, 30, 2101, 15),
(5541, 15, 1001, 10), (5541, 16, 1001, 10),
(5542, 25, 901, 20),
(5543, 6, 1101, 15),
(5545, 4, 1301, 40),
(5546, 21, 1401, 25),
(5547, 8, 1501, 30),
(5549, 19, 1701, 10),
(5550, 1, 1801, 50),
(5701, 1, 101, 5); 

-- =================================================================
-- 13. TRANSPORTES 
-- =================================================================
INSERT INTO Transporte (id_transporte, nif_transportadora, cod_cliente_destino, data_transporte, num_horas_utilizacao) VALUES
(9501, 900100100, 1, '2015-05-21 10:00:00', 2.5),
(9502, 900200200, 2, '2018-06-30 11:00:00', 3.0),
(9504, 900300300, 3, '2018-06-02 14:00:00', 1.5),
(9507, 900100100, 6, '2018-10-11 09:30:00', 4.0),
(9508, 900200200, 7, '2019-01-16 15:00:00', 2.0),
(9511, 900300300, 10, '2024-01-02 10:00:00', 5.0),
(9512, 900400400, 11, '2019-05-13 11:00:00', 3.5), 
(9513, 900400400, 12, '2019-06-21 12:00:00', 1.0),
(9514, 900500500, 13, '2019-08-16 16:00:00', 2.5),
(9515, 900500500, 14, '2019-11-03 09:00:00', 3.0),
(9516, 900600600, 15, '2020-01-11 10:30:00', 4.5),
(9517, 900600600, 16, '2020-02-15 14:00:00', 1.5),
(9518, 900700700, 17, '2020-03-31 11:00:00', 2.0),
(9520, 900800800, 19, '2020-07-21 15:30:00', 3.0),
(9521, 900800800, 20, '2020-09-11 09:00:00', 1.0),
(9522, 900900900, 21, '2021-01-16 10:00:00', 2.5),
(9523, 900900900, 22, '2021-03-01 13:00:00', 4.0),
(9525, 901000000, 24, '2021-06-02 11:30:00', 3.5),
(9526, 901100100, 25, '2021-08-19 14:00:00', 2.0),
(9527, 901100100, 26, '2021-10-06 16:00:00', 1.5),
(9528, 901200200, 27, '2021-12-21 09:30:00', 5.0),
(9529, 901200200, 28, '2022-01-11 10:00:00', 2.0),
(9531, 901300300, 30, '2022-05-21 12:00:00', 3.0),
(9532, 901400400, 31, '2022-07-08 15:00:00', 4.0),
(9533, 901400400, 32, '2022-09-10 11:00:00', 1.5),
(9534, 901500500, 33, '2022-11-12 14:30:00', 2.5),
(9536, 901600600, 35, '2023-02-15 09:00:00', 3.5),
(9537, 901600600, 36, '2023-03-31 13:00:00', 2.0),
(9538, 901700700, 37, '2023-04-16 10:00:00', 1.5),
(9539, 901700700, 38, '2023-05-21 15:00:00', 4.0),
(9541, 901800800, 40, '2023-07-26 11:00:00', 3.0),
(9542, 901900900, 41, '2023-08-31 14:00:00', 2.0),
(9543, 902000000, 42, '2023-09-16 09:30:00', 5.0),
(9545, 902100100, 44, '2023-11-21 10:00:00', 3.5),
(9546, 902200200, 45, '2023-12-06 12:00:00', 4.0),
(9547, 902300300, 46, '2024-01-11 15:00:00', 2.5),
(9549, 902400400, 48, '2024-03-02 11:00:00', 1.0),
(9550, 902500500, 49, '2024-03-21 14:00:00', 3.0),
(9701, 900100100, 1, '2019-05-21 16:00:00', 1.0);

-- =================================================================
-- 14. CONTEÚDO DO TRANSPORTE 
-- =================================================================
INSERT INTO Transporte_Conteudo (id_transporte, id_guia) VALUES
(9501, 5501), (9502, 5502), (9504, 5504), (9507, 5507), (9508, 5508), (9511, 5511),
(9512, 5512), (9513, 5513), (9514, 5514), (9515, 5515), (9516, 5516), (9517, 5517),
(9518, 5518), (9520, 5520), (9521, 5521), (9522, 5522), (9523, 5523), (9525, 5525),
(9526, 5526), (9527, 5527), (9528, 5528), (9529, 5529), (9531, 5531), (9532, 5532),
(9533, 5533), (9534, 5534), (9536, 5536), (9537, 5537), (9538, 5538), (9539, 5539),
(9541, 5541), (9542, 5542), (9543, 5543), (9545, 5545), (9546, 5546), (9547, 5547),
(9549, 5549), (9550, 5550), (9701, 5701);
GO