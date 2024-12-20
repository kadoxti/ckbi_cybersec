# Курс 1702 Администрирование Astra Linux

https://www.aldpro.ru/professional/

**Типы репозиториев:**
- main - сертифицированный установочный диск
- base - расширенный репозиторий, содержит в себе main и средства разработки, и пакеты, необходимые для сборки пакетов из main. Пакеты возможно доработаны для работы с системой защиты astra
- extended - все совместимое с астрой ПО

**Уровни защищенности ОС:**
- Орел
- Воронеж
- Смоленск

## Установка

Выбор версии ядра:
- generic версия ядра
- hardened версия ядра - из ядра исключены некоторые модули: отладки и тд. Дополнительная защита от атак на ядро. Работает медленнее generic версии
- low latency

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

init=/bin/bash (в grub) - для запуска с перехватом

`history -c` - очистка истории  
`!!` - вызов предыдущей команды

Переменная окружения PS1 отвечает за формат приглашения.

## Терминал

**Типы терминалов:**
- Аппаратный - архаизм
- Виртуальный
- Псевдотерминал

Виртуальный терминал находится внутри ядра. Виртуальный терминал определяется системой как устройство, поэтому его можно найти в папке /dev/tty*

- alt+T - Запуск терминала   
- ctrl+alt+{f1+...f7} - переключение терминалов. Графический терминал имеет номер 7  
- ctrl+shift+'+' - расширение экрана терминала  
- tab - автодополнение строки или пути. Если нажать дважды, то отработает как ls  

- `chvt [1...7]` - также переключение терминалов
- `tty` - вывод текущего терминала
- `stty` - настройки терминала
- `screen` - утилита многооконности терминала
- `terminfo` - база данных. infocmp

- `tput lines n` - задать количество линий в терминале
- `tput cols n`- задать количество колонок символов в терминале
- `tput bold` - жирное выделение символов
- `tput reset` - сброс настроек

### Базовые утилиты

- whoami, whereis, pwd, cat, mkdir -p, , ;, |
- sudo - единоразовое выполнение команды с правами суперюзера
- date - дата время
- cal - календарь

### Переменные окружения

VAR=123 - определение переменной  
export VAR=123 - экспорт переменной для всех дочерних процессов  
unset VAR - удаление переменной  
set, set -o - вывод переменных окружения  

$PS1 - формат приглашения терминала  
$LANG - локаль  
$LONGNAME  
$HOSTNAME - имя хоста  
$TERM - хранит то, какой терминал  

### Спецсимволы

- \* - любое количество символов в строке, предшествующих "звездочке", в том числе и нулевое число символов. не заменяет спецсимволы  
- . - не менее одного любого символа, за исключением символа перевода строки (\n)
- ? - предыдущий символ или регулярное выражение встречается 0 или 1 раз. В основном используется для поиска одиночных символов
- ^ - означает начало строки, но иногда, в зависимости от контекста, означает отрицание в регулярных выражениях
- $ - в конце регулярного выражения соответствует концу строки
- [] - предназначены для задания подмножества символов. Квадратные скобки, внутри регулярного выражения, считаются одним символом, который может принимать значения, перечисленные внутри этих скобок
- {} - задают число вхождений предыдущего выражения

'' - экранирует спецсимволы  
"" - не экранирует спецсимволы  
^$ - пустая строка

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
- diff

**Утилиты**

- grep
- sed
- awk - построчная обработка текстовых потоков

## Процессы
https://www.aldpro.ru/professional/ALSE_Module_13/processes.html

`systemd` - управляющий процесс

ELF файл

`ps` - вывод информации о процессах. `ps -o pid,ppid,cmd` - можно задавать выводимые колонки

`pstree` - вывод дерева процессов

pid - process id

ppid - parent process id

**Типы процессов:**
- Пользовательские процессы (связаны с терминалом)
- Службы или демоны (не связаны с терминалом)

**Состояния процессов:**
- R Runnable
- S Sleeping - ожидание неопределенного события или сигнала
- D Uninterruptable sleep - ожидание определенного события, чаще всего ожидания операции ввода-вывода. Даже kill может не помочь прервать ожидание
- T Stopped
- Z Zombie - процесс завершился, но код завершения не получен

Чтобы отвязать процесс от терминала нужно в конце команды указать `&`:

`sleep 1000 &`

### IPC

https://habr.com/ru/articles/819263/

