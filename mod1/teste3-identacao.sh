#!/usr/bin/env bash

# ./countstars: Printa asteriscos na tela em ordem decrescente

# Nome: Amadeus Amorim
# Manutenção: Amadeus Amorim

#-----------------------------------------------------------------------------------------------------------------#

# Descrição: Código que utiliza if para validar o código e for para executar. Caso esteja validado, será printado
# na tela asteriscos em ordem decrescente, iniciando a contagem com a variável 'fim' e indo até a variável 'início'


#--------------------------------------------- VARIÁVEIS --------------------------------------------------------------------#

inicio=0
fim=100

#-----------------------------------------------------------------------------------------------------------------#
# TESTES

[ $inicio -ge $fim ] && exit 1 # Caso o início seja maior que o fim, apresentar o erro.

#-----------------------------------------------------------------------------------------------------------------#

for i in $(seq $inicio $fim);do # Para cada número das variáveis
  for j in $(seq $i $fim); do # Iniciar um loop do valor do loop até o fim
    printf "*"; # Printando * e fazendo uma 'pirâmide'
  done;
  printf "\n"; # Pulando linha
done

#-----------------------------------------------------------------------------------------------------------------#
