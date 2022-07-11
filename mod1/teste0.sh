#!/usr/bin/env bash
# MKDIR_HDFS="hdfs dfs -mkdir -p"
ENTRADA_HDFS="/projeto_final/"
SAIDA_HDFS="projeto_final/dados_saida/"
STAGE_HDFS="projeto_final/staging/"
MENSAGEM_USO="
  $(basename $0) - [OPÇÕES]

    -i - Cria pasta para tabelas raw (input) | Aguarda parâmetro com nome da pasta.
    -o - Cria pasta para tabelas dimensão (output) | Aguarda parâmetro com nome da pasta.
    -s - Cria pasta staginig
    -h - Menu de ajuda
"
AMARELO="\033[33;1m"

# Pode dar um source no teste.0 e exportar as FUNÇõES

CriaPasta () {
  case "$1" in
    -i) hdfs dfs -mkdir -p "${ENTRADA_HDFS}$2"        ;;
    -o) hdfs dfs -mkdir -p "${SAIDA_HDFS}$2"          ;;
    -s) hdfs dfs -mkdir -p "${STAGE_HDFS}"            ;;
    -h) echo "$MENSAGEM_USO" && exit 0                ;;
     *) echo "Opção Inválida, valide o -h." && exit 1 ;;
  esac
}

# CriaPastaSaída () {
#     hdfs dfs -mkdir -p "${SAIDA_HDFS}$1"
# }
#
# CriaPastaStaging () {
#     hdfs dfs -mkdir -p "${SAIDA_HDFS}$1"
# }

echo -e "${AMARELO}Criando Pastas de Entradas no HDFS"
CriaPasta -i clientes
CriaPasta -i divisao
CriaPasta -i endereco
CriaPasta -i regiao
CriaPasta -i vendas

echo -e "${AMARELO}Criando Pasta Staging no HDFS"
CriaPasta -s

echo -e "${AMARELO}Criando Pastas de Saídas no HDFS"
CriaPasta -o dimclientes
CriaPasta -o dimlocalidade
CriaPasta -o dimprodutos
CriaPasta -o dimtempo
CriaPasta -o fatovendas

# Executar o Create Tables
echo -e "${AMARELO}Criando tabelas no Hive"
cd scripts/create_tables
bash create_tables.sh
