#!/bin/bash

# Проверка аргументов
if [ "$#" -ne 2 ]; then
    echo "Использование: $0 <строка_поиска> <каталог>"
    exit 1
fi

search_string="$1"
search_dir="$2"

# Проверка существования каталога
if [ ! -d "$search_dir" ]; then
    echo "Ошибка: каталог '$search_dir' не существует."
    exit 2
fi

# Поиск всех каталогов, включая основной
find "$search_dir" -type d 2>/dev/null | while read -r dir; do
    # Проверка доступа к каталогу
    if [ ! -r "$dir" ]; then
        echo "Нет доступа к каталогу: $dir"
        continue
    fi

    # Поиск файлов в доступном каталоге
    find "$dir" -maxdepth 1 -type f 2>/dev/null | while read -r file; do
        if grep -q "$search_string" "$file" 2>/dev/null; then
            size=$(stat -c%s "$file")
            echo "Файл: $file | Размер: $size байт"
        fi
    done
done
