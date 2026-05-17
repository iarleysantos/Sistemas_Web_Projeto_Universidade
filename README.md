# Sistema Universitário - Gerenciamento de Professores e Turmas 🎓

Este é um sistema web desenvolvido como projeto acadêmico para o gerenciamento de professores, disciplinas, aptidões e turmas de uma universidade. A aplicação foi construída utilizando a arquitetura MVC (Model-View-Controller) tradicional para a web em Java.

---

## 🛠️ Tecnologias Utilizadas

* **Linguagem:** Java
* **Tecnologias Web:** Java Servlets & JSP (JavaServer Pages)
* **Servidor de Aplicação:** Apache Tomcat v10.1
* **Banco de Dados:** MySQL 8.0
* **Ambiente de Desenvolvimento:** Eclipse IDE

---

## 🚀 Funcionalidades Implementadas (Especificações do Projeto)

O sistema atende completamente aos requisitos solicitados no escopo do projeto:

* **a) Gerenciamento de Professores (CRUD Completo):** Tela para incluir, alterar, excluir e consultar professores cadastrados no banco de dados.
* **b) Gerenciamento de Disciplinas (CRUD Completo):** Tela para inclusão, alteração, exclusão e consulta de disciplinas (com controle de carga horária).
* **c) Vínculo de Aptidão:** Registro e associação de quais disciplinas podem ser ministradas por cada professor.
* **d) Cadastro de Turmas:** Registro das turmas contendo o identificador, a disciplina correspondente, o professor responsável, o semestre letivo, a quantidade de alunos matriculados e o turno/horário (Manhã, Tarde ou Noite).
* **e) Consulta de Professores Aptos:** Filtro inteligente por disciplina que lista todos os professores habilitados a ministrá-la.
* **f) Relatório de Histórico Docente:** Consulta por professor que exibe o histórico de disciplinas já ministradas, calculando o total acumulado de carga horária e a quantidade total de alunos atendidos.

---

## 🗄️ Estrutura do Banco de Dados

A persistência de dados utiliza tabelas normalizadas com chaves primárias e estrangeiras para garantir a integridade referencial (por exemplo, impedindo a exclusão de professores vinculados a turmas ativas).

As principais tabelas do banco são:
1. `professores`
2. `disciplinas`
3. `professor_apto`
4. `turmas`

---

## 💻 Como Executar o Projeto

1. Clone este repositório ou baixe o código fonte.
2. Certifique-se de ter o **Apache Tomcat v10.1** configurado no seu Eclipse.
3. Importe o projeto no Eclipse como um *Existing Project into Workspace*.
4. Execute o script SQL (incluso no relatório) no seu ambiente MySQL para criar o banco de dados e as tabelas.
5. Ajuste as credenciais de acesso ao banco na classe `FabricaConexao.java` (se necessário).
6. Clique com o botão direito no projeto -> *Run As* -> *Run on Server*.
7. Acesse a aplicação no navegador através de: `http://localhost:8080/universidade_web/index.jsp`
