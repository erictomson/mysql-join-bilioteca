# Criar o database “biblioteca”
CREATE SCHEMA biblioteca;

# Visualizar os databases existentes e definir como padrão o database "biblioteca"
SHOW DATABASES;
USE biblioteca;

# Definir o mecanismo padrão como InnoDB (transacional)
SET STORAGE_ENGINE=InnoDB;

# Definir conjunto de caracteres
ALTER DATABASE biblioteca CHARACTER SET = utf8mb4;

# Criar a tabela "categoria", conforme especificado no diagrama
CREATE TABLE categoria (
id_categoria INTEGER NOT NULL,
categoria VARCHAR(100) NOT NULL,
PRIMARY KEY (id_categoria)
);

# Visualizar a estrutura da tabela "categoria"
DESCRIBE categoria;

# Criar a tabela "livro", conforme especificado no diagrama
CREATE TABLE livro (
id_livro INTEGER NOT NULL,
titulo VARCHAR(200) NOT NULL,
id_categoria INTEGER NOT NULL,
PRIMARY KEY (id_livro),
CONSTRAINT categoria_livro_fk
FOREIGN KEY (id_categoria)
REFERENCES categoria (id_categoria)
ON DELETE NO ACTION
ON UPDATE NO ACTION
);

# Visualizar a estrutura da tabela "livro"
DESCRIBE livro;

# Criar a tabela "aluno", conforme especificado no diagrama
CREATE TABLE aluno (
id_aluno INTEGER NOT NULL,
nome VARCHAR(100) NOT NULL,
PRIMARY KEY (id_aluno)
);

# Visualizar a estrutura da tabela "aluno"
DESCRIBE aluno;

# Criar a tabela "emprestimo", conforme especificado no diagrama
CREATE TABLE emprestimo (
id_emprestimo INTEGER AUTO_INCREMENT NOT NULL,
id_aluno INTEGER NOT NULL,
id_livro INTEGER NOT NULL,
data_emprestimo DATE NOT NULL,
data_devolucao DATE,
PRIMARY KEY (id_emprestimo),
CONSTRAINT emprestimo_uk
UNIQUE KEY( id_aluno, id_livro, data_emprestimo ),
CONSTRAINT livro_emprestimo_fk
FOREIGN KEY (id_livro)
REFERENCES livro (id_livro),
CONSTRAINT aluno_emprestimo_fk
FOREIGN KEY (id_aluno)
REFERENCES aluno (id_aluno)
);

# Visualizar a estrutura da tabela "emprestimo"
DESCRIBE emprestimo;

# Popular tabela aluno
INSERT INTO aluno VALUES (100, 'Zacarias da Mata');
INSERT INTO aluno VALUES (200, 'Yolanda Costa Matheus');
INSERT INTO aluno VALUES (300, 'Xisto Gonçalves');
INSERT INTO aluno VALUES (400, 'William Henry Gates');
INSERT INTO aluno VALUES (500, 'Vilma Oliveira Dias');
INSERT INTO aluno VALUES (600, 'Úrsula Pereira');
INSERT INTO aluno VALUES (700, 'Teodoro Silva dos Santos');
INSERT INTO aluno VALUES (800, 'Salomé Souza Lima');
INSERT INTO aluno VALUES (900, 'Ranulfo Jorge da Silva');

# Popular tabela categoria
INSERT INTO categoria VALUES (10, 'Romance');
INSERT INTO categoria VALUES (20, 'Ficção');
INSERT INTO categoria VALUES (30, 'Comédia');
INSERT INTO categoria VALUES (40, 'Infanto Juvenil');
INSERT INTO categoria VALUES (50, 'Drama');
INSERT INTO categoria VALUES (60, 'Policial');

# Popular tabela livro
INSERT INTO livro VALUES (1000, 'Um romance qualquer', 10);
INSERT INTO livro VALUES (1010, 'Um outro romance qualquer', 10);
INSERT INTO livro VALUES (1020, 'Uma ficção baseada em fatos reais', 20);
INSERT INTO livro VALUES (1030, 'Eram os deuses astronautas?', 20);
INSERT INTO livro VALUES (1040, 'Cachinhos Dourados', 40);
INSERT INTO livro VALUES (1050, 'Chapeuzinho Vermelho', 40);
INSERT INTO livro VALUES (1060, 'Os três porquinhos', 40);
INSERT INTO livro VALUES (1070, 'Se eu chorasse uma vez', 50);
INSERT INTO livro VALUES (1080, 'Um novo amor', 10);
INSERT INTO livro VALUES (1090, 'A dúvida', 50);
INSERT INTO livro VALUES (1100, 'A morte do senhor vereador', 60);
INSERT INTO livro VALUES (1110, 'O mistério dos 5 mentirosos', 60);
INSERT INTO livro VALUES (1120, 'O robô', 20);
INSERT INTO livro VALUES (1130, 'Poeiras em alto mar', 50);
INSERT INTO livro VALUES (1140, 'A volta dos que não foram', 50);
INSERT INTO livro VALUES (1150, 'O príncipe e o mendigo', 40);

