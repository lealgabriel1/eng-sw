-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: localhost    Database: candidatese
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `inscricoes`
--

DROP TABLE IF EXISTS `inscricoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inscricoes` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `opp_id` int NOT NULL,
  `data_inscricao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `mensagem` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `user_id` (`user_id`,`opp_id`),
  KEY `opp_id` (`opp_id`),
  CONSTRAINT `inscricoes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `inscricoes_ibfk_2` FOREIGN KEY (`opp_id`) REFERENCES `oportunidades` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inscricoes`
--

LOCK TABLES `inscricoes` WRITE;
/*!40000 ALTER TABLE `inscricoes` DISABLE KEYS */;
INSERT INTO `inscricoes` VALUES (1,1,16,'2025-06-11 20:29:09','teste'),(2,1,12,'2025-06-11 20:31:07','oi'),(3,1,4,'2025-06-11 21:07:52','Adoro crianças e sou didático sim! ');
/*!40000 ALTER TABLE `inscricoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ongs`
--

DROP TABLE IF EXISTS `ongs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ongs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `endereco` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ongs`
--

LOCK TABLES `ongs` WRITE;
/*!40000 ALTER TABLE `ongs` DISABLE KEYS */;
INSERT INTO `ongs` VALUES (1,'ONG Alegria','aluno@teste.com','Venha ser alegre!','Rua da Alegria, 121'),(2,'Projeto Luz','luz@projetoluz.org','Levando luz às comunidades carentes.','Travessa das Lâmpadas, 54'),(3,'Amigos da Natureza','natureza@amigos.org','Cuidando do meio ambiente com ações locais.','Estrada Verde, 420'),(4,'Mãos Unidas','maosunidas@ajuda.org','Unindo esforços para transformar vidas.','Rua Solidariedade, 32');
/*!40000 ALTER TABLE `ongs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oportunidades`
--

DROP TABLE IF EXISTS `oportunidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oportunidades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descricao` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_pub` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_realizacao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lugar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `msg_rapida` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `pre_reqs` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'Sem pré-requisitos necessários!',
  `ong_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ong_id` (`ong_id`),
  CONSTRAINT `oportunidades_ibfk_1` FOREIGN KEY (`ong_id`) REFERENCES `ongs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oportunidades`
--

LOCK TABLES `oportunidades` WRITE;
/*!40000 ALTER TABLE `oportunidades` DISABLE KEYS */;
INSERT INTO `oportunidades` VALUES (1,'Brincar e Aprender','Ajude a animar a tarde de crianças com jogos educativos e dinâmicas divertidas.','2025-06-01 14:00:00','2025-06-05 14:00:00','Creche Alegria, Rua da Alegria, 123','Venha brincar e ensinar!','Trabalho em Equipe',1),(2,'Contação de Histórias','Traga fantasia e aprendizado para crianças através da leitura lúdica.','2025-06-04 09:30:00','2025-06-08 09:30:00','Biblioteca Comunitária da Alegria','Leia e divirta!','Leitura em voz alta, Comunicação',1),(3,'Festa das Cores','Ajude a organizar uma tarde de pintura, música e recreação para os pequenos.','2025-06-08 15:00:00','2025-06-10 15:00:00','Praça da Alegria','Muita diversão!','Organização, Criatividade',1),(4,'Aula de Reforço Lúdico','Ensine brincando! Reforço escolar com métodos lúdicos e interativos.','2025-06-12 10:00:00','2025-06-15 10:00:00','Escola Infantil Mundo Feliz','Ensine brincando!','Didática',1),(5,'Oficina de Arte Urbana','Ensine grafite e expressão artística para adolescentes da periferia.','2025-06-02 13:00:00','2025-06-06 13:00:00','Centro Cultural Luz do Amanhã','Arte e inclusão!','Grafite, Comunicação',2),(6,'Cine Comunidade','Ajude na exibição de filmes e rodas de conversa sobre temas sociais.','2025-06-06 18:00:00','2025-06-09 18:00:00','Quadra da Vila Nova Esperança','Cinema e debate!','Organização',2),(7,'Mutirão da Luz','Distribua cestas básicas e kits de higiene para famílias da comunidade.','2025-06-10 08:30:00','2025-06-12 08:30:00','Rua Esperança, 45 – Galpão Solidário','Ajude quem precisa!','Empatia',2),(8,'Aula de Música','Ensine violão básico para jovens carentes em busca de oportunidades.','2025-06-14 16:00:00','2025-06-17 16:00:00','Projeto Luz – Sede Musical, Travessa das Flores, 54','Música transforma!','Violão, Didática',2),(9,'Plantio de Árvores Urbanas','Participe de ação ecológica para arborizar ruas e calçadas do bairro.','2025-06-03 09:00:00','2025-06-07 09:00:00','Estrada Verde, 500','Ajude a plantar o futuro!','Sustentabilidade',3),(10,'Oficina de Compostagem','Ensine e aprenda técnicas simples de compostagem doméstica.','2025-06-07 10:00:00','2025-06-09 10:00:00','Associação Verde Esperança, Rua do Horto, 77','Composte junto!','Didática',3),(11,'Trilha Ecológica Guiada','Ajude a guiar visita ambiental para crianças e jovens.','2025-06-11 08:00:00','2025-06-14 08:00:00','Reserva Municipal Serra do Sol','Trilhas e aprendizado!','Conhecimento ambiental',3),(12,'Feira Sustentável','Ajude a montar e organizar feira com produtos ecológicos e reciclados.','2025-06-15 12:00:00','2025-06-18 12:00:00','Praça das Árvores, Estrada Verde','Ecologia na prática!','Organização',3),(13,'Distribuição de Alimentos','Ajude na organização e entrega de alimentos para famílias em situação de vulnerabilidade.','2025-06-05 11:00:00','2025-06-07 11:00:00','Centro Social Mãos Unidas, Rua Solidariedade, 32','Solidariedade faz bem!','Empatia',4),(14,'Campanha do Agasalho','Participe da coleta e triagem de roupas de inverno para moradores de rua.','2025-06-09 13:00:00','2025-06-11 13:00:00','Galpão Solidário, Rua Esperança, 10','Aqueça vidas!','Organização',4),(15,'Oficina de Empregabilidade','Ajude a montar currículos e simular entrevistas com jovens em busca do 1º emprego.','2025-06-13 15:30:00','2025-06-15 15:30:00','Espaço Profissionalizante Mãos Unidas','Ajude no 1º emprego!','RH, Comunicação',4),(16,'Atendimento em Abrigo','Ofereça apoio humano e recreativo a moradores em abrigo temporário.','2025-06-17 17:00:00','2025-06-19 17:00:00','Casa de Acolhimento São Lucas','Ofereça companhia e escuta!','Empatia',4);
/*!40000 ALTER TABLE `oportunidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL,
  `endereco` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `competencias` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Aluno da Silva','aluno@teste.com','11122233344','Rua do Aluno, 53','Inglês, Trabalho em Equipe');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-11 22:15:35
