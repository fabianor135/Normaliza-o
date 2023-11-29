CREATE TABLE Locacao (
    CodLocacao INT PRIMARY KEY,
    Veiculo VARCHAR(50),
    Cliente VARCHAR(50),
    Diaria DECIMAL(5, 2),
    Nascimento DATE,
    Dias INT
);
INSERT INTO Locacao (CodLocacao, Veiculo, Cliente, Diaria, Nascimento, Dias) VALUES(101, 'Fusca', 'Ariano Suassuna', 30.00, '2022-05-21', 3);
INSERT INTO Locacao (CodLocacao, Veiculo, Cliente, Diaria, Nascimento, Dias) VALUES(102, 'Variante', 'Grace Hopper', 60.00, '2022-04-29', 7);
INSERT INTO Locacao (CodLocacao, Veiculo, Cliente, Diaria, Nascimento, Dias) VALUES(103, 'Comodoro', 'Richard Feynman', 20.00, '2001-10-12', 1);
INSERT INTO Locacao (CodLocacao, Veiculo, Cliente, Diaria, Nascimento, Dias) VALUES(104, 'Deloriam', 'Edgar Poe', 80.00, '1998-12-17', 3);
INSERT INTO Locacao (CodLocacao, Veiculo, Cliente, Diaria, Nascimento, Dias) VALUES(105, 'Brasilia', 'Gorodon Freeman', 45.00, '1984-11-26', 7);


CREATE TABLE Veiculo (
    Veiculo VARCHAR(50) PRIMARY KEY,
    Cor VARCHAR(20),
    Placa VARCHAR(10),
    Diaria DECIMAL(5, 2)
);

INSERT INTO Veiculo (Veiculo, Cor, Placa, Diaria) VALUES('Fusca', 'Preto', 'WER-3456', 30.00);
INSERT INTO Veiculo (Veiculo, Cor, Placa, Diaria) VALUES('Variante', 'Rosa', 'FDS-384', 60.00);
INSERT INTO Veiculo (Veiculo, Cor, Placa, Diaria) VALUES('Comodoro', 'Preto', 'CVB-9933', 20.00);
INSERT INTO Veiculo (Veiculo, Cor, Placa, Diaria) VALUES('Deloriam', 'Azul', 'FGH-2256', 80.00);
INSERT INTO Veiculo (Veiculo, Cor, Placa, Diaria) VALUES('Brasilia', 'Amarelo', 'DDI-3948', 45.00);

CREATE TABLE Cliente (
    Cliente VARCHAR(50) PRIMARY KEY,
    CPF VARCHAR(14),
    Nascimento DATE
);

INSERT INTO Cliente (Cliente, CPF, Nascimento) VALUES('Ariano Suassuna', '123.456.789-01', '2022-05-21');
INSERT INTO Cliente (Cliente, CPF, Nascimento) VALUES('Grace Hopper', '543.765.987-23', '2022-04-29');
INSERT INTO Cliente (Cliente, CPF, Nascimento) VALUES('Richard Feynman', '987.654.231-90', '2001-10-12');
INSERT INTO Cliente (Cliente, CPF, Nascimento) VALUES('Edgar Poe', '432.765.678-67', '1998-12-17');
INSERT INTO Cliente (Cliente, CPF, Nascimento) VALUES('Gorodon Freeman', '927.384.284-44', '1984-11-26');

CREATE VIEW ViewLocacoes AS
SELECT
    L.CodLocacao,
    L.Veiculo,
    V.Cor,
    V.Placa,
    V.Diaria AS DiariaVeiculo,
    L.Cliente,
    C.CPF,
    C.Nascimento AS NascimentoCliente,
    L.Diaria,
    L.Nascimento,
    L.Dias
FROM
    Locacao L
JOIN Veiculo V ON L.Veiculo = V.Veiculo
JOIN Cliente C ON L.Cliente = C.Cliente;

CREATE TABLE LocacaoTotal (
    CodLocacao INT PRIMARY KEY,
    Total DECIMAL(8, 2),
    FOREIGN KEY (CodLocacao) REFERENCES Locacao(CodLocacao)
);
INSERT INTO LocacaoTotal (CodLocacao, Total)
SELECT CodLocacao, Diaria * Dias AS Total
FROM Locacao;


