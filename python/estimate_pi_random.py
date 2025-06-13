import math
import random

in_sector = 0
count = 100_000_000

for i in range(count):
  x = random.random()
  y = random.random()

  # найдём длину отрезка
  z = math.sqrt(x ** 2 + y ** 2)

  if z <= 1:
    in_sector += 1

# Вероятность попадания в сектор 1/4 окружности с радиусом 1
P_in_sector = in_sector / count

print("Оценка pi = ", 4 * P_in_sector)



