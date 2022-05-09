#!/bin/bash

###############################################################################
## ISCTE-IUL: Trabalho prático de Sistemas Operativos 2021/2022
##
## Aluno: Nº: 88047      
## Nome: Rúben Bento
## Nome do Módulo: faturacao.sh
## Descrição/Explicação do Módulo: 
## 
## Primeiramente verifica se o ficheiro relatorio_utilizacao.txt existe, caso não exista dá erro que o ficheiro não existe por error 1, e caso exista primeiro verifica se o ficheiro 
## 		faturas.txt existe, caso exista apaga-o. Depois verifica se o ficheiro relatorio_utilizacao.txt está vazio ou não, caso esteja vazio informa o user que o ficheiro está vazio e
## 		acaba, caso bnão esteja vazio primeiramente cria o ficheiro faturas.txt com um touch e depois com um while IFS= lê linha a linha o ficheiro pessoas.txt e pega nos nomes presentes
## 		no ficheiro e escreve no ficheiro faturas.txt juntamente com "Cliente: ", e ainda pega no id. Depois lê o ficheiro relatorio_utilizacao.txt e escreve as linha que contenham o id
##		e escreve as no ficheiro faturas.txt. Depois disso é lido novamente o ficheiro e as linhas presentes que contenham o id, são passadas para o awk onde o mesmo pegar no custo de 
##		cada utlização e irá somar a uma variável interna, que no final das linhas vai escrever essa variável total no final.
##		Independentemente de o cliente ter ou não faturas, no ficheiro o seu nome irá sempre aparecer mas depois sem qualquer faturas em seu nome no ficheiro
##      O ficheiro faturas.txt é depois passado para o user pelo success 5
##
###############################################################################

if [ -f  relatorio_utilizacao.txt ]; then
		
	if [ -f  faturas.txt ]; then
	
		rm faturas.txt
		
	fi
	
	
	if [ -s relatorio_utilizacao.txt ]; then
		
		touch faturas.txt
		
		while IFS= read -r line
		
		do
		
			echo "$line" | awk -F':' '{print "Cliente: "$2}' >> faturas.txt
			id="$( echo "$line"  | cut -d":" -f3 )"
			cat relatorio_utilizacao.txt | grep $id >> faturas.txt
			cat relatorio_utilizacao.txt | grep $id | awk -F':' 'BEGIN {total = 0} {total+=$5} END {print "Total: "total" créditos"}' >> faturas.txt
			echo " " >> faturas.txt
		
		
		done < "pessoas.txt"
		
		
	else
	
		echo "Ficheiro relatorio_utilizacao.txt vazio"
		
	fi
	
	./success 5 faturas.txt
	
		
else

	  ./error 1 relatorio_utilizacao.txt

fi