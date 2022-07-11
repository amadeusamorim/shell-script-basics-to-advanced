#!/usr/bin/env bash

for i in $(seq 10); do
  if (($i % 2 == 0)); then
    echo "O número $i é divísel por 2!"
  fi
done

echo "==== Modo 2"

for i in $(seq 0 10); do
  [ $(($i % 2)) -eq 0 ] && echo "Número $i é divisível por 2"
done
