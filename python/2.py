def decomp(n):
    dict = {}
    for i in range(2, n+1):
        k = 2
        while i > 1:
            while i % k == 0:
                # если ключа нет в словаре, то добавим его вместе с значением 0. если есть, то увеличим его значение на 1
                dict.setdefault(k,0)
                dict[k] += 1
                i //= k
            k += 1
    lis = []
    # сортируем словарь
    for k in sorted(dict.keys()):
        # если значение ключа словаря = 1, т.е. степень = 1, то сохраняем в список только ключ
        if dict[k] == 1:
            lis.append(f'{k}')
        # если есть степень, то сохраняем ключ и его значение в виде 2^3
        else:
            lis.append(f'{k}^{dict[k]}')
    # преобразуем в строку и выводим результат
    result = ' * '.join(lis)
    print(result)
    return result

n = input('Введите число n: ')
try:
    # проверяем ввёл ли пользователь число
    if int(n):
        decomp(int(n))
except:
    print('Вы ввели не число!')