CREATE DATABASE  IF NOT EXISTS `agendars` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `agendars`;
-- MySQL dump 10.13  Distrib 5.5.16, for osx10.5 (i386)
--
-- Host: localhost    Database: agendars
-- ------------------------------------------------------
-- Server version	5.5.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


--
-- Table structure for table `contato`
--

DROP TABLE IF EXISTS `contato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contato` (
  `codigoContato` int(10) NOT NULL AUTO_INCREMENT,
  `nome` varchar(80) DEFAULT NULL,
  `sobrenome` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`codigoContato`),
  UNIQUE KEY `pmkCodigoContato` (`codigoContato`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contato`
--

LOCK TABLES `contato` WRITE;
/*!40000 ALTER TABLE `contato` DISABLE KEYS */;
/*!40000 ALTER TABLE `contato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telefone`
--

DROP TABLE IF EXISTS `telefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `telefone` (
  `codigoTelefone` int(10) NOT NULL AUTO_INCREMENT,
  `codigoTipoTelefone` int(10) DEFAULT NULL,
  `numero` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`codigoTelefone`),
  UNIQUE KEY `pmkTelefone` (`codigoTelefone`),
  UNIQUE KEY `idxNumero` (`numero`),
  KEY `FK_telefone_codigoTipoTelefone` (`codigoTipoTelefone`),
  CONSTRAINT `FK_telefone_codigoTipoTelefone` FOREIGN KEY (`codigoTipoTelefone`) REFERENCES `tipotelefone` (`codigoTipoTelefone`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tipotelefone`
--

DROP TABLE IF EXISTS `tipotelefone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipotelefone` (
  `codigoTipoTelefone` int(10) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`codigoTipoTelefone`),
  UNIQUE KEY `pmkCodigoTipoTelefone` (`codigoTipoTelefone`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipotelefone`
--

LOCK TABLES `tipotelefone` WRITE;
/*!40000 ALTER TABLE `tipotelefone` DISABLE KEYS */;
INSERT INTO `tipotelefone` VALUES (1,'Celular'),(2,'Residencial'),(3,'Comercial'),(4,'Recado');
/*!40000 ALTER TABLE `tipotelefone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `telefone`
--

LOCK TABLES `telefone` WRITE;
/*!40000 ALTER TABLE `telefone` DISABLE KEYS */;
/*!40000 ALTER TABLE `telefone` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `contatotelefones`
--

DROP TABLE IF EXISTS `contatotelefones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contatotelefones` (
  `codigoContato` int(10) DEFAULT NULL,
  `codigoTelefone` int(10) DEFAULT NULL,
  UNIQUE KEY `pmkContatoTelefones` (`codigoContato`,`codigoTelefone`),
  KEY `FK_contatotelefones_codigoTelefone` (`codigoTelefone`),
  CONSTRAINT `FK_contatotelefones_codigoContato` FOREIGN KEY (`codigoContato`) REFERENCES `contato` (`codigoContato`),
  CONSTRAINT `FK_contatotelefones_codigoTelefone` FOREIGN KEY (`codigoTelefone`) REFERENCES `telefone` (`codigoTelefone`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contatotelefones`
--

LOCK TABLES `contatotelefones` WRITE;
/*!40000 ALTER TABLE `contatotelefones` DISABLE KEYS */;
/*!40000 ALTER TABLE `contatotelefones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contatoenderecos`
--

DROP TABLE IF EXISTS `contatoenderecos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contatoenderecos` (
  `codigoContato` int(10) DEFAULT NULL,
  `codigoEndereco` int(10) DEFAULT NULL,
  UNIQUE KEY `pmkContatoEnderecos` (`codigoContato`,`codigoEndereco`),
  KEY `FK_contatoenderecos_codigoEndereco` (`codigoEndereco`),
  CONSTRAINT `FK_contatoenderecos_codigoContato` FOREIGN KEY (`codigoContato`) REFERENCES `contato` (`codigoContato`),
  CONSTRAINT `FK_contatoenderecos_codigoEndereco` FOREIGN KEY (`codigoEndereco`) REFERENCES `endereco` (`codigoEndereco`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contatoenderecos`
--

LOCK TABLES `contatoenderecos` WRITE;
/*!40000 ALTER TABLE `contatoenderecos` DISABLE KEYS */;
/*!40000 ALTER TABLE `contatoenderecos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipocontato`
--

DROP TABLE IF EXISTS `tipocontato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipocontato` (
  `codigoTipoContato` int(10) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`codigoTipoContato`),
  UNIQUE KEY `idxCodigoTipoContato` (`codigoTipoContato`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipocontato`
--

LOCK TABLES `tipocontato` WRITE;
/*!40000 ALTER TABLE `tipocontato` DISABLE KEYS */;
INSERT INTO `tipocontato` VALUES (1,'Familiar'),(2,'Profissional');
/*!40000 ALTER TABLE `tipocontato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contatotipos`
--

DROP TABLE IF EXISTS `contatotipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contatotipos` (
  `codigoContato` int(10) DEFAULT NULL,
  `codigoTipoContato` int(10) DEFAULT NULL,
  UNIQUE KEY `pmkContatoTipos` (`codigoContato`,`codigoTipoContato`),
  KEY `FK_contatotipos_codigoTipoContato` (`codigoTipoContato`),
  CONSTRAINT `FK_contatotipos_codigoContato` FOREIGN KEY (`codigoContato`) REFERENCES `contato` (`codigoContato`),
  CONSTRAINT `FK_contatotipos_codigoTipoContato` FOREIGN KEY (`codigoTipoContato`) REFERENCES `tipocontato` (`codigoTipoContato`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contatotipos`
--

LOCK TABLES `contatotipos` WRITE;
/*!40000 ALTER TABLE `contatotipos` DISABLE KEYS */;
/*!40000 ALTER TABLE `contatotipos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tarefa`
--

DROP TABLE IF EXISTS `tarefa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tarefa` (
  `codigoTarefa` int(10) NOT NULL AUTO_INCREMENT,
  `codigoTarefaStatus` int(10) unsigned NOT NULL,
  `dataInicio` datetime DEFAULT NULL,
  `horaInicial` datetime DEFAULT NULL,
  `dataLimite` datetime DEFAULT NULL,
  `horaLimite` datetime DEFAULT NULL,
  `titulo` varchar(50) DEFAULT NULL,
  `descricao` longtext,
  `codigoTarefaPrioridade` int(10) unsigned NOT NULL,
  `datahoracriacao` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`codigoTarefa`),
  UNIQUE KEY `pmkTarefa` (`codigoTarefa`),
  KEY `FK_tarefa_codigoTarefaStatus` (`codigoTarefaStatus`),
  KEY `FK_tarefa_codigoTarefaPrioridade` (`codigoTarefaPrioridade`),
  CONSTRAINT `FK_tarefa_codigoTarefaPrioridade` FOREIGN KEY (`codigoTarefaPrioridade`) REFERENCES `tarefaprioridade` (`codigoTarefaPrioridade`),
  CONSTRAINT `FK_tarefa_codigoTarefaStatus` FOREIGN KEY (`codigoTarefaStatus`) REFERENCES `tarefastatus` (`codigoTarefaStatus`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarefa`
--

LOCK TABLES `tarefa` WRITE;
/*!40000 ALTER TABLE `tarefa` DISABLE KEYS */;
/*!40000 ALTER TABLE `tarefa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tarefastatus`
--

DROP TABLE IF EXISTS `tarefastatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tarefastatus` (
  `codigoTarefaStatus` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`codigoTarefaStatus`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Tabela para armazenar os status da Tarefa';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarefastatus`
--

LOCK TABLES `tarefastatus` WRITE;
/*!40000 ALTER TABLE `tarefastatus` DISABLE KEYS */;
INSERT INTO `tarefastatus` VALUES (1,'Não Iniciada'),(2,'Em Andamento'),(3,'Pendente'),(4,'Concluída'),(5,'Cancelada');
/*!40000 ALTER TABLE `tarefastatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contatoemails`
--

DROP TABLE IF EXISTS `contatoemails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contatoemails` (
  `codigoContato` int(10) DEFAULT NULL,
  `codigoEmail` int(10) DEFAULT NULL,
  UNIQUE KEY `pmkContatoEmails` (`codigoContato`,`codigoEmail`),
  KEY `FK_contatoemails_codigoEmail` (`codigoEmail`),
  CONSTRAINT `FK_contatoemails_codigoContato` FOREIGN KEY (`codigoContato`) REFERENCES `contato` (`codigoContato`),
  CONSTRAINT `FK_contatoemails_codigoEmail` FOREIGN KEY (`codigoEmail`) REFERENCES `email` (`codigoEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contatoemails`
--

LOCK TABLES `contatoemails` WRITE;
/*!40000 ALTER TABLE `contatoemails` DISABLE KEYS */;
/*!40000 ALTER TABLE `contatoemails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoendereco`
--

DROP TABLE IF EXISTS `tipoendereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipoendereco` (
  `codigoTipoEndereco` int(10) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`codigoTipoEndereco`),
  UNIQUE KEY `pmkCodigoTipoEndereco` (`codigoTipoEndereco`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoendereco`
--

LOCK TABLES `tipoendereco` WRITE;
/*!40000 ALTER TABLE `tipoendereco` DISABLE KEYS */;
INSERT INTO `tipoendereco` VALUES (1,'Residencial'),(2,'Comercial'),(3,'Recado');
/*!40000 ALTER TABLE `tipoendereco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tarefaprioridade`
--

DROP TABLE IF EXISTS `tarefaprioridade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tarefaprioridade` (
  `codigoTarefaPrioridade` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  PRIMARY KEY (`codigoTarefaPrioridade`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarefaprioridade`
--

LOCK TABLES `tarefaprioridade` WRITE;
/*!40000 ALTER TABLE `tarefaprioridade` DISABLE KEYS */;
INSERT INTO `tarefaprioridade` VALUES (1,'Normal'),(2,'Alta Prioridade'),(3,'Baixa Prioridade');
/*!40000 ALTER TABLE `tarefaprioridade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `endereco`
--

DROP TABLE IF EXISTS `endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `endereco` (
  `codigoEndereco` int(10) NOT NULL AUTO_INCREMENT,
  `codigoTipoEndereco` int(10) DEFAULT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`codigoEndereco`),
  UNIQUE KEY `pmkCodigoEndereco` (`codigoEndereco`),
  KEY `FK_endereco_codigoTipoEndereco` (`codigoTipoEndereco`),
  CONSTRAINT `FK_endereco_codigoTipoEndereco` FOREIGN KEY (`codigoTipoEndereco`) REFERENCES `tipoendereco` (`codigoTipoEndereco`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endereco`
--

LOCK TABLES `endereco` WRITE;
/*!40000 ALTER TABLE `endereco` DISABLE KEYS */;
/*!40000 ALTER TABLE `endereco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoemail`
--

DROP TABLE IF EXISTS `tipoemail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipoemail` (
  `codigoTipoEmail` int(10) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`codigoTipoEmail`),
  UNIQUE KEY `pmkCodigoTipoEmail` (`codigoTipoEmail`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoemail`
--

LOCK TABLES `tipoemail` WRITE;
/*!40000 ALTER TABLE `tipoemail` DISABLE KEYS */;
INSERT INTO `tipoemail` VALUES (1,'Pessoal'),(2,'Profissional'),(3,'MSN');
/*!40000 ALTER TABLE `tipoemail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email`
--

DROP TABLE IF EXISTS `email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email` (
  `codigoEmail` int(10) NOT NULL AUTO_INCREMENT,
  `codigoTipoEmail` int(10) DEFAULT NULL,
  `endereco` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`codigoEmail`),
  UNIQUE KEY `pmkCodigoEmail` (`codigoEmail`),
  UNIQUE KEY `idxEnderecoEmail` (`endereco`),
  KEY `FK_email_codigoTipoEmail` (`codigoTipoEmail`),
  CONSTRAINT `FK_email_codigoTipoEmail` FOREIGN KEY (`codigoTipoEmail`) REFERENCES `tipoemail` (`codigoTipoEmail`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email`
--

LOCK TABLES `email` WRITE;
/*!40000 ALTER TABLE `email` DISABLE KEYS */;
/*!40000 ALTER TABLE `email` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-05-21 21:05:01