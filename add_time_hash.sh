#!/bin/bash

# Функция для получения текущего timestamp в формате ГГГГММДД_ЧЧММСС
get_timestamp() {
                date +"%Y%m%d_%H%M%S"
}

# Функция для получения хэша последнего коммита из Git
get_git_hash() {
               git rev-parse HEAD 2>/dev/null  # Берем хэш текущего коммита, ошибки - > в NULL
}

# Функция для переименовки .log файлов в текущей директории
process_log_files() {
    local timestamp             # Локальная, чтобы потом ни с чем не путалась
    timestamp=$(get_timestamp)  # Сохраняем текущий timestamp в переменную

    for file in *.log; do  
        if [[ -f "$file" ]]; then     # Проверка на файловость
            base="${file%.log}"
            mv "$file" "${base}_${timestamp}.log"
            echo "✅ Переименован: $file → ${base}_${timestamp}.log"  # Выводим сообщение
        fi
    done
}

# Функция для переименовки всех .py файлов в текущей директории
process_py_files() {
    local hash            # Опять локальная, на всякий
    hash=$(get_git_hash)  # Получаем хэш коммита

    if [[ -z "$hash" ]]; then  # Проверяем, что хэш не пустой (мы в git-репозитории?)
        echo "Git-репозиторий не найден или нет коммитов."  # Выводим предупреждение
        return
    fi

    for file in *.py; do
        if [[ -f "$file" ]]; then  # Проверка на файловость
            base="${file%.py}"
            mv "$file" "${base}_${hash}.py"
            echo "✅ Переименован: $file → ${base}_${hash}.py"  # Выводим сообщение
        fi
    done
}

# Основная функция, которая запускает обработку
main() {
    process_log_files  # Запускаем обработку .log файлов
    process_py_files   # Запускаем обработку .py файлов
}

main  # Вызываем основную функцию
