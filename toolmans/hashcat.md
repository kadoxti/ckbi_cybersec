https://www.freecodecamp.org/news/hacking-with-hashcat-a-practical-guide/

`hashcat -m 100 -a 0 hash.txt rockyou.txt` - взалываем SHA1 (-m 100), перебором по словарю (-a 0), файл с хэшем (hash.txt), словарь (rockyou.txt) 
