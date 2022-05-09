#!/bin/bash

###############################################################################
## ISCTE-IUL: Trabalho prático de Sistemas Operativos 2021/2022
##
## Aluno: Nº: 88047       
## Nome: Rúben Bento
## Nome do Módulo: stats.sh
## Descrição/Explicação do Módulo: 
##
## Este módulo primeiramente lê o primeiro argumento e verifica por Ifs se é ou "listar", ou "condutores" ou "registos", caso não seja dá erro que não é um argumento esperado 
## No caso de ser listar -> lê o ficheiro portagens.txt, faz um corte colunas para restar apenas a parte das autoestradas, organiza as e corta os nomes repetidos,
## 		restando apenas uma vez o nome das autoestradas presentes no ficheiro, esta mesma informação é passada para um ficheiro txt temporarário e passado para o utilizador usando o success 6
## 		e no fim o ficheiro temporário é apagado
## No caso de ser condutores -> lê o ficheiro relatorio_utilizacao.txt linha a linha com um while, em cada linha pega no Id presente e lendo o ficheiro pessoas.txt pega no nome respetivo
##		do condutor e escreve em um ficheiro temporário apenas os nomes. Depois esse ficheiro temporário é organizado, corta os nomes repetidos com um "uniq" e passa a informação para um
##		segundo ficheiro secundário que este mesmo é passado para o utizador vi success 6. No fim ambos os ficheiros temporários ficam apagados
## No caso de ser registos -> primeiramente verifica o número de argumentos se é igual ou superior a 2, caso seja inferior dá erro que faltam argumentos, caso seja igual ou superior
## 		verifica se o segundo argumento é um número inteiro e se é maior que 0, caso não seja dá erro de argumento inválido, caso seja abre o ficheiro relatorio_utilizacao.txt e corta
##		as colunas de modo a ficar apenas o lanço, volta a ordenar o ficheiro, é usado um uniq -c para ficar apenas uma vez cada nome e quantas vezes aparecem no ficheiro, para facilitar 
##		a leitura de erros futuros, ainda são substituidos múltiplos espaços por apenas 1 e depois é escrita esta informação para um ficheiro temporário
##		Após isso, o ficheiro temporário é passado para um awk com a variável externa "nr" correndondente ao argumento 2, e depois é verificado em cada linha, se o número de vezes que
##		aparece no ficheiro for maior ou igual ao segundo argumento, é escrito o lanço em um segundo ficheiro temporário, no final é mostrado o ficheiro ao utilizador por o success 6 e
##		os ficheiros temporários são apagados
##
###############################################################################

if [[ "$1" == "listar" ]]; then

	cat portagens.txt | cut -d':' -f3 | sort | uniq > temp.txt 
	./success 6 temp.txt
	rm temp.txt

else
	if [[ "$1" == "condutores" ]]; then
		
		while IFS= read -r line
		
		do
			id="$( echo "$line"  | cut -d":" -f3 | cut -d'D' -f2 )"
			cat pessoas.txt | grep $id | cut -d":" -f2  >> temp1.txt
		
		done < relatorio_utilizacao.txt
		
		cat temp1.txt | sort | uniq > temp.txt
		rm temp1.txt
		
		./success 6 temp.txt
		rm temp.txt
		

	else
		
		if [[ "$1" == "registos" ]]; then
			
			if [[ "$#" < 2 ]]; then
			
				./error 2

			else 

				if [[ "$2" > 0 && $2 =~ ^[0-9]+$ ]]; then
				
					cat relatorio_utilizacao.txt | cut -d':' -f2 | sort | uniq -c | sed -E "s/ +/ /g" > temp1.txt  
					cat temp1.txt | awk -v nr=$2 '{if ($1 >= nr) {print $2}}' > temp.txt
					
					rm temp1.txt
					
					./success 6 temp.txt
					rm temp.txt
					
				else
					
					./error 3 $2
					
				fi

			fi	

		else

			./error 3 $1

		fi	
	fi	
fi



