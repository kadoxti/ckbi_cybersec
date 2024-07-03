# Лекция № 1

## Содержание

- Утилита ls
- Утилита grep
- Скрипт bash

## Bash скрипт

Командная строка — отличный инструмент, но команды в неё приходится вводить каждый раз, когда в них возникает необходимость. Что если записать набор команд в файл и просто вызывать этот файл для их выполнения? Собственно говоря, тот файл, о котором мы говорим, и называется сценарием командной строки.

```bash
touch evil.sh # Создаем файл в текущей директории
vim ./evil.sh # Открываем файл в vim
```

Добавим в файл следующие строчки:

```bash
#!/bin/bash
pwd # Выведет текущую рабочую директорию (не обязательно месторасположение самого скрипта)
whoami # Выведет текущего пользователя
```

Установим права на запуск для скрипта и запустим его:

`chmod +x ./evil.sh ; ./evil.sh`

Перепишем скрипт, чтобы посмотреть, как пользоваться переменными и выводить более осмысленные сообщения:

```bash
#!/bin/bash
directory=`pwd` # Выполнили команду pwd и записали результат в переменную directory
user=$(whoami) # Выполнили команду whoami и записали результат в переменную user
echo "Текущая директория: $directory" # Читаем из переменной
echo "Текущий пользователь: $user"
```