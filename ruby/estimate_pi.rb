ITERATIONS = 100_000_000

in_sector_hits = 0

ITERATIONS.times.each do
  x, y = rand, rand

  # найдём длину отрезка
  z = Math.sqrt(x ** 2 + y ** 2)

  in_sector_hits += 1 if z <= 1
end

# Вероятность попадания в сектор 1/4 окружности с радиусом 1
p_in_sector = in_sector_hits.to_f / ITERATIONS

# Оценка pi
pi = 4 * p_in_sector

puts "Оценка числа pi = #{pi} после #{ITERATIONS} итераций"
