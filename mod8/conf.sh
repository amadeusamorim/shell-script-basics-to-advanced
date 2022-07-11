#!/usr/bin/env bash
#
# ------------------------------- VARIÁVEIS ----------------------------------------- #
ARQUIVO_DE_CONFIGURACAO='configuracao.cf'
USAR_CORES=
USAR_MAIUSCULAS=
MENSAGEM="Mensagem de teste"

AMARELO="\033[33;1m"
AZUL="\033[34;1m"
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #
# Testa se o arquivo de configuracao pode ser lido
[ ! -r "$ARQUIVO_DE_CONFIGURACAO" ] && echo "Não temos acesso de leitura" && exit 1
# ------------------------------------------------------------------------ #

# ------------------------------- FUNÇõES ----------------------------------------- #
DefinirParametros () {
  local parametro="$(echo $1 | cut -d = -f 1)"
  local valor="$(echo $1 | cut -d = -f 2)"

  case "$parametro" in
    USAR_CORES)      USAR_CORES="$valor"      ;;
    USAR_MAIUSCULAS) USAR_MAIUSCULAS="$valor" ;;
  esac
}

# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #
while read -r linha
do
  [ "$(echo $linha | cut -c1)" = "#" ] && continue
  [ ! "$linha" ] && continue
  DefinirParametros "$linha"
done < "$ARQUIVO_DE_CONFIGURACAO"

[ "$USAR_MAIUSCULAS" = "1" ] && MENSAGEM="$(echo -e $MENSAGEM | tr [a-z] [A-Z])"
[ "$USAR_CORES" = "1" ] && MENSAGEM="$(echo -e ${AMARELO}$MENSAGEM)"

echo "$MENSAGEM"

# ------------------------------------------------------------------------ #
