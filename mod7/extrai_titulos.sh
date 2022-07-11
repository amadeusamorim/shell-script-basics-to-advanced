#!/usr/bin/env bash
#
# extrai_titulos.sh - Extrai titulos do blog
#
# Site:       github.com/amadeusamorim
# Autor:      Amadeus Amorim
# Manutenção: Amadeus Amorim
#
# ------------------------------------------------------------------------ #
#  Este programa irá extrair títulos do site clickpb, colocar em um arquivo de
#  texto e ler mostrando com cores na tela.
#
#  Exemplos:
#      $ ./extrai_titulos.sh
#      Neste exemplo o programa vai extrair os titulos e mostrar na tela.
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 22/06/2022, Amadeus:
#       - Montadas as expressões regular com fator em comum
#   v1.1 22/06/2022, Amadeus:
#       - Criado primeiro código com cores
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.0.17(1)-release
# ------------------------------------------------------------------------ #

# ------------------------------- VARIÁVEIS ----------------------------------------- #
ARQUIVO_DE_TITULOS="titulos.txt"

VERDE="\033[32;1m"
VERMELHO="\033[31;1m"
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #
[ ! -x "$(which lynx)" ] && sudo apt install lynx -y # Lynx instalado?
# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #

lynx -source clickpb.com.br | grep article__title |
      sed 's/<h1 class.*title">//;s/<\/.*//;s/<span.*://;s/\&#39//;s/\&quot//;s/^ *//g;s/;//;s/&.*[9t]//;/^\s*$/d' > titulos.txt


while read -r titulo_clickpb
do
  echo -e "${VERMELHO}Titulo: ${VERDE}$titulo_clickpb"
done < "$ARQUIVO_DE_TITULOS"
# ------------------------------------------------------------------------ #
