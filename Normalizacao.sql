SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `locacao_automoveis` DEFAULT CHARACTER SET utf8 ;
USE `locacao_automoveis` ;

CREATE TABLE IF NOT EXISTS `locacao_automoveis`.`Clientes` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nome_cliente` VARCHAR(80) NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `data_de_nascimento` DATE NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `locacao_automoveis`.`Veiculos` (
  `idVeiculo` INT NOT NULL AUTO_INCREMENT,
  `placa` VARCHAR(8) NULL,
  `modelo` VARCHAR(30) NULL,
  `cor` VARCHAR(30) NULL,
  `valorDiaria` DECIMAL(10,2) NULL,
  PRIMARY KEY (`idVeiculo`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `locacao_automoveis`.`Locacao` (
  `CodLocacao` INT NOT NULL,
  `Dias_de_locacao` INT NULL,
  `Clientes_idCliente` INT NOT NULL,
  `Veiculos_idVeiculo` INT NOT NULL,
  PRIMARY KEY (`CodLocacao`, `Clientes_idCliente`, `Veiculos_idVeiculo`),
  INDEX `fk_Locacao_Clientes_idx` (`Clientes_idCliente` ASC) VISIBLE,
  INDEX `fk_Locacao_Veiculos1_idx` (`Veiculos_idVeiculo` ASC) VISIBLE,
  CONSTRAINT `fk_Locacao_Clientes`
    FOREIGN KEY (`Clientes_idCliente`)
    REFERENCES `locacao_automoveis`.`Clientes` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Locacao_Veiculos1`
    FOREIGN KEY (`Veiculos_idVeiculo`)
    REFERENCES `locacao_automoveis`.`Veiculos` (`idVeiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

# O primeiro comando insere cinco registros na tabela `Clientes`.

insert into Clientes(nome_cliente, cpf, data_de_nascimento)
values ('Ariano Suassuna', '123.456.789-01', '1997-05-21'),
('Grace Hopper', '543.765.987-23', '2002-04-29'),
('Richard Feynman', '987.654.231-90', '2001-10-12'),
('Edgar Poe', '432.765.678-67', '1998-12-14'),
('Gordon Freeman', '927.384.284-44', '1984-11-26');

# O comando `insert into` é usado para inserir registros em uma tabela.

# O comando `values` é usado para especificar os valores dos registros que serão inseridos.

# Cada registro na tabela `Clientes` contém as seguintes informações:

# * nome_cliente: nome do cliente
# * cpf: número do CPF do cliente
# * data_de_nascimento: data de nascimento do cliente

# Os valores dos registros são especificados como uma lista de pares `nome_da_coluna`, `valor`.

# Por exemplo, o primeiro registro é inserido com os seguintes valores:

# nome_cliente: Ariano Suassuna
# cpf: 123.456.789-01
# data_de_nascimento: 1997-05-21

# O segundo registro é inserido com os seguintes valores:

# nome_cliente: Grace Hopper
# cpf: 543.765.987-23
# data_de_nascimento: 2002-04-29

# E assim por diante.

# O segundo comando insere cinco registros na tabela `Veiculos`.

insert into Veiculos(placa, modelo, cor, valorDiaria)
values ('WER-3456', 'Fusca', 'Preto', 30.0), ('FDS-8384', 'Variante', 'Rosa', 60.0),
('CVB-9933', 'Comodoro', 'Preto', 20.0), ('FGH-2256', 'Deloriam', 'Azul', 80.0),
('DDI-3948', 'Brasilia', 'Amarelo', 45.0);


# Cada registro na tabela `Veiculos` contém as seguintes informações:

# * placa: placa do veículo
# * modelo: modelo do veículo
# * cor: cor do veículo
# * valorDiaria: valor da diária do veículo

# Por exemplo, o primeiro registro é inserido com os seguintes valores:

# placa: WER-3456
# modelo: Fusca
# cor: Preto
# valorDiaria: 30.0

# O segundo registro é inserido com os seguintes valores:

# placa: FDS-8384
# modelo: Variante
# cor: Rosa
# valorDiaria: 60.0

# E assim por diante.

# O terceiro comando insere cinco registros na tabela `Locacao`.

insert into Locacao(CodLocacao, Dias_de_locacao, Clientes_idCliente, Veiculos_idVeiculo)
values (101, 3, 1, 1), (102, 7, 2, 2), (103, 1, 3, 3), (104, 3, 4, 4), (105, 7, 5, 5);

create view Locacao_e_seus_Veiculos_e_Clientes as
	select l.CodLocacao, v.idVeiculo, v.placa, v.modelo, v.cor, c.idCliente,
    c.nome_cliente, c.cpf, c.data_de_nascimento, v.valorDiaria, l.Dias_de_locacao
	from Locacao l inner join Veiculos v
		on l.Veiculos_idVeiculo = v.idVeiculo
	inner join Clientes c on l.Clientes_idCliente = c.idCliente;

select locacaoVeiculoCliente.*, (select (locacaoVeiculoCliente.valorDiaria * locacaoVeiculoCliente.Dias_de_Locacao)) as 'total_(R$)' 
from Locacao_e_seus_Veiculos_e_Clientes locacaoVeiculoCliente;