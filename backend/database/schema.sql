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
    ('Projeto Luz', 'luz@projetoluz.org', 'Levando luz às comunidades carentes.', 'Travessa das Lâmpadas, 54a', '/images/ong2.png'),
    ('Amigos da Natureza', 'natureza@amigos.org', 'Cuidando do meio ambiente com ações locais.', 'Estrada Verde, 420', '/images/ong3.png'),
    ('Mãos Unidas', 'maosunidas@ajuda.org', 'Unindo esforços para transformar vidas.', 'Rua Solidariedade, 32', '/images/ong4.png'),
    ('ONG Ajude a ajudar', 'ajude@ajuda.org', 'Ajudando quem precisa de ajuda séria.', 'Rua da Ajuda, 542', NULL);

-- Mock oportunidades:
INSERT INTO oportunidades (titulo, descricao, data_pub, data_realizacao, lugar, msg_rapida, pre_reqs, ong_id) VALUES

-- ONG 1: ONG Alegria (ID 1)
('Brincar e Aprender', 
'Anime a tarde de crianças por meio de jogos educativos, atividades lúdicas, contação de histórias e interação em pequenos grupos. É uma experiência gratificante e cheia de energia positiva para quem gosta de crianças!', 
'2025-06-18 14:00:00', '2025-06-22 14:00:00', 'Creche Alegria, Rua da Alegria, 123', 
'Venha brincar e ensinar!', 
'Trabalho em Equipe', 1),

('Contação de Histórias', 
'Use sua criatividade para envolver crianças em aventuras imaginárias e transmitir valores importantes através de histórias lidas em voz alta, usando recursos visuais e muita empatia. Material de apoio fornecido.', 
'2025-06-20 09:30:00', '2025-06-25 09:30:00', 'Biblioteca Comunitária da Alegria', 
'Leia e divirta!', 
'Leitura em voz alta, Comunicação', 1),

('Festa das Cores', 
'Colabore na montagem de uma tarde festiva repleta de oficinas de pintura, músicas e recreação na praça, com desafios criativos e atividades de integração para todos os perfis.', 
'2025-06-24 15:00:00', '2025-06-29 15:00:00', 'Praça da Alegria', 
'Muita diversão!', 
'Organização, Criatividade', 1),

('Aula de Reforço Lúdico', 
'Ofereça reforço escolar de português e matemática para crianças do fundamental, com jogos, brincadeiras, desafios e acompanhamento individualizado. Experiência em ensino é diferencial.', 
'2025-07-01 10:00:00', '2025-07-05 10:00:00', 'Escola Infantil Mundo Feliz', 
'Ensine brincando!', 
'Didática', 1),

('Circuito de Brincadeiras', 
'Participe de um circuito com brincadeiras populares, dinâmicas de grupo e atividades ao ar livre para crianças em situação de vulnerabilidade.', 
'2025-07-10 13:00:00', '2025-07-15 13:00:00', 'Sede da ONG Alegria', 
'Diversão garantida!', 
'Animação, Paciência', 1),

-- ONG 2: Projeto Luz (ID 2)
('Oficina de Arte Urbana', 
'Apoie adolescentes em situação de risco social a expressarem sua criatividade através do grafite e outras técnicas de arte urbana. Não precisa ser expert, só ter vontade de ensinar e aprender!', 
'2025-06-19 13:00:00', '2025-06-24 13:00:00', 'Centro Cultural Luz do Amanhã', 
'Arte e inclusão!', 
'Grafite, Comunicação', 2),

('Cine Comunidade', 
'Auxilie na exibição de filmes de temática social seguidos de rodas de conversa, proporcionando reflexão, integração comunitária e oportunidade de novas perspectivas. Atividade noturna e descontraída.', 
'2025-06-22 18:00:00', '2025-06-28 18:00:00', 'Quadra da Vila Nova Esperança', 
'Cinema e debate!', 
'Organização', 2),

('Mutirão da Luz', 
'Ajude na separação e entrega de cestas básicas, kits de higiene e itens essenciais a famílias carentes, interagindo com pessoas de diferentes realidades e promovendo solidariedade.', 
'2025-06-25 08:30:00', '2025-07-01 08:30:00', 'Rua Esperança, 45 – Galpão Solidário', 
'Ajude quem precisa!', 
'Empatia', 2),

('Aula de Música', 
'Dê aulas básicas de violão para jovens com poucas oportunidades, em ambiente coletivo e acolhedor, focando em iniciação musical e formação de pequenos grupos.', 
'2025-07-03 16:00:00', '2025-07-08 16:00:00', 'Projeto Luz – Sede Musical', 
'Música transforma!', 
'Violão, Didática', 2),

('Sarau Poético', 
'Organize e participe de um sarau com declamação de poesias e músicas autorais, promovendo expressão artística e valorização da cultura local.', 
'2025-07-12 19:00:00', '2025-07-18 19:00:00', 'Sede da ONG Projeto Luz', 
'Libere sua criatividade!', 
'Leitura, Expressão Oral', 2),

-- ONG 3: Amigos da Natureza (ID 3)
('Plantio de Árvores Urbanas', 
'Ajude a transformar áreas urbanas em locais mais verdes, plantando mudas de árvores, orientando moradores e conscientizando sobre a importância do reflorestamento urbano.', 
'2025-06-21 09:00:00', '2025-06-27 09:00:00', 'Estrada Verde, 500', 
'Ajude a plantar o futuro!', 
'Sustentabilidade', 3),

