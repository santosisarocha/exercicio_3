CREATE DATABASE e_mail;
USE e_mail;

CREATE TABLE usuario (
id_usuario INT NOT NULL AUTO_INCREMENT ,
nome VARCHAR(50) NOT NULL,
e_mail varchar(50) not null,
senha varchar (50) not null,
PRIMARY KEY (id_usuario)
);

CREATE TABLE e_mails (
 id_email INT NOT NULL AUTO_INCREMENT ,
 assunto VARCHAR(50) NOT NULL,
 corpo VARCHAR(50) NOT NULL,
 data_envio DATETIME not null DEFAULT NOW(),
 status ENUM('rascunho', 'enviando', 'enviado') NOT NULL DEFAULT 'rascunho',	
 PRIMARY KEY (id_email)
 );
 
 CREATE TABLE destinatarios (
id_destinatario INT NOT NULL AUTO_INCREMENT ,
id_email INT NOT NULL,
id_usuario INT NOT NULL,
PRIMARY KEY (id_destinatario),
FOREIGN KEY (id_email) REFERENCES e_mails (id_email),
FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
);

CREATE TABLE anexos (
id_anexo INT NOT NULL AUTO_INCREMENT ,
id_email INT NOT NULL,
nome_arquivo VARCHAR(50) NOT NULL,
tamanho_arquivo INT NOT NULL,
link VARCHAR(255) NOT NULL,
PRIMARY KEY (id_anexo),
FOREIGN KEY (id_email) REFERENCES e_mails (id_email)
);

INSERT INTO usuario (nome, e_mail, senha) VALUES
('João', 'joao@email.com', '123456'),
('Maria', 'maria@email.com', '654321'),
('Pedro', 'pedro@email.com', 'senha123');

INSERT INTO e_mails (assunto, corpo, status) VALUES
('Assunto do e-mail 1', 'Corpo do e-mail 1', 'enviado'),
('Assunto do e-mail 2', 'Corpo do e-mail 2', 'rascunho'),
('Assunto do e-mail 3', 'Corpo do e-mail 3', 'enviando');

INSERT INTO destinatarios (id_email, id_usuario) VALUES
(1, 2),
(1, 3),
(2, 1),
(3, 2),
(3, 3);

INSERT INTO anexos (id_email, nome_arquivo, tamanho_arquivo, link) VALUES
(1, 'arquivo1.pdf', 1024, 'http://localhost/arquivos/arquivo1.pdf'),
(1, 'arquivo2.doc', 2048, 'http://localhost/arquivos/arquivo2.doc'),
(3, 'arquivo3.jpg', 512, 'http://localhost/arquivos/arquivo3.jpg');

SELECT * FROM e_mails
WHERE status != 'enviado' AND DATE(data_envio) = DATE(NOW() - INTERVAL 1 DAY);

SELECT * FROM usuario
LEFT JOIN destinatarios ON usuario.id_usuario = destinatarios.id_usuario
LEFT JOIN e_mails ON destinatarios.id_email = e_mails.id_email
LEFT JOIN anexos ON e_mails.id_email = anexos.id_email