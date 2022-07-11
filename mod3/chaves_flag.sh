#!/usr/bin/env bash
#
# listaUsuarios.sh - Extrai usuários do /etc/passwd
#
# Site:       https://4fasters.com.br
# Autor:     Amadeus Amorim
# Manutenção: Amadeus Amorim
#
# ------------------------------------------------------------------------ #
#  Irá extrair usuários do /etc/passwd, havendo a possibilidade de colocar
# em maiúsculo e em ordem alfabética.
#
#  Exemplos:
#      $ ./listaUsuarios.sh -s -m
#      Neste exemplo ficará em maiúsculo e em ordem alfabética
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 21/06/2022, Amadeus:
#     - Adicionando -s, -h & -v
#   v1.1 21/06/2022, Amadeus:
#     - Trocando IF pelo CASE
#     - Adicionando basename
#   v1.2 21/06/2022, Amadeus:
#     - Adicionando -m
#     - Adicionando 2 flags
#   v.1.3 21/06/2022, Amadeus:
#     - Adicionando while com shift e teste de variável
#     - Adicionando 2 flags
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 4.4.19
# ------------------------------------------------------------------------ #

# ------------------------------- VARIÁVEIS ----------------------------------------- #
USUARIOS="$(cat /etc/passwd | cut -d : -f 1)"
MENSAGEM_USO="
  $(basename $0) - [OPÇÕES]

    -h - Menu de ajuda
    -v - Versão
    -s - Ordenar a Saída
    -m - Coloca em maiúsculo
"
VERSAO="v1.3"
CHAVE_ORDENA=0
CHAVE_MAIUSCULO=0
# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #
while test -n "$1"
do
  case "$1" in
    -h) echo "$MENSAGEM_USO" && exit 0                ;;
    -v) echo "$VERSAO" && exit 0                      ;;
    -s) CHAVE_ORDENA=1                                ;;
    -m) CHAVE_MAIUSCULO=1                             ;;
     *) echo "Opção Inválida, valide o -h." && exit 1 ;;
  esac
  shift
done

[ $CHAVE_ORDENA -eq 1 ]    && USUARIOS=$(echo "$USUARIOS" | sort)
[ $CHAVE_MAIUSCULO -eq 1 ] && USUARIOS=$(echo "$USUARIOS" | tr [a-z] [A-Z])

echo "$USUARIOS"
# ------------------------------------------------------------------------ #
