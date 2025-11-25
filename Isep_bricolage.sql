/* SCRIPT CORRIGIDO E COMPLETO 
   Para o trabalho: IsepBricolage
*/

-- 1. CRIAÇÃO DA BASE DE DADOS (Só corre se ela não existir)
IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'IsepBricolage')
BEGIN
    CREATE DATABASE IsepBricolage;
END
GO

-- 2. GARANTIR QUE USAMOS A BASE DE DADOS CERTA
USE IsepBricolage;
GO

-- 3. LIMPEZA (Apagar tabelas antigas se existirem para não dar erro ao recriar)
-- A ordem é importante por causa das setas (chaves estrangeiras)
DROP TABLE IF EXISTS Transporte_Conteudo;
DROP TABLE IF EXISTS Transporte;
DROP TABLE IF EXISTS Guia_Saida_Detalhe;
DROP TABLE IF EXISTS Guia_Saida;
DROP TABLE IF EXISTS Nota_Encomenda_Detalhe;
DROP TABLE IF EXISTS Nota_Encomenda;
DROP TABLE IF EXISTS Stock_Armazem;
DROP TABLE IF EXISTS Historico_Preco;
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Transportadora;
DROP TABLE IF EXISTS Artigo;
DROP TABLE IF EXISTS Zona_Fisica;
DROP TABLE IF EXISTS Armazem;
GO

-- 4. CRIAÇÃO DAS TABELAS (Modelo Corrigido)

CREATE TABLE Armazem (
    cod_armazem INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    morada VARCHAR(255) NOT NULL,
    loc_geo_wgs84 VARCHAR(100)
);

CREATE TABLE Zona_Fisica (
    id_zona INT PRIMARY KEY,
    nome_zona VARCHAR(50),
    cod_armazem INT NOT NULL,
    capacidade_volume DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (cod_armazem) REFERENCES Armazem(cod_armazem)
);

CREATE TABLE Artigo (
    referencia INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    preco_compra DECIMAL(10,2) NOT NULL,
    preco_venda DECIMAL(10,2) NOT NULL,
    unidade VARCHAR(20)
);

CREATE TABLE Historico_Preco (
    id_historico INT PRIMARY KEY,
    referencia_artigo INT NOT NULL,
    preco_antigo DECIMAL(10,2) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    FOREIGN KEY (referencia_artigo) REFERENCES Artigo(referencia)
);

CREATE TABLE Transportadora (
    nif INT PRIMARY KEY,
    nome VARCHAR(100) UNIQUE NOT NULL,
    contacto_telefonico VARCHAR(20),
    custo_hora DECIMAL(10,2) NOT NULL
);

CREATE TABLE Cliente (
    cod_cliente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    morada VARCHAR(255),
    codigo_postal VARCHAR(20),
    telemovel VARCHAR(20),
    nif INT UNIQUE NOT NULL,
    zona_geografica VARCHAR(50),
    tipo_cliente VARCHAR(20)
);

CREATE TABLE Funcionario(
 num_funcionario INT PRIMARY KEY,
    cartao_cidadao INT UNIQUE NOT NULL,
    nome VARCHAR(100) NOT NULL,
    morada VARCHAR(255),
    nif INT UNIQUE NOT NULL,
    salario_mensal DECIMAL(10,2),
    categoria VARCHAR(50),
    zona_geografica VARCHAR(50), 
    cod_supervisor INT,
    cod_armazem INT NOT NULL,
    FOREIGN KEY (cod_supervisor) REFERENCES Funcionario(num_funcionario),
    FOREIGN KEY (cod_armazem) REFERENCES Armazem(cod_armazem)
    );

CREATE TABLE Stock_Armazem (
    cod_armazem INT,
    referencia_artigo INT,
    stock_minimo INT NOT NULL,
    quantidade_total INT DEFAULT 0,
    PRIMARY KEY (cod_armazem, referencia_artigo),
    FOREIGN KEY (cod_armazem) REFERENCES Armazem(cod_armazem),
    FOREIGN KEY (referencia_artigo) REFERENCES Artigo(referencia)
);

CREATE TABLE Nota_Encomenda (
    num_encomenda INT PRIMARY KEY,
    data_encomenda DATE NOT NULL,
    cod_cliente INT NOT NULL,
    num_vendedor INT NOT NULL,
    cod_armazem INT NOT NULL,--
    estado VARCHAR(20) CHECK (estado IN ('Pendente', 'Processada')),
    FOREIGN KEY (cod_cliente) REFERENCES Cliente(cod_cliente),
    FOREIGN KEY (num_vendedor) REFERENCES Funcionario(num_funcionario),
    FOREIGN KEY (cod_armazem) REFERENCES Armazem(cod_armazem)--
);

CREATE TABLE Nota_Encomenda_Detalhe (
    num_encomenda INT,
    referencia_artigo INT,
    quantidade INT NOT NULL,
    PRIMARY KEY (num_encomenda, referencia_artigo),
    FOREIGN KEY (num_encomenda) REFERENCES Nota_Encomenda(num_encomenda),
    FOREIGN KEY (referencia_artigo) REFERENCES Artigo(referencia)
);

CREATE TABLE Guia_Saida (
    id_guia INT PRIMARY KEY,
    data_guia DATETIME DEFAULT GETDATE(),
    num_encomenda_origem INT UNIQUE NOT NULL,
    func_responsavel INT NOT NULL,
    FOREIGN KEY (num_encomenda_origem) REFERENCES Nota_Encomenda(num_encomenda),
    FOREIGN KEY (func_responsavel) REFERENCES Funcionario(num_funcionario)
);

CREATE TABLE Guia_Saida_Detalhe (
    id_guia INT,
    referencia_artigo INT,
    id_zona INT,
    quantidade_retirada INT NOT NULL,
    PRIMARY KEY (id_guia, referencia_artigo, id_zona),
    FOREIGN KEY (id_guia) REFERENCES Guia_Saida(id_guia),
    FOREIGN KEY (referencia_artigo) REFERENCES Artigo(referencia),
    FOREIGN KEY (id_zona) REFERENCES Zona_Fisica(id_zona)
);

CREATE TABLE Transporte (
    id_transporte INT PRIMARY KEY,
    nif_transportadora INT NOT NULL,
    cod_cliente_destino INT NOT NULL,
    data_transporte DATETIME NOT NULL,
    num_horas_utilizacao DECIMAL(4,2),
    FOREIGN KEY (nif_transportadora) REFERENCES Transportadora(nif),
    FOREIGN KEY (cod_cliente_destino) REFERENCES Cliente(cod_cliente)
);

CREATE TABLE Transporte_Conteudo (
    id_transporte INT,
    id_guia INT UNIQUE,
    PRIMARY KEY (id_transporte, id_guia),
    FOREIGN KEY (id_transporte) REFERENCES Transporte(id_transporte),
    FOREIGN KEY (id_guia) REFERENCES Guia_Saida(id_guia)
);