- Обмен данными:
  - Каналы и очереди FIFO
  - Сокеты локальные и сетевые
  - Очереди сообщений
  - Разделяемая память
- Синхронизация работы процессов
  - Семафоры
  - Блокировки файлов
- Сигналы

### Мониторинг процессов

- `ps -e` - все процессы
- `ps -f` - наиболее популярные атрибуты процессов
- `ps -l `- подробный вывод
- `ps -aux` - показывать загрузку памяти и процессора
- pstree
- `top` - мониторинг в режиме реального времени
- `htop` - gui для `top`

### Приоритет процессов

У процессов реального времени сатический приоритет от 1 до 99. У процессов разделения времени статический приоритет = 0 и динамический приоритет, который зависит от числа NICE (-20 + 19).  
Отрицательные NICE может задавать только root.  
Пользователь также не может повысить приоритет у запущенного процесса, только понизить.  

Чем меньше NICE - тем выше приоритет.
- `nice -n число команда` - у нового процесса
- `renice -n число -p PID` - у запущенного процесса
- флаг `-u` задает приоритет всем процессам пользователя

### Сигналы

`kill -s сигнал PID` - отправка сигнала процессу

`kill -l` - список сигналов

`kill PID` = ` kill -s SIGTERM PID`

`kill -s SIGKILL PID` - безусловное убийство процесса

