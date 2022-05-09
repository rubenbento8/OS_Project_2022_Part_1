#!/bin/bash

###############################################################################
## ISCTE-IUL: Trabalho prático de Sistemas Operativos 2021/2022
##
## Aluno: Nº: 88047       
## Nome: Rúben Bento
## Nome do Módulo: altera_taxa_portagem.sh
##
##	Primeiramente o script dá touch ao ficheiro portagens.txt para o caso do mesmo não existir, depois verifica o numero de argumentos dado se o mesmo é inferior a 3, caso seja, dá error 2
##  	de número de argumentos inválido.
##      Caso o número seja superior ou igual a 3 vai verificar se os argumentos estão válidos. Començando pelo lanço ter que ser no mínimo uma letra primeiro, maíscula ou minúscula, apenas
## 		apenas também só poder ser letras, seguido por um - e de volta a no mínimo uma letra.
##      Depois verifica se a Auto Estrada é composta pela maneira que de momento estão em portugal, um A maiúsculo e seguido por números, em que o primeiro tem sempre de ser entre 1 e 9,
##		excluindo a possibilidade de ser A02 por exemplo.
##		E por fim verifica se o valor da taxa é um número inteiro positivo. Caso um dos argumentos esteja mal, é informado ao user pelo error 3
##      Depois de os argumentos estarem verificados, o mesmo verifica se o conjunto lanço autoestrada já existe no ficheiro portagens.txt, sem se preocupar se as letras estão em minúscula 
##  	ou maiúscula com um grep -i. Caso o conjunto já exista, é guardado o id da portagem e depois por um awk com as variáveis externas id e tax, tax que é o argumento 3 dado ao início,
##      com um if, caso o id esteja presente na primeira parte da linha, é impressa a linha com o valor alterado num ficheiro temporário, paras as restantes linhas simplesmente imprime
##      a linha sem alterações. Depois o ficheiro temporarário é movido para passar a ser portagens.txt e dá success 3 para informar que o lanço foi atualizado
##      Caso o conjunto ainda não exista, é primeiramente calculado o id máximo e adicionado 1, começando sempre o id a 0 para o caso do ficheiro estar vazio assim o primeiro id é 1, 
## 		é escrito no ficheiro uma nova linha com o novo id e as informações dadas pelo user. Depois o ficheiro é organizado pela Auto-Estrada primeiro e só depois pelo lanço usando sort com
##      -t para escolher o indicador de separação, e -k3,3 para indicar por que valor deve primeiro pelo valor na terceira posição, a auto estrada, e depois -k2,2 pelo lanço para
## 		desempatar. Depois o ficheiro temporarário é movido para passar a ser portagens.txt e dá success 3 para informar que o lanço foi atualizado.
##		No final é passado o ficheiro portagens.txt ao user usando success 4.
##
###############################################################################
touch portagens.txt

if [[ "$#" < 3 ]]; then 
	
	./error 2

else

	if [[ "$1" =~ ^[A-Za-z]+-[A-Za-z]+$ ]]; then
	
		if [[ $2 =~ ^A[1-9][0-9]*$ ]]; then
	
			if [[ $3 =~ ^[0-9]+$ ]]; then
		
				if (cat portagens.txt | grep -i $1 | grep -iq $2) ; then

 					id="$( cat portagens.txt | grep -i $1 | grep -i $2 | cut -d":" -f1 )"
 
 					cat portagens.txt | awk -v ida=$id -v tax=$3 -F':' '{if ($1==ida) {print $1 ":" $2 ":" $3 ":" tax} else print $0}' > temp.txt
 					mv temp.txt portagens.txt
 				
 					./success 3 $1
	
				else
 				
 				
 					id=0
 					id="$( cat portagens.txt | cut -d":" -f1| sort -n | tail -1 )"
 					id=$(( $id+1 ))
 				
 					echo $id":"$1":"$2":"$3  >> portagens.txt
 				
 					sort -t ':' -k3,3 -k2,2 portagens.txt > temp.txt
 					mv temp.txt portagens.txt
 				
 					./success 3 $1
	
				fi
			
				./success 4 portagens.txt
				
			else

				./error 3 $3

			fi
		
		else

			./error 3 $2
			
		fi
	
	else
	
		./error 3 $1	
			
	fi
fi