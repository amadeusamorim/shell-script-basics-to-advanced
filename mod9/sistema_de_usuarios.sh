#!/usr/bin/env bash
#
# extrai_titulos.sh - Sistema para gerenciamento de usuários
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
#      $ ./sistema_de_usuarios.sh
#      $ source sistema_de_usuarios.#!/bin/sh
#      $ ListaUsuarios
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 22/06/2022, Amadeus:
#       - Tratamento de erros com relação ao arquivo do banco de dados
#
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.0.17(1)-release
# ------------------------------------------------------------------------ #

# ------------------------------- VARIÁVEIS ----------------------------------------- #
ARQUIVO_BANCO_DE_DADOS="banco_de_dados.txt"
SEP=:
TEMP=temp.$$
VERDE="\033[32;1m"
VERMELHO="\033[31;1m"
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #
[ ! -e "$ARQUIVO_BANCO_DE_DADOS" ] && echo "ERRO. Arquivo não existe." && exit 1
[ ! -r "$ARQUIVO_BANCO_DE_DADOS" ] && echo "ERRO. Arquivo não tem permissão de leitura." && exit 1
[ ! -w "$ARQUIVO_BANCO_DE_DADOS" ] && echo "ERRO. Arquivo não tem permissão de escrita." && exit 1
# ------------------------------------------------------------------------ #

# ------------------------------- FUNÇÕES ----------------------------------------- #
MostraUsuarioNaTela () {
  local id="$(echo $1 | cut -d $SEP -f 1)"
  local nome="$(echo $1 | cut -d $SEP -f 2)"
  local email="$(echo $1 | cut -d $SEP -f 3)"

  echo -e "${VERDE}ID: ${VERMELHO}$id"
  echo -e "${VERDE}Nome: ${VERMELHO}$nome"
  echo -e "${VERDE}E-mail: ${VERMELHO}$email"
}

ListaUsuarios () {
  while read -r linha
  do
    [ "$(echo $linha | cut -c1)" = "#" ] && continue
    [ ! "$linha" ] && continue

    MostraUsuarioNaTela "$linha"
  done < "$ARQUIVO_BANCO_DE_DADOS"
}

ValidaExistenciaUsuario () {
  grep -i -q "$1$SEP" "$ARQUIVO_BANCO_DE_DADOS"
}

InsereUsuario () {
  local nome="$(echo $1 | cut -d $SEP -f 2)"

  if ValidaExistenciaUsuario "$nome"
  then
    echo "ERRO. Usuário já existente!"
  else
    echo "$*" >> "$ARQUIVO_BANCO_DE_DADOS"
    echo "Usuário cadastrado com sucesso!"
  fi
  OrdenaLista
}

ApagaUsuario () {
  ValidaExistenciaUsuario "$1" || return

  grep -i -v "$1$SEP" "$ARQUIVO_BANCO_DE_DADOS" > "$TEMP"
  mv "$TEMP" "$ARQUIVO_BANCO_DE_DADOS"

  echo "Usuário removido com sucesso!"
  OrdenaLista
}

OrdenaLista () {
  sort "$ARQUIVO_BANCO_DE_DADOS" > "$TEMP"
  mv "$TEMP" "$ARQUIVO_BANCO_DE_DADOS"
}
# ------------------------------- EXECUÇÃO ----------------------------------------- #


# ------------------------------------------------------------------------ #
