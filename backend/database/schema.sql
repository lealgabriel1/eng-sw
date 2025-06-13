-- criação do banco/USE com ajuse de encoding
CREATE DATABASE IF NOT EXISTS candidatese
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE candidatese;

-- 1a TABLE: usuarios
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    endereco VARCHAR(255),
    competencias VARCHAR(255),
    foto_perfil VARCHAR(255) DEFAULT NULL
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2a TABLE: ongs
CREATE TABLE IF NOT EXISTS ongs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT NOT NULL,
    endereco VARCHAR(255),
    foto_perfil VARCHAR(255) DEFAULT NULL
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3a TABLE: oportunidades
CREATE TABLE IF NOT EXISTS oportunidades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(120) NOT NULL,
    descricao TEXT NOT NULL,
    data_pub DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_realizacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    lugar VARCHAR(255),
    msg_rapida VARCHAR(100) DEFAULT '',
    pre_reqs VARCHAR(255) DEFAULT 'Sem pré-requisitos necessários!',
    ong_id INT NOT NULL,
    FOREIGN KEY (ong_id) REFERENCES ongs(id) ON DELETE CASCADE
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4a TABLE: inscricoes
CREATE TABLE IF NOT EXISTS inscricoes (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    opp_id INT NOT NULL,
    data_inscricao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    mensagem TEXT,
    UNIQUE  (user_id, opp_id),
    FOREIGN KEY (user_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (opp_id) REFERENCES oportunidades(id) ON DELETE CASCADE
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Mock usuario
INSERT INTO usuarios (nome, email, cpf, endereco, competencias, foto_perfil) VALUES
    ('Aluno da Silva', 'aluno@teste.com', '11122233344', 'Rua do Aluno, 53', 'Inglês, Trabalho em Equipe', NULL);
    
-- Mock ONG
INSERT INTO ongs (nome, email, descricao, endereco, foto_perfil) VALUES
    ('ONG Alegria', 'aluno@teste.com', 'Venha ser alegre!', 'Rua da Alegria, 121', '/images/ong1.png'),
    ('Projeto Luz', 'luz@projetoluz.org', 'Levando luz às comunidades carentes.', 'Travessa das Lâmpadas, 54', '/images/ong2.png'),
    ('Amigos da Natureza', 'natureza@amigos.org', 'Cuidando do meio ambiente com ações locais.', 'Estrada Verde, 420', '/images/ong3.png'),
    ('Mãos Unidas', 'maosunidas@ajuda.org', 'Unindo esforços para transformar vidas.', 'Rua Solidariedade, 32', '/images/ong4.png'),
    ('ONG Ajude a ajudar', 'ajude@ajuda.org', 'Ajudando quem precisa de ajuda séria.', 'Rua da ajuda, 542', NULL);

-- Mock oportunidades:
INSERT INTO oportunidades (titulo, descricao, data_pub, data_realizacao, lugar, msg_rapida, pre_reqs, ong_id) VALUES
-- ONG 1: ONG Alegria (ID 1)
('Brincar e Aprender', 'Ajude a animar a tarde de crianças com jogos educativos e dinâmicas divertidas.', '2025-06-01 14:00:00', '2025-06-05 14:00:00', 'Creche Alegria, Rua da Alegria, 123', 'Venha brincar e ensinar!', 'Trabalho em Equipe', 1),
('Contação de Histórias', 'Traga fantasia e aprendizado para crianças através da leitura lúdica.', '2025-06-04 09:30:00', '2025-06-08 09:30:00', 'Biblioteca Comunitária da Alegria', 'Leia e divirta!', 'Leitura em voz alta, Comunicação', 1),
('Festa das Cores', 'Ajude a organizar uma tarde de pintura, música e recreação para os pequenos.', '2025-06-08 15:00:00', '2025-06-10 15:00:00', 'Praça da Alegria', 'Muita diversão!', 'Organização, Criatividade', 1),
('Aula de Reforço Lúdico', 'Ensine brincando! Reforço escolar com métodos lúdicos e interativos.', '2025-06-12 10:00:00', '2025-06-15 10:00:00', 'Escola Infantil Mundo Feliz', 'Ensine brincando!', 'Didática', 1),

-- ONG 2: Projeto Luz (ID 2)
('Oficina de Arte Urbana', 'Ensine grafite e expressão artística para adolescentes da periferia.', '2025-06-02 13:00:00', '2025-06-06 13:00:00', 'Centro Cultural Luz do Amanhã', 'Arte e inclusão!', 'Grafite, Comunicação', 2),
('Cine Comunidade', 'Ajude na exibição de filmes e rodas de conversa sobre temas sociais.', '2025-06-06 18:00:00', '2025-06-09 18:00:00', 'Quadra da Vila Nova Esperança', 'Cinema e debate!', 'Organização', 2),
('Mutirão da Luz', 'Distribua cestas básicas e kits de higiene para famílias da comunidade.', '2025-06-10 08:30:00', '2025-06-12 08:30:00', 'Rua Esperança, 45 – Galpão Solidário', 'Ajude quem precisa!', 'Empatia', 2),
('Aula de Música', 'Ensine violão básico para jovens carentes em busca de oportunidades.', '2025-06-14 16:00:00', '2025-06-17 16:00:00', 'Projeto Luz – Sede Musical, Travessa das Flores, 54', 'Música transforma!', 'Violão, Didática', 2),

-- ONG 3: Amigos da Natureza (ID 3)
('Plantio de Árvores Urbanas', 'Participe de ação ecológica para arborizar ruas e calçadas do bairro.', '2025-06-03 09:00:00', '2025-06-07 09:00:00', 'Estrada Verde, 500', 'Ajude a plantar o futuro!', 'Sustentabilidade', 3),
('Oficina de Compostagem', 'Ensine e aprenda técnicas simples de compostagem doméstica.', '2025-06-07 10:00:00', '2025-06-09 10:00:00', 'Associação Verde Esperança, Rua do Horto, 77', 'Composte junto!', 'Didática', 3),
('Trilha Ecológica Guiada', 'Ajude a guiar visita ambiental para crianças e jovens.', '2025-06-11 08:00:00', '2025-06-14 08:00:00', 'Reserva Municipal Serra do Sol', 'Trilhas e aprendizado!', 'Conhecimento ambiental', 3),
('Feira Sustentável', 'Ajude a montar e organizar feira com produtos ecológicos e reciclados.', '2025-06-15 12:00:00', '2025-06-18 12:00:00', 'Praça das Árvores, Estrada Verde', 'Ecologia na prática!', 'Organização', 3),

-- ONG 4: Mãos Unidas (ID 4)
('Distribuição de Alimentos', 'Ajude na organização e entrega de alimentos para famílias em situação de vulnerabilidade.', '2025-06-05 11:00:00', '2025-06-07 11:00:00', 'Centro Social Mãos Unidas, Rua Solidariedade, 32', 'Solidariedade faz bem!', 'Empatia', 4),
('Campanha do Agasalho', 'Participe da coleta e triagem de roupas de inverno para moradores de rua.', '2025-06-09 13:00:00', '2025-06-11 13:00:00', 'Galpão Solidário, Rua Esperança, 10', 'Aqueça vidas!', 'Organização', 4),
('Oficina de Empregabilidade', 'Ajude a montar currículos e simular entrevistas com jovens em busca do 1º emprego.', '2025-06-13 15:30:00', '2025-06-15 15:30:00', 'Espaço Profissionalizante Mãos Unidas', 'Ajude no 1º emprego!', 'RH, Comunicação', 4),
('Atendimento em Abrigo', 'Ofereça apoio humano e recreativo a moradores em abrigo temporário.', '2025-06-17 17:00:00', '2025-06-19 17:00:00', 'Casa de Acolhimento São Lucas', 'Ofereça companhia e escuta!', 'Empatia', 4),

-- ONG 5: Ajude a Ajudar (ID 5)
('Doação de Alimentos', 'Ajude a montar e distribuir cestas básicas para famílias em situação de vulnerabilidade.', '2025-06-04 10:00:00', '2025-06-07 10:00:00', 'Sede Ajude a Ajudar, Rua da ajuda, 542', 'Doe seu tempo e solidariedade!', 'Organização, Empatia', 5),
('Apoio Psicossocial', 'Ofereça escuta e apoio emocional para pessoas em situação de crise.', '2025-06-09 15:00:00', '2025-06-12 15:00:00', 'Centro Comunitário Ajude a Ajudar', 'Ouça e acolha!', 'Psicologia, Comunicação', 5),
('Reforço Escolar Voluntário', 'Contribua dando aulas de reforço escolar para crianças e adolescentes atendidos pela ONG.', '2025-06-13 14:00:00', '2025-06-16 14:00:00', 'Espaço Educacional Ajude a Ajudar', 'Ensine e transforme vidas!', 'Didática, Paciência', 5),
('Oficina de Artesanato', 'Ajude a ensinar técnicas simples de artesanato para geração de renda das famílias atendidas.', '2025-06-17 09:00:00', '2025-06-20 09:00:00', 'Sala Multiuso Ajude a Ajudar', 'Compartilhe habilidades!', 'Artesanato, Didática', 5);

-- FIM