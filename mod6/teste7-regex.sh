# ------------------------------- INSTRUÇõES ----------------------------------------- #
# Para este exercício liste todos os grupos do seu Linux com este comando:
#   $ cut -d : -f 1 /etc/group
# Envie a saída do comando acima para o comando grep (use o PIPE "|") e faça as seguintes Expressões Regulares:
# Grupos que começam com a letra "r" no arquivo /etc/group
# Grupos que terminem com a letra "t"
# Grupos que comecem com a letra "r" e terminem com a letra "t"
# Grupos que terminam com a letra "e" ou "d"
# Grupos que não terminam com a letra "e" ou "d"
# Grupos que começam com qualquer dígito e a segunda letra seja um "u" ou "d"
# Grupos que tenha seu nome de 2 a 4 dígitos de tamanho
# Grupos que comecem com "r" ou "s" (use o operador OR)
# ------------------------------------------------------------------------ #

VERDE="\033[32;1m"
AMARELO="\033[33;1m"


echo -e "${AMARELO} Iniciando programa"

echo -e "${VERDE} Listando grupos que comecem com a letra 'r' no arquivo"
cut -d : -f 1 /etc/group | grep "^r"
echo -e "${VERDE} Listando grupos que terminem com a letra 't' no arquivo"
cut -d : -f 1 /etc/group | grep "t$"
echo -e "${VERDE} Listando grupos que comecem com a letra 'r' e terminem com a letra 't'"
cut -d : -f 1 /etc/group | grep "^r.*t$"
echo -e "${VERDE} Listando grupos que terminam com a letra 'e' ou 'd"
cut -d : -f 1 /etc/group | grep "[ed]$"
echo -e "${VERDE} Listando grupos que NãO terminam com a letra 'e' ou 'd"
cut -d : -f 1 /etc/group | grep "[^ed]$"
echo -e "${VERDE} Listando grupos tenham seu nome de 2 a 4 dígitos de tamanho"
cut -d : -f 1 /etc/group | egrep "^.{2,4}$"
echo -e "${VERDE} Listando grupos comecem com 'r' ou 's'"
cut -d : -f 1 /etc/group | egrep "^r|^s"

echo -e "${AMARELO} Finalizando programa"
