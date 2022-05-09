#!/bin/bash

###############################################################################
## ISCTE-IUL: Trabalho prático de Sistemas Operativos 2021/2022
##
## Aluno: Nº:88047       
## Nome:Ruben Bento
## Nome do Módulo: menu.sh
## Descrição/Explicação do Módulo: 
## 
## Primeiramente é feito um loop infinito de modo a que o mesmo não feche. Depois por echos é feito uma pequeno texto para que o utlizador saiba as opções que tem disponíveis
## 		após isso com um read e um case é feito um pedido de informação ao utilizador que ação deseja realizar, caso a mesma seja 0 o menu fecha, caso seja diferente de 1, 2, 3 ou 4
## 		dá um echo a pedir uma informação válidae volta a mostrar o menu.
## No caso de ser 1 -> chama o script ./lista_condutores.sh
## No caso de ser 4 -> chama o script ./faturacao.sh
## No caso de ser 2 -> pede ao utilizador por ordem, o lanço, a autoestrada, e o valor da taxa via read, depois disso é chamado o script ./altera_taxa_portagem.sh coms as informações
## 		fornecidas pelo utilizador
## No caso de ser 3 -> é feito um novo loop e um submenu com novas opções, para sair do mesmo e voltar atrás, o ultizador terá de ou realizar uma ação do Status ou escrever 0 para voltar,
## 		qualquer outra opção avisa o utilizador para indicar uma opção válida e volta a mostrar o submenu 
##		No caso de ser 1 -> chama o script ./stats.sh listar e depois dá break do loop do submenu
##		No caso de ser 3 -> chama o script ./stats.sh condutores e depois dá break do loop do submenu
##		No caso de ser 2 -> pede o número de registos ao user e depois chama o script ./stats.sh registos "número introduzido pelo user"
## 
###############################################################################


while :
do

	echo ""
	echo "********************************************"
	echo "*                   MENU                   *"
	echo "********************************************"
	echo "*        1 - Listar Condutores             *"
	echo "*        2 - Alterar taxa de portagens     *"
	echo "*        3 - Stats                         *"
	echo "*        4 - Faturação                     *"
	echo "*        0 - Sair                          *"
	echo "********************************************" 
	read -p 'Opção: ' opcao
	
	case "$opcao" in
	
    	1)  
    		./lista_condutores.sh;;
        
        2)	
        	read -p 'Lanço: ' lanco
        	read -p 'Auto-estrada: ' ae
        	read -p 'Valor da taxa: ' tax
        	./altera_taxa_portagem.sh "$lanco" "$ae" "$tax";;
   
    	3)	
    		while :
    		do
    	
    			echo ""
    			echo "******************************************"
				echo "*                Stats                   *"
				echo "******************************************"
				echo "*      1 - Nome de todas as portangens   *"
				echo "*      2 - Registos utilização           *"
				echo "*      3 - Listagem condutores           *"
				echo "*      0 - Voltar                        *"
				echo "******************************************" 
				read -p 'Opção: ' opca
				
				case "$opca" in
				
	
					1)
						./stats.sh listar
						break;;
						
					2)
						read -p 'Número registos: ' nreg
						./stats.sh registos "$nreg"
						break;;
					
					3)
						./stats.sh condutores
						break;;
						
					0)
						break;;
						
						
					*)
						echo "Por favor introduza uma opção válida";;
				
				esac
			done
			;;

    	4)  
    		./faturacao.sh;;
    		

    	0)  
    		echo "Processo Terminado. Obrigado Pela sua preferência!"
			exit;;
			
		*)
			echo "Por favor introduza uma opção válida"
		
	esac
	
done	



