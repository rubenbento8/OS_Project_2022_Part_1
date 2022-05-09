#!/bin/bash

###############################################################################
## ISCTE-IUL: Trabalho prático de Sistemas Operativos 2021/2022
##
## Aluno Nº: 88047      
## Nome: Rúben Bento
## Nome do Módulo: lista_condutores.sh
## Descrição/Explicação do Módulo: 
##
## Primeiramente verifica se o ficheiro pessoas existe, caso não exista dá error 1, caso exista é lido o ficheiro e escrito na ordem pedida para o ficheiro condutores.txt, depois o
## 		mesmo é passado para o user por success 2
##
###############################################################################

if [ -f pessoas.txt ]; then
		
	cat pessoas.txt | awk -F[\:] '{print("ID" $3 "-" $2 ";" $1 ";" $4 ";" $3 ";" 150)}' > condutores.txt 
		
	 ./success 2 ./condutores.txt
else

	 ./error 1 pessoas.txt
	 
fi