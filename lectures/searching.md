# Поиск

## grep

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

## find