`ctrl+c`, `ctrl+d`, `ctrl+z`, `ctrl+\`

### Управление заданиями

`jobs` - вывод всех заданий  
`fg %номер_задания` - сделать задание активным  
`bg %номер_задания` - сделать задание фоновым  
`kill %номер_задания` - отправить сигнал заданию  
`&` - запустить задание фоном  

## Управление учетными записями пользователей и групп

**Подготовка к созданию учетных записей:**
1. Выработать правила формирования имен учетных записей пользователй и групп
2. Решить, как будут распределятьсяидентификаторы UID, GID
3. Определить основную (первичную) и дополнительные (вторичнеы группы для учетных записей
4. Решить, где будут располагаться домашние каталоги (если требуется не home)
5. Решить, какой будет интерпретатор по умолчанию
6. Определить парольную политику

**Политики первичных групп. Если явно не задается первичная:**
- то будет либо GID 100 (users),
- либо для каждой учетки будут создаваться приватные группы, имя которой будут соответствовать его имени (более безопасный вариант. данная политика включена по умолчанию в Astra

**Типы пользователей**
- Суперпользователь - root, папка /root, UID=0. В астре пароль для root не назначен и под ним нельзя войти в систему
- Обычные пользователи - UID с 1000 до 59999
- Системные пользователи - нужны для функционирования самой системы (UID/GID от 0 до 99) и некоторых служб (UID/GID от 100 до 999)

**Базы данных локальных пользователей:**
- `/etc/passwd` - юзеры. Доступен для записи только руту
- `/etc/shadow` - хэши паролей для юзеров. Доступен для чтения только руту
- `/etc/group` - группы. Доступен для записи только руту
- `/etc/gshadow` - хэши паролей для групп. Доступен для чтения только руту
- `etc/sudoers` - хранит админов.
### Команды в astra

- `useradd`, `usermod`, `userdel`
- `groupadd`, `groupmod`, `groupdel`
- `id localadmin` - позволяет проверить существование пользователя
- `useradd` по умолчанию не создает домашний каталог, нужно указать опцию `-m`
- `passwd` - утилита работы с паролями
- `chage`
- `gpasswd` - утилита работы с паролями групп

`/etc/login.defs` - настройки по умолчанию, которые исполшьзуются данными утилитами
`/etc/default/useradd` - настройки по умолчанию, которые исполшьзуются данными утилитами
`/etc/skel` - отсюда по умолчанию все копируется в домашнюю папку юзера при создании

Астра поддерживает также: `adduser`, `addgroup`, `deluser`, `delgroup`. Настройки по умолчанию находятся в `/etc/adduser.conf`, `/etc/deluser.conf`. Это по сути perl-скрипты над useradd,...

Другие утилиты
- `chsh -s интерпретатор` - смена интерпретатора для пользователя
- `chfn` - изменение комментария в etc/passwd
- `su имя_пользователя` - переключение пользователя. Не инициализирует переменные окружения указанного пользователя.
- `su - имя_пользователя` - переключение пользователя. Инициализирует переменные окружения указанного пользователя.
- `sudo -i` - переключения на рута
- `lslogins` - вывод списка учеток

### Настройки окружения

- Системные настройки:
  - /etc/profile
    - /etc/bash.bashrc
      - /etc/profile.d -> bash_completion.sh
        - Пользовательские настройки:
          - ~/.profile
          - ~/.bashrc -> ~/.bash_aliases

### Рабочий стол

`.desktop` - соглашение именования для ярлыков. Ярлыки приложений в `/usr/share/applications`

`/usr/share/fly-wm` - настройки рабочего стола для нового пользователя

`~/.fly` - текущие настройки рабочего стола

### PAM - plugged authentificathion modules

Приложения через API обращаются к PAM framework, который настраивается черз PAM configuration. PAM framework через SPI (сокет) обращается к низкоуровневым модулям PAM modules (pam_auth.so - аутентификация пользователей, account.so - проверка возможности доступа к учетке, session.so - настройка и управление сессией, password.so - смена пароля).

`/etc/pam.d` - настройки

`man -k pam_` - выведет перечень pam модулей в системе

www.linux-pam.org

## Дискреционное управление доступом

`stat file_name` - информация о файле, кто владелец, какая группа, какие права

**Для файлов права:**  
r (4) - чтение содержимого  
w (2) - изменение содержимого  
x (1) - выполнение файла  

**Для каталогов права:**
r (4) - список файлов  
w (2) - создание удаление файла в каталоге  
x (1) - позволяет зайти в каталог  

**Спецбиты:**
- SUID (4) - выполнение с правами владельца файла
- SGID (2) - выполнение с правами главной группы файла
- Sticky bit (1) - назначается для общих папок. Все юзеры смогут создавать файлы в папке, а удалять только владельцы.

Спецбиты игнорируются для bash-скриптов.

Утилиты:
- `cmmod`
- `chown` - изменение владельца. Может делать только суперюзер
- `chgrp` - изменение главной группы. Без суперюзера можно менять, если мы владелец файла и входим в назначаемую группу
- `umask` - задает назначаемые права по умолчанию для текущего пользователя. Значения не в обычной восьмиричной системе (надо гуглить)

- `chmod 5743 file` - назначает права: SUID, Sticky bit, rwx - для владельца, r - для главной группы, wx - для всех остальных пользователей
- `chmod u=srwx file` - назначает права: SUID и rwx - для владельца
- `chmod +t dir -R` - назначает Sticky bit для директории. Еще и рекурсивно к подпапкам

### Список управления доступом ACL

**ACL для пользователя** 
user:имя_пользователя:права

**ACL для группы** 
group:имя_группы:права

**Маска (шаблон)** 
mask:права

- `getfacl file_name`
- `setfacl [m][x][b] file_name`

Если acl назначен, то в выводе ls -l будет значок `+` в конце прав

- `setfacl -m u:user_name:rw file_name` - Назначаем права для пользователя.
- `setfacl g:group_name:x -d dir_name` - Назначаем права для групп. Флаг d говорит назначить права всем файлам и папкам внутри.

chmod права также записываются в acl лист

### Атрибуты файлов

Атрибуты могут запретить делать какие-то действия даже руту. Только рут имеет право их назначать

`sudo lsattr file` - вывод всех атрибутов файла  
`sudo chattr [attr] file` - назначение атрибутов файлу

Атрибуты:
- `a` - файл может быть открыт только в режиме добавления;
- `A` - не обновлять время перезаписи;
- `c` - автоматически сжимать при записи на диск;
- `C` - отключить копирование при записи;
- `D` - работает только для папки, когда установлен, все изменения синхронно записываются на диск сразу же;
- `e` - использовать extent'ы блоков для хранения файла;
- `i` - сделать неизменяемым;
- `j` - все данные перед записью в файл будут записаны в журнал;
- `s` - безопасное удаление с последующей перезаписью нулями;
- `S` - синхронное обновление, изменения файлов с этим атрибутом будут сразу же записаны на диск;
- `t` - файлы с этим атрибутом не будут хранится в отдельных блоках;
- `u` - содержимое файлов с этим атрибутом не будет удалено при удалении самого файла и потом может быть восстановлено.

Самые важные атрибуты: `i` - нельзя изменить/удалить и `a` - можно только добавлять данные, но не удалять старые

## Мандатное управление доступом

https://astralinux.ru/upload/iblock/892/b2sd5bkijmbmyzptzipsbyd7ffs3njas.pdf
https://wiki.astralinux.ru/pages/viewpage.action?pageId=153486002&src=contextnavpagetreemode

0 Базовый режим (Орел) - ОС + дискреционное управление доступом (chmod, acl). SELinux и AppArmor исключены из дистрибутива.
1 Усиленный режим (Воронеж) - добавлен мандатный контроль целостности, зпс ("КИОСК"). ЗПС Киоск - адаптированный docker, происходит изоляция приложений.
2 Максимальный режим (Смоленск) - добавлен мандатный контроль доступа

Файл /etc/astra_license - содержит информацию о режиме защищенности

### Мандатоый контроль целостности (Mandatory integrity level) 

Модуль МКЦ подключается при установке ОС. Если забыли то можно включить:

`sudo astra-strictmode-control enable` - включение МКЦ.

`astra-mic-control` - включение/выключение механизма контроля целостности в ядре.

Отключить МКЦ командой - нельзя. Нужно сменить уровень защищенности ОС на Базовый, а потом вернуть обратно.

До 2018 года использовался только неирархический уровень. Максимальный неирархический уровень (max_ilev) -63 (На самом деле 255).
Возможность применять иерархический (линейный) уровнем целостности есть, но не применяется пока.

По умолчанию 6 уровней:
0 - Нулевой уровень
1 - сетевые службы
2 - виртуализация
4 - СПО
8 - графический сервер
16 - Резерв (СУБД)
32 - Резерв (сетевые службы)

Соответственно сумма, а значит максимальный уровень = 63.

64 - резерв под max_ilev
124 - резерв под max_ilev

При запуске системы мы можем выбрать либо  0 (Низкий), либо 63 (Максимальный). Этот уровень назначется для корневого процесса сессии.
Обычные пользователи работают с уровнем целостности - 0. Администраторы - 63.

Уровень целостности сущности. отражает степень уверенности в целостности содержащейся в ней информации.

Уровень целостности субъекта соответствует его полномочиям по доступу к сущности в зависимости от их уровней целостности, а также отражат степень уверенности в корректности его функциональности.

Пользователь с уровнем МКЦ 0 может видеть файлы и компоненты с уровнем 63, но изменять не может.

### Мандатоый контроль доступа

`astra-mac-control` - включение/выключение механизма мандатного контроля доступа

- Субъект доступа - тот, кто запрашивает доступ
- Сущность (объект) - то, к чему запрашывается доступ
- Контейнер - структурированная сущность (объект), которая может содержать другие сущности (объекты) доступа (т.е. каталог файловой системы).

Субъектам и объектам присваиваются:
- Иерархический уровень конфиденциальности. Субъект с высоким уровнем имеет доступ к объектам такого же уровня и ниже.
- Неирархическая категория конфиденцияальности. Раздаление доступа по категориям, а не по уровням. Программисты имеют доступ к одной информации, проектировщики к другой.
- Уровень целостности
- Дополнительные мандатные атрибуты

Субъекты с низким уровнем не могут читать объекты с более высоким уровнем. 

Только суперпользователь может назначать уровни доступа

### Parsec

Мандатный доступ реализован на модуле ядра parsec.ko.
Модуль parsec-cifs.ko - реализует мандатный доступ для CIFS

/etc/parsecfs - настройки

/parsecfs/version - версия парсека

man capabilities - привилегии в дебиан

1. Каждому объекту назначается метка безопасности (мандатная метка).
2. Каждой учетной записи назначаются допустимые уровни мандатного доступа
3. При входе в систему пользователь выбирает мандатный уровень для своего сеанса.

### Метка безопасности

Метка безопасности состоит из:
1) метка конфиденциальности, которая определяется:
  а) иерархическим уровнем конфиденциальности;
  б) неиерархическими категориями конфиденциальности;
2) метки целостности, которая определяется:
   а) иерархическим (линейным) уровнем целостности;
   б) неиерархическим уровнем (категорией) целостности.

Классификационные метки вложенных сущностей не могут превышать значения классификационной метки их содержащего контейнера.

Дочерний процесс полностью наследует метку безопасности родительского процесса.

### Дополнительные мандатные атрибуты

**Для каталогов:**
- ccnr - каталог может содержать файлы и каталогами с различными метками конфиденциальности, но не большими, чем его собственный.
- ccnri - устарел, каталог может содержать файлы и каталогами с различными метками целостности, но не большими, чем его собственный
- ccnra =ccnr+ccnri (с версии 1.7 = ccnr)

**Для файлов**
- ehole - файл, имеющий минимальную метку конфиденциальности, игнорирует правила МРД к нему, и процессы не могут прочитать данные, записанные в такие файлы (/dev/null)
- whole - файл, имеющий максимальную метку конфиденциальности, игнорирует правила МРД к нему, и разрешает процессам с более низкой меткой записывать в них

### Утилиты управления привилегиями

- `fly-admin-smc` - утилита управления политиками безопасности
- `userlev` - просмотр и определение доступных в системе уровней доступа. /etc/parsec/mac_levels - место хранение уровней доступа
- `usercat` - просмотр и определение доступных в системе категорий. /etc/parsec/mac_categories - место хранение категорий доступа
- `pdpl-file` - просмотр и задание меток и атрибутов безопасности
- `pdp-ls -M`  - просмотр меток безопасности. Поддерживает все опции ls
- `pdpl-user`
- `pdp-exec`
- `pdp-id`
- `pdpl-ps`
- `fly-fm` - графический файловый менеджер

PARSEC привилегии
usercaps - привилегии для пользователей
execaps
/etc/parsec/capabilities

### Изменение уровней конфиденциальности

По умолчанию 3 уровня конфиденциальности. Для изменения:
1. В скрипте /usr/sbin/pdp-init-fs установить значение переменной sysmaxlev равное новому максимальному значению уровня
2. Выполнить скрипт /usr/sbin/pdp-init-fs

### Практика уровни целостности

mkdir /home/mrd
pdpl-file 0:63:0:0 /home/mrd - назначили уровень целостности 63 для папки
pdp-ls -Md /home/mrd
mkdir /home/mrd/mrd0
mkdir /home/mrd/mrd63
pdp-ls -Md /home/mrd
pdpl-file 0:63:0:0 /home/mrd/mrd63
chmod 777 /home/mrd/ -R
pdp-ls -Md /home/mrd
touch /home/mrd/mrd63/file63
touch /home/mrd/mrd0/file0
pdpl-file 0:63:0:0 /home/mrd/mrd63/file63
pdpl-file 0:63:0:0 /home/mrd/mrd0/file0 - выдаст ошибку
chmod 666 /home/mrd/mrd0 -R
chmod 666 /home/mrd/mrd63 -R

### Практика уровни конфиденциальности

useradd -m -s /bin/bash ivanov
passwd ivanov
pdpl-user -l 0:3 ivanov - назначили пользователю доступ к уровням от 0 до 3.
mkdir /home/ivanov/project
pdpl-file 3:0:0:0 /home/ivanov/project - назначили уровень конфиденциальности 3 для папки
mkdir /home/ivanov/project/not_secret
pdpl-file 0:0:0:0 /home/ivanov/project/not_secret - ошибка доступа: нельзя в папке с высоким уровнем создавать объекты с более низким уровнем
su ivanov

### Итог

Контекст безопасности:
- Метка безопасности:
  -  Метки конфиденциальности = Уровень конфиденциальности (0...255) + Категория конфиденциальности(0...64)
  -  Метки целостности (0...255)
- Дополнительная мандатные атрибуты: ccnr, ehole, whole и привилегии субъектов (РУСБ.10015-01 97 01-1)

## Архивация и сжатие данных

### Архивация

Архивацией занимается утилита tar.

- `-с `- создать новый архив
- `-м` - подробный вывод
- `-f` name.tar - указать имя архива
- `-t` вывод списка содержимого архива
- `-x` - извлечение из архива
- `-h` - следовать за символическими ссылками
- `--acls` сохранение восстановление списков управление доступом
- `--xattrs` - сохранение восстановление расширенных атрибутов файлов
- `-z` - использовать gzip для сжатия
- `-j` - использовать bzip
- `-J` - использовать xz

### Сжатие 

.gz (самый быстрый): gzip, gunzip, zcat
.bz2: bzip2 , bunzip2, bzcat
.xz (самое сжатое): xz, unxz, xzcat
.zip: zip, unzip

По умолчанию заменяет оригинал

### Клонирование

dd - клонирует диски

dd if=/dev/sdb of=sdb.img status=progress
dd if=/dev/zero of=/home/zero.img bs=1G count=2 status=progress

### rsync

Синхронизация изменений.

По умолчанию пакет не установлен: `sudo apt install rsync`.

Если имя каталога-источника не заканчивается символом косая черта, то копируется сам каталог и его содержимое, иначе - только содержимое.

