AgendaRS
=============

Projeto feito nos tempos da faculdade sendo o primeiro em que fiz uma modelagem
de dados propriamente dita, preocupando com algum nível de normalização. O 
projeto inicialmente feito em Visual Basic 6 com Base de dados MS Access, na
primeira versão a 0.00.000 e então portado para outras plataformas como:
* VB6 - Projeto Inicial
* PHP - PHP Generator da SQL Maestro
* Java - Com Swing

VB6 
-------
Sobre o Projeto em Visual Basic 6

[Ver documentação](Doc/)

PHP
-------
Inicialmente migrado para o PHP e SQL utilizando a o PHP Generator da SQL Maestro.

[Ver documentação](Doc/)

Java Swing
-------
Uma versão com Java Swing

[Ver documentação](Doc/)

Banco de Dados
-------

O versão do VB6 foi feita utilizando o MS Access, com a ferramenta VISDATA que vem junto do VB6, a primeira modelagem foi bem complicada, com a maioria das entidades N para N, por isso tem bastante tabela de ligação. A primeira entidade modelada assim foi a de ```contato```, acabei simplificando bastante na próxima a ```tarefa```, veja no diagrama abaixo a diferença:

> Tabela: ```contato```

![database busca tabelas](contato.png)

> Tabela: ```tarefa```

![database busca tabelas](tarefas.png)

[Ver documentação](Doc/)

A fazer
-------
1. ~Melhorar documentação~
2. Separar os projetos em repositórios diferentes
    - [AgendaRS - Blazor](https://github.com/relson/agendars-blazor)
3. Refatorar Projeto VB6
4. Arquivar projeto VB6
