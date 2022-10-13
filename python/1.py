alphabet = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
# convert_str = 'zzzab'
convert_str = input('Введите строку для конвертации: ')

# функция для получения следующего символа алфавита
def get_next_symbol(symbol):
    try:
        # найдем позицию переданного символа
        i = alphabet.index(symbol)
        # если передали букву z - вернуть а, иначе следующую букву алфавита
        if i == 25:
            next_symbol = alphabet[0]
        else:
            next_symbol = alphabet[i+1]
        return next_symbol
    except Exception as Ex:
        return Ex

# создадим генератор для обхода элементов списка
def generator(n):
    try:
        for i in range(n):
            for j in range(i+1, n):
                yield i, j
    except Exception as Ex:
        return Ex

def main(convert_str):
    try:
        # проверяем, что передана строка, а не другой тип данных
        if isinstance(convert_str,str):
            # приводим к нижнему регистру и преобразуем строку в список
            convert_str=list(convert_str.lower())
            # переменная, указывающая на необходимость начать прохождение по циклу заново
            need_restart = True
            while need_restart:
                need_restart = False
                # сранение символов друг с другом.
                # сначала сравниваем первый символ со следующими. при нахождении совпадений первый символ заменяется, а второй удаляется. после этого цикл начинается заново. если первый символ не имеет повторений, то берется второй и т.д.
                for i, j in generator(len(convert_str)):
                    sym_1 = convert_str[i]
                    sym_2 = convert_str[j]
                    if sym_1 == sym_2:
                        # исключает перебора символов, не входящих в состав английского алфавита
                        if sym_1 and sym_2 in alphabet:
                            sym_1 = get_next_symbol(sym_1)
                            convert_str[i] = sym_1
                            convert_str.pop(j)
                            need_restart = True
                            break
            # преобразуем список в строку
            convert_str = ''.join(convert_str)
            print (f'Результат: {convert_str}')
        else:
            print ('Введите строку!')
    except Exception as Ex:
        return Ex

main(convert_str)