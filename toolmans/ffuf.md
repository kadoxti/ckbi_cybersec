# FFUF

ffuf - аналог dirbuster. Фаззер.

## Определение типа страниц веб-сервера

`ffuf -w ./web-extensions.txt -u http://site.ru/indexFUZZ`

## Фаззинг страниц

`ffuf -w ./directory-list-2.3-big.txt -u http://site.ru/FUZZ` - использует словарь wordlist.txt, FUZZ - стандартный placeholder для фаззинга, в него будут записываться слова

## Фаззинг по POST

`ffuf -w ./wordlist.txt -u http://site.ru/ -d "login=FUZZ&password=qwerty"`
`ffuf -w [wordlist path] -X POST -d "username=admin&password=FUZZ" -u [target ip]`

## Фаззинг json

`ffuf -w [wodlist path] -X "PUT" -u [target ip] -H "Content-Type: application/json" -d "{'FUZZ':'test'}"`

## Другие опции

`-recursion`

`ffuf -u [target ip]/FUZZ -w [wordlist path] -e .php` - добавляет в пути .php

## Словари

https://github.com/danielmiessler/SecLists

[Intruder/detect/Generic_SQLI.txt](https://github.com/payloadbox/sql-injection-payload-list/blob/6e55457963a04377b904a93a6a65bb49dfe7bccb/Intruder/detect/Generic_SQLI.txt)

https://github.com/josuamarcelc/common-password-list
https://raw.githubusercontent.com/v0re/dirb/master/wordlists/common.txt

https://habr.com/ru/companies/skillfactory/articles/810293/