('Oficina de Compostagem', 
'Conduza oficina para ensinar moradores a transformar resíduos orgânicos em adubo, com demonstrações práticas e explicação do ciclo da compostagem.', 
'2025-06-24 10:00:00', '2025-06-30 10:00:00', 'Associação Verde Esperança, Rua do Horto, 77', 
'Composte junto!', 
'Didática', 3),

('Trilha Ecológica Guiada', 
'Acompanhe crianças e adolescentes em trilha ecológica por reserva ambiental, explicando sobre fauna, flora e importância da preservação, com atividades lúdicas no percurso.', 
'2025-06-29 08:00:00', '2025-07-03 08:00:00', 'Reserva Municipal Serra do Sol', 
'Trilhas e aprendizado!', 
'Conhecimento ambiental', 3),

('Feira Sustentável', 
'Colabore na organização de feira de produtos ecológicos, oficinas de reciclagem e palestras sobre consumo consciente. Atividade diversificada, excelente para quem gosta de sustentabilidade.', 
'2025-07-06 12:00:00', '2025-07-12 12:00:00', 'Praça das Árvores, Estrada Verde', 
'Ecologia na prática!', 
'Organização', 3),

('Limpeza de Praias', 
'Ajude em mutirão de limpeza em praia urbana, coleta de resíduos, triagem de recicláveis e conscientização dos banhistas.', 
'2025-07-15 08:00:00', '2025-07-19 08:00:00', 'Praia Verde, Avenida Costeira, 1000', 
'Vamos cuidar do planeta!', 
'Força de vontade, Trabalho em equipe', 3),

-- ONG 4: Mãos Unidas (ID 4)
('Distribuição de Alimentos', 
'Auxilie na separação e distribuição de alimentos e itens de higiene para famílias em situação de vulnerabilidade, desde a triagem até o contato humano na entrega.', 
'2025-06-20 11:00:00', '2025-06-26 11:00:00', 'Centro Social Mãos Unidas', 
'Solidariedade faz bem!', 
'Empatia', 4),

('Campanha do Agasalho', 
'Participe do recebimento, triagem, organização e entrega de roupas e cobertores, colaborando para aquecer famílias durante o inverno.', 
'2025-06-27 13:00:00', '2025-07-02 13:00:00', 'Galpão Solidário, Rua Esperança, 10', 
'Aqueça vidas!', 
'Organização', 4),

('Oficina de Empregabilidade', 
'Ajude jovens no preparo para o mercado de trabalho, auxiliando na elaboração de currículos, simulação de entrevistas e orientação profissional.', 
'2025-07-03 15:30:00', '2025-07-09 15:30:00', 'Espaço Profissionalizante Mãos Unidas', 
'Ajude no 1º emprego!', 
'RH, Comunicação', 4),

('Atendimento em Abrigo', 
'Ofereça apoio emocional, atividades recreativas e escuta ativa para moradores temporários de abrigo, promovendo ambiente acolhedor e solidário.', 
'2025-07-08 17:00:00', '2025-07-12 17:00:00', 'Casa de Acolhimento São Lucas', 
'Ofereça companhia e escuta!', 
'Empatia', 4),

('Piquenique Solidário', 
'Colabore na organização de piquenique comunitário com brincadeiras para crianças, distribuição de lanches e integração entre voluntários e assistidos.', 
'2025-07-15 10:00:00', '2025-07-20 10:00:00', 'Sede da ONG Mãos Unidas', 
'Traga alegria e união!', 
'Animação, Organização', 4),

-- ONG 5: Ajude a Ajudar (ID 5)
('Doação de Alimentos', 
'Colabore na montagem e entrega de cestas básicas, organizando filas, controlando estoque e interagindo com famílias assistidas.', 
'2025-06-22 10:00:00', '2025-06-27 10:00:00', 'Sede da ONG Ajude a Ajudar', 
'Doe seu tempo e solidariedade!', 
'Organização, Empatia', 5),

('Apoio Psicossocial', 
'Ofereça escuta, orientação e encaminhamento para pessoas em crise, trabalhando junto à equipe técnica de psicologia e serviço social.', 
'2025-06-28 15:00:00', '2025-07-03 15:00:00', 'Centro Comunitário Ajude a Ajudar', 
'Ouça e acolha!', 
'Psicologia, Comunicação', 5),

('Reforço Escolar Voluntário', 
'Auxilie no reforço escolar para crianças e adolescentes, preparando aulas, materiais e acompanhando o progresso individualmente.', 
'2025-07-04 14:00:00', '2025-07-10 14:00:00', 'Espaço Educacional Ajude a Ajudar', 
'Ensine e transforme vidas!', 
'Didática, Paciência', 5),

('Oficina de Artesanato', 
'Ajude a ensinar técnicas de artesanato para geração de renda de famílias, trabalhando com materiais recicláveis, crochê e bijuterias.', 
'2025-07-12 09:00:00', '2025-07-18 09:00:00', 'Sala Multiuso Ajude a Ajudar', 
'Compartilhe habilidades!', 
'Artesanato, Didática', 5),

('Campanha de Arrecadação Escolar', 
'Auxilie na arrecadação e distribuição de materiais escolares para estudantes carentes antes do início do semestre letivo.', 
'2025-07-20 09:00:00', '2025-07-25 09:00:00', 'Sede da ONG Ajude a Ajudar', 
'Apoie a educação!', 
'Organização, Comunicação', 5);

-- FIM