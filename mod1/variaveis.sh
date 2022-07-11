#!/usr/bin/env bash

NOME="Amadeus


Amorim"

echo "$NOME"

NUMERO_1=24
NUMERO_2=45

TOTAL=$(($NUMERO_1+$NUMERO_2))

echo $TOTAL

SAIDA_CAT=$(cat /etc/passwd | grep amadeus)

echo $SAIDA_CAT

echo "-----------------------------------------"

echo "Parametro 1: $1"
echo "Parametro 2: $2"

echo "Todos os parâmetros: $*"
# Repassa o total de parâmetros enviados
echo "Quantos parâmetros enviados? $#"

# Mostra a saída do último comando
echo "Saída do último comando: $?"

# Pego o PID do script
echo "PID: $$"

# Busca o nome do script
echo $0
