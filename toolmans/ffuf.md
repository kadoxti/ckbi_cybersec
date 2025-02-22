# FFUF

ffuf - аналог dirbuster. Фаззер.

## Определение типа страниц веб-сервера

`ffuf -w ./web-extensions.txt -u http://site.ru/indexFUZZ`

## Фаззинг страниц

`ffuf -w ./directory-list-2.3-big.txt -u http://site.ru/FUZZ` - использует словарь wordlist.txt, FUZZ - стандартный placeholder для фаззинга, в него будут записываться слова

## Фаззинг по POST

`ffuf -w ./wordlist.txt -u http://site.ru/ -d "login=FUZZ&password=qwerty"`


## Словари

https://github.com/danielmiessler/SecLists


https://habr.com/ru/companies/skillfactory/articles/810293/
