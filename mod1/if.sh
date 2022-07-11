
VAR=""
VAR2=""

if [[ "$VAR" = "$VAR2" ]]; then
  echo "São iguais"
fi

# Para condições verdadeiras
[ "$VAR" = "$VAR2" ] && echo "São iguais."
