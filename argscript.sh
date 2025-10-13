#!/bin/bash

# имя логфайла
logfile="args_out.txt"

# выводим аргументы в консоль
echo "аргументы командной строки:"
for arg in "$@"; do
    echo "$arg"
done

# записываю аргументы в файл
echo "Аргументы:" > "$logfile"
for arg in "$@"; do
    echo "$arg" >> "$logfile"
done

echo "Аргументы сохранены в $logfile"
