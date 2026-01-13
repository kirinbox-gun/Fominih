a = input("Введи целое число: ")
if a.isdigit():
a = int(a)
b = (a*a)
print(f"Квадрат числа: {b}")
else: print(f"Неверный ввод.")