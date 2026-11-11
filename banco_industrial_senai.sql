-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 10/11/2026 às 14:32
-- Versão do servidor: 8.0.42-0ubuntu0.24.04.1
-- Versão do PHP: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `banco_industrial_senai`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `COMPONENTES_MAQ`
--

CREATE TABLE `COMPONENTES_MAQ` (
  `id_componente` int NOT NULL,
  `id_maquina` int NOT NULL,
  `nome_componente` varchar(100) NOT NULL,
  `horas_uso_acumulado` int NOT NULL DEFAULT '0',
  `limite_horas_alerta` int NOT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `ESTOQUE_PECAS`
--

CREATE TABLE `ESTOQUE_PECAS` (
  `id_peca` int NOT NULL,
  `codigo_part_number` varchar(50) NOT NULL,
  `descricao` varchar(150) NOT NULL,
  `qtd_estoque` int NOT NULL,
  `preco_unitario` decimal(10,2) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `HISTORICO_SENSORES`
--

CREATE TABLE `HISTORICO_SENSORES` (
  `id_leitura` int NOT NULL,
  `id_ordem` int NOT NULL,
  `temperatura_medida` decimal(5,2) NOT NULL,
  `vibracao_mm_s` decimal(5,2) NOT NULL,
  `data_hora_leitura` datetime NOT NULL,
  `prompt_geracao_ia` varchar(100) DEFAULT 'GERADO_POR_LLM'
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `LINHAS_PRODUCAO`
--

CREATE TABLE `LINHAS_PRODUCAO` (
  `id_linha` int NOT NULL,
  `id_unidade` int NOT NULL,
  `nome_linha` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `MAQUINAS_SENAI`
--

CREATE TABLE `MAQUINAS_SENAI` (
  `id_maquina` int NOT NULL,
  `id_linha` int NOT NULL,
  `id_tipo` int NOT NULL,
  `tag_patrimonio` varchar(30) NOT NULL,
  `data_aquisicao` date NOT NULL,
  `status_operacao` varchar(20) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `ORDENS_SERVICO`
--

CREATE TABLE `ORDENS_SERVICO` (
  `id_ordem` int NOT NULL,
  `id_maquina` int NOT NULL,
  `id_tecnico` int NOT NULL,
  `data_abertura` datetime NOT NULL,
  `tipo_manutencao` varchar(20) NOT NULL,
  `status_os` varchar(20) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `PECAS_OS`
--

CREATE TABLE `PECAS_OS` (
  `id_ordem` int NOT NULL,
  `id_peca` int NOT NULL,
  `qtd_utilizada` int NOT NULL,
  `preco_aplicado` decimal(10,2) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `TECNICOS`
--

CREATE TABLE `TECNICOS` (
  `id_tecnico` int NOT NULL,
  `nome_tecnico` varchar(100) NOT NULL,
  `especialidade` varchar(50) NOT NULL,
  `nivel_certificacao` varchar(30) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `TIPOS_MAQUINA`
--

CREATE TABLE `TIPOS_MAQUINA` (
  `id_tipo` int NOT NULL,
  `nome_tipo` varchar(50) NOT NULL,
  `horas_revisao_padrao` int NOT NULL
) ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `UNIDADES_SENAI`
--

CREATE TABLE `UNIDADES_SENAI` (
  `id_unidade` int NOT NULL,
  `nome_unidade` varchar(100) NOT NULL,
  `cidade` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `COMPONENTES_MAQ`
--
ALTER TABLE `COMPONENTES_MAQ`
  ADD PRIMARY KEY (`id_componente`),
  ADD KEY `fk_componentes_maquinas` (`id_maquina`);

--
-- Índices de tabela `ESTOQUE_PECAS`
--
ALTER TABLE `ESTOQUE_PECAS`
  ADD PRIMARY KEY (`id_peca`),
  ADD UNIQUE KEY `uq_codigo` (`codigo_part_number`);

--
-- Índices de tabela `HISTORICO_SENSORES`
--
ALTER TABLE `HISTORICO_SENSORES`
  ADD PRIMARY KEY (`id_leitura`),
  ADD KEY `fk_historico_ordens` (`id_ordem`);

--
-- Índices de tabela `LINHAS_PRODUCAO`
--
ALTER TABLE `LINHAS_PRODUCAO`
  ADD PRIMARY KEY (`id_linha`),
  ADD KEY `fk_linhas_unidades` (`id_unidade`);

--
-- Índices de tabela `MAQUINAS_SENAI`
--
ALTER TABLE `MAQUINAS_SENAI`
  ADD PRIMARY KEY (`id_maquina`),
  ADD UNIQUE KEY `uq_tag` (`tag_patrimonio`),
  ADD KEY `fk_maquinas_linhas` (`id_linha`),
  ADD KEY `fk_maquinas_tipos` (`id_tipo`);

--
-- Índices de tabela `ORDENS_SERVICO`
--
ALTER TABLE `ORDENS_SERVICO`
  ADD PRIMARY KEY (`id_ordem`),
  ADD KEY `fk_ordens_maquinas` (`id_maquina`),
  ADD KEY `fk_ordens_tecnicos` (`id_tecnico`);

--
-- Índices de tabela `PECAS_OS`
--
ALTER TABLE `PECAS_OS`
  ADD PRIMARY KEY (`id_ordem`,`id_peca`),
  ADD KEY `fk_pecas_estoque` (`id_peca`);

--
-- Índices de tabela `TECNICOS`
--
ALTER TABLE `TECNICOS`
  ADD PRIMARY KEY (`id_tecnico`);

--
-- Índices de tabela `TIPOS_MAQUINA`
--
ALTER TABLE `TIPOS_MAQUINA`
  ADD PRIMARY KEY (`id_tipo`);

--
-- Índices de tabela `UNIDADES_SENAI`
--
ALTER TABLE `UNIDADES_SENAI`
  ADD PRIMARY KEY (`id_unidade`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `COMPONENTES_MAQ`
--
ALTER TABLE `COMPONENTES_MAQ`
  MODIFY `id_componente` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `ESTOQUE_PECAS`
--
ALTER TABLE `ESTOQUE_PECAS`
  MODIFY `id_peca` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `HISTORICO_SENSORES`
--
ALTER TABLE `HISTORICO_SENSORES`
  MODIFY `id_leitura` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `LINHAS_PRODUCAO`
--
ALTER TABLE `LINHAS_PRODUCAO`
  MODIFY `id_linha` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `MAQUINAS_SENAI`
--
ALTER TABLE `MAQUINAS_SENAI`
  MODIFY `id_maquina` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `ORDENS_SERVICO`
--
ALTER TABLE `ORDENS_SERVICO`
  MODIFY `id_ordem` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `TECNICOS`
--
ALTER TABLE `TECNICOS`
  MODIFY `id_tecnico` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `TIPOS_MAQUINA`
--
ALTER TABLE `TIPOS_MAQUINA`
  MODIFY `id_tipo` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `UNIDADES_SENAI`
--
ALTER TABLE `UNIDADES_SENAI`
  MODIFY `id_unidade` int NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `COMPONENTES_MAQ`
--
ALTER TABLE `COMPONENTES_MAQ`
  ADD CONSTRAINT `fk_componentes_maquinas` FOREIGN KEY (`id_maquina`) REFERENCES `MAQUINAS_SENAI` (`id_maquina`);

--
-- Restrições para tabelas `HISTORICO_SENSORES`
--
ALTER TABLE `HISTORICO_SENSORES`
  ADD CONSTRAINT `fk_historico_ordens` FOREIGN KEY (`id_ordem`) REFERENCES `ORDENS_SERVICO` (`id_ordem`);

--
-- Restrições para tabelas `LINHAS_PRODUCAO`
--
ALTER TABLE `LINHAS_PRODUCAO`
  ADD CONSTRAINT `fk_linhas_unidades` FOREIGN KEY (`id_unidade`) REFERENCES `UNIDADES_SENAI` (`id_unidade`);

--
-- Restrições para tabelas `MAQUINAS_SENAI`
--
ALTER TABLE `MAQUINAS_SENAI`
  ADD CONSTRAINT `fk_maquinas_linhas` FOREIGN KEY (`id_linha`) REFERENCES `LINHAS_PRODUCAO` (`id_linha`),
  ADD CONSTRAINT `fk_maquinas_tipos` FOREIGN KEY (`id_tipo`) REFERENCES `TIPOS_MAQUINA` (`id_tipo`);

--
-- Restrições para tabelas `ORDENS_SERVICO`
--
ALTER TABLE `ORDENS_SERVICO`
  ADD CONSTRAINT `fk_ordens_maquinas` FOREIGN KEY (`id_maquina`) REFERENCES `MAQUINAS_SENAI` (`id_maquina`),
  ADD CONSTRAINT `fk_ordens_tecnicos` FOREIGN KEY (`id_tecnico`) REFERENCES `TECNICOS` (`id_tecnico`);

--
-- Restrições para tabelas `PECAS_OS`
--
ALTER TABLE `PECAS_OS`
  ADD CONSTRAINT `fk_pecas_estoque` FOREIGN KEY (`id_peca`) REFERENCES `ESTOQUE_PECAS` (`id_peca`),
  ADD CONSTRAINT `fk_pecas_ordens` FOREIGN KEY (`id_ordem`) REFERENCES `ORDENS_SERVICO` (`id_ordem`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