# Popular tabela emprestimo
INSERT INTO emprestimo (id_aluno, id_livro, data_emprestimo)
VALUES (100, 1000, '2010-08-13');
INSERT INTO emprestimo (id_aluno, id_livro, data_emprestimo)
VALUES (100, 1080, '2010-08-14');
INSERT INTO emprestimo (id_aluno, id_livro, data_emprestimo)
VALUES (200, 1110, '2010-08-15');
INSERT INTO emprestimo (id_aluno, id_livro, data_emprestimo)
VALUES (300, 1150, '2010-08-15');
INSERT INTO emprestimo (id_aluno, id_livro, data_emprestimo)
VALUES (500, 1120, '2010-08-16');
INSERT INTO emprestimo (id_aluno, id_livro, data_emprestimo)
VALUES (500, 1130, '2010-08-16');
INSERT INTO emprestimo (id_aluno, id_livro, data_emprestimo)
VALUES (600, 1010, '2010-08-16');
INSERT INTO emprestimo (id_aluno, id_livro, data_emprestimo)
VALUES (700, 1020, '2010-08-16');
INSERT INTO emprestimo (id_aluno, id_livro, data_emprestimo)
VALUES (800, 1040, '2010-08-15');

# Mostrando todos os livros que possuem categoria
# -- Cláusula ON
SELECT
l.id_livro,
l.titulo,
c.id_categoria,
c.categoria
FROM livro l
INNER JOIN categoria c
ON l.id_categoria = c.id_categoria;

# Mostrando todos os livros que possuem categoria
# -- Cláusula USING. A cláusula USING pode ser usada quando a chave primária é
# -- igual a chave estrangeira
SELECT
l.id_livro,
l.titulo,
c.id_categoria,
c.categoria
FROM livro l
INNER JOIN categoria c
USING (id_categoria);

# Mostrando os livros que possuem e que não possuem categoria
SELECT
l.id_livro,
l.titulo,
c.id_categoria,
c.categoria
FROM livro l
LEFT OUTER JOIN categoria c
USING (id_categoria);

# Mostrando todas as categorias que possuem e que não possuem livros
SELECT
l.id_livro,
l.titulo,
c.id_categoria,
c.categoria
FROM livro l
RIGHT OUTER JOIN categoria c
USING (id_categoria);

# Mostrando todos os alunos que fizeram empréstimos
SELECT
a.id_aluno,
a.nome,
e.data_emprestimo,
e.data_devolucao
FROM aluno a
INNER JOIN emprestimo e
ON a.id_aluno = e.id_aluno;

# Mostrando todos os alunos que fizeram e que não fizeram empréstimos
SELECT
a.id_aluno,
a.nome,
e.data_emprestimo,
e.data_devolucao
FROM aluno a
LEFT OUTER JOIN emprestimo e
ON a.id_aluno = e.id_aluno;

# Mostrando todos os empréstimos que possuem e que não possuem alunos
SELECT
a.id_aluno,
a.nome,
e.data_emprestimo,
e.data_devolucao
FROM aluno a
RIGHT OUTER JOIN emprestimo e
ON a.id_aluno = e.id_aluno;

# Mostrando todos os livros que os alunos pegaram emprestados
SELECT
a.id_aluno,
a.nome,
l.id_livro,
l.titulo,
e.data_emprestimo,
e.data_devolucao
FROM aluno a
INNER JOIN emprestimo e
ON a.id_aluno = e.id_aluno
INNER JOIN livro l
ON e.id_livro = l.id_livro;

# Mostrando todos os livros que os alunos pegaram emprestados.
# -- Mostrar também as categorias de cada livro.
SELECT
a.id_aluno,
a.nome,
l.id_livro,
l.titulo,
c.id_categoria,
c.categoria,
e.data_emprestimo,
e.data_devolucao
FROM aluno a
INNER JOIN emprestimo e
ON a.id_aluno = e.id_aluno
INNER JOIN livro l
ON e.id_livro = l.id_livro
INNER JOIN categoria c
ON l.id_categoria = c.id_categoria;

# Mostrando todos os livros que os alunos pegaram emprestados.
# -- Mostrar também as categorias de cada livro.
# -- Se o aluno não pegou um livro, mostrar também.
SELECT
a.id_aluno,
a.nome,
l.id_livro,
l.titulo,
c.id_categoria,
c.categoria,
e.data_emprestimo,
e.data_devolucao
FROM aluno a
LEFT JOIN emprestimo e
ON a.id_aluno = e.id_aluno
LEFT JOIN livro l
ON e.id_livro = l.id_livro
LEFT JOIN categoria c
ON l.id_categoria = c.id_categoria;