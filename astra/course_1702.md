# Курс 1702 Администрирование Astra Linux

https://www.aldpro.ru/professional/

Типы репозиториев:
- main - сертифицированный установочный диск
- base - расширенный репозиторий, содержит в себе main и средства разработки, и пакеты, необходимые для сборки пакетов из main. Пакеты возможно доработаны для работы с системой защиты astra
- extended - все совместимое с астрой ПО

## После установки

После установки необходимо проверить версию ОС и ядра
```bash
lsbrelease -a # или cat /etc/astra_version
uname -a
```

Необходимо проверить состояние мандатного контроля целостности на файловой системе:
```bash
sudo set-fs-ilev status -v
```

Пользователь, созданный во время установки, входит в группу astra-admin.
Root по умолчанию заблокирован.

Проверить объем свободного места:
`df -h`

## Установка обновлений

Проверить контрольную сумму обновления: `gostsum -d update.iso` или `gostsum -d /dev/sr0`.

Установить обновление `sudo astra-update -k -a update.iso`

Опционально `sudo apt install gcc make linux-headers-$(uname -r)`

## Другое

Максимальный уровень мандатной целостности - 63. Необходим для административных действий.

`/etc/grub.d/`, `/boot/grub/grub.cfg` - настройки загрузчика

`history -c` - очистка истории
`!!` - вызов предыдущей команды

Переменная окружения PS1 отвечает за формат приглашения.

## Использование справочных ресурсов

- Подсказки самих команд
- Помощь по встроенным командам:
  - Встроенные в bash: `man builtins`
  - Встроенные в систему: `help`
- **man** - встроенный справочник Linux
- **info** - справочная система
- Электронная справка Astra Linux - `alt+f1` - вызов справки astra linux
- wiki.astralinux.ru

### man

Всего 8 разделов в man:
1. Исполняемые программы и ли команды оболочки
2. Системые вызовы (функции, предоставляемые ядром)
3. Библиотечные вызовы
4. Специальные файлы (из каталога /dev)
5. Форматы файлов и соглашения (например /etc/passwd)
6. Игры
7. Разное (макросы, соглашения)
8. Команды адмнистрирования системы (в т.ч. демоны)
9. Процедуры ядра (нестандартный раздел)

Режимы работы man:
- man объект
- `man -a объект` - вывод всех доступных справочников
- `man -f объект` - ведёт поиск по заголовкам и возвращает все вхождения
- `man -k строка_поиска` - поиск по кратким описаниям, а также заголовкам страниц
- `man -K строка_поиска` - поиск текста во всех справочных страницах. Поиск идет по исходному тексту, поэтому ищет даже по комментариям
- `man номер объект` - поиск в конкретном разделе

### info

Гипертектовая справочная система
Навигация - H - помощь, u - переход на уровень выше, p - предыдущий узел, n - следующий узел

## Работа с файлами

/ - точка монтирования ОС
Каждый каталог (даже пустой) содержит жесткие ссылки . и ..
**inode** - уникальный индекс у каждого файла, содержит информацию (метаданные) о файле

Вывести номер inode можно через `ls -i`

**Типы файлов:**
- Регулярный файл
- Каталог - сопоставляет имя файла с номером inode
- Символьная ссылка
- Жесткая ссылка
- Файл устройств (блочных и символьных)
- Локальные сокеты (socket) и каналы (pipe)

**Символическая ссылка** - привычный ярлык. Содержит **путь** на источник. Битая символическая ссылка ссылается на несуществующий объект (красным в териминале). Удаление источника делает ссылку битой

**Жесткие ссылки** - ссылка на inode (т.е. inode у жесткой ссылки будет тот же самый). Удаление источника всего-лишь уменьшает счетчик жестких ссылок на 1. У папки нельзя сделать жесткую ссылку

### Стандарт иерархии файловой системы

`man hier`

Содержимое папки /tmp очищается при каждом перезапуске системы.

/var - изменяемые файлы. /var/log - журналы
/dev/null - вечно пустой файл. черная дыра. В него можно перенаправлять потоки, чтобы подавить вывод

### Навигация

- `cd путь` - без аргумента произойдет переход в домашний каталог
- pwd
- ls
- dir
- tree - содержимое каталогов в древовидном виде (нужно качать пакет)

### Создание файла

- `touch имя_файла` - создает файл. Также команда умеет менять время изменения файла
- `mkdir [-p] имя папки` - создает папки. Опция p позволяет создать все промежуточные папки
- `ln -s` - создание символической ссылки
- `ln` - создание жесткой ссылки
- `mknod` - создание создание специального файла устройств
- `mkfifo` - создание именованноо канала

### Операции с файлами

- `cp [a][r][s][d]` - копирование файла или папки
- `mv` - перемещение/переименование файла/папки
- `rm [r][f]` - удаление
- `rmdir` - удаление пустой папки

### Другое

- `file` - информация о характере содержимого файла
- `which` - поиск по имени в каталогах внутри PATH
- `find` - поиск по имени файлов. По умолчанию рекурсивный
- `grep` - поиск по содержимому файлов

## Работа с текстом

### Потоки ввода вывода

- stdin 0
- stdout 1
- stderr 2

Перенаправление потоков:
- `echo hello > file` или `echo hello 1> file`
- `echo hello 2> file` - перенаправление потока ошибок
- `echo hello >> file` - не перезаписывает файл, а дописывает в конец
- `less < file` - передает содержимое file на вход (stdin) в less
- &> - вывод обоих потоков

Перенаправление потока на stdin вынуждено учитывать права доступа:
Если нет прав на file, то ` less < file не отработает` и не отработает ` sudo less < file`. Отработает `sudo bash -c "less < file"`

`|` - конвейер, перенаправляет выходной поток одной команды на входной поток другой команды.

### Просмотр текста

**Вывод текста**

- `cat`, `tac`
- `head [n]`, `tail [n]`
- `tail -f` - вывод конца файла в режиме реального времени (при добавлении)
- `less` - интерактивный вывод

**Фильтры**

- wc - подсчет строк, слов, символов
- sort - сортировка
- cut - вырезание символов или полей из строк
- uniq - показывает или убирает повторяющиеся строки
- tr - замена символов
- tee file - перенаправление потоков в/из файл
- nl - нумерация строк
- xargs

**Утилиты**

- grep
- sed
- awk - построчная обработка текстовых потоков