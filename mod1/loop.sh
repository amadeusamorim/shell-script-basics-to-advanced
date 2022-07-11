#!/usr/bin/env bash


echo "==== For 1"
for (( i = 0; i < 10; i++ )); do
	echo $i
done

# O seq printa a sequencia
echo "==== For 2 (seq)"
for i in $(seq 10); do
  echo $i
done

# Array
echo "==== For 3 (array)"
Frutas=(
'Laranja'
'Ameixa'
'Abacaxi'
'Melancia'
)
# O @ significa todos os items do array
for i in "${Frutas[@]}"; do
  echo $i
done

# while

echo "==== while"
contador=0

# O comando ${#Lista[@]} passa o len da lista
while [[ $contador -lt ${#Frutas[@]} ]]; do
  echo $contador
  contador=$(($contador+1))
done
