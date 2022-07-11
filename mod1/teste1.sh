# Validar se o primeiro parâmetro enviado é maior que 10
# Se for maior, mostre uma mensagem na tela com o nome do script e seu respectivo PID de execução

[ $1 -gt 10 ] && echo "O nome do arquivo é: $0 | Seu PID é o $$"
