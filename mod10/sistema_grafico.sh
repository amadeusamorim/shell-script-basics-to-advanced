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
[ ! -x "$(which dialog)" ] && sudo apt install dialog 1> /dev/null 2>&1
# ------------------------------------------------------------------------ #

# ------------------------------- FUNÇÕES ----------------------------------------- #

ListaUsuarios () {
  egrep -v "^#|^$" "$ARQUIVO_BANCO_DE_DADOS" | sort -h | tr : ' ' > "$TEMP"
  dialog --title "Lista de Usuários" --textbox "$TEMP" 20 40
  rm -f "$TEMP"
}

ValidaExistenciaUsuario () {
  grep -i -q "$1$SEP" "$ARQUIVO_BANCO_DE_DADOS"
}

OrdenaLista () {
  sort "$ARQUIVO_BANCO_DE_DADOS" > "$TEMP"
  mv "$TEMP" "$ARQUIVO_BANCO_DE_DADOS"
}
# ------------------------------- EXECUÇÃO ----------------------------------------- #
while :
do
  acao=$(dialog --title "Gerenciamento de Funcionários 2.0" \
                --stdout \
                --menu "Escolha uma das opções abaixo:" \
                0 0 0 \
                listar "Listar todos os funcinários ativos no sistema" \
                remover "Remover um funcionário do sistema" \
                inserir "Inserir um novo funcionário no sistema")
  [ $? -ne 0 ] && exit

  case $acao in
    listar) ListaFuncionarios ;;
    inserir)
    ultimo_id=$(egrep -v "^#|^$" "$ARQUIVO_BANCO_DE_DADOS" | sort -h | tail -n 1 | cut -d $SEP -f 1)
          proximo_id=$(($ultimo_id+1))

          nome=$(dialog --title "Cadastro de Funcionários" --stdout --inputbox "Digite o nome do funcionário" 0 0)
          [ ! "$nome" ] && exit 1

          ValidaExistenciaUsuario "$nome" && {
            dialog --title "ERRO FATAL!" --msgbox "Funcionário já cadastrado no sistema!" 6 40
            exit 1
          }

          funcao=$(dialog --title "Cadastro de Funcionários" --stdout --inputbox "Digite a função do funcionário" 0 0)
          [ $? -ne 0 ] && continue

          echo "$proximo_id$SEP$nome$SEP$funcao" >> "$ARQUIVO_BANCO_DE_DADOS"
          dialog --title "SUCESSO!" --msgbox "Usuário cadastrado com sucesso!" 6 40
          ListaFuncionarios
    ;;
    remover)
      usuarios=$(egrep "^#|^$" -v "$ARQUIVO_BANCO_DE_DADOS" | sort -h | cut -d $SEP -f 1,2 | sed 's/:/ "/;s/$/"/')
      id_usuario=$(eval dialog --stdout --menu \"Escolha um usuário:\" 0 0 0 $usuarios)
      [ $? -ne 0 ] && continue

      grep -i -v "^$id_usuario$SEP" "$ARQUIVO_BANCO_DE_DADOS" > "$TEMP"
      mv "$TEMP" "$ARQUIVO_BANCO_DE_DADOS"

      dialog --msgbox "Usuário removido com sucesso!"
      ListaFuncionarios
    ;;
  esac

done

# ------------------------------------------------------------------------ #
