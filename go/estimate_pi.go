package main

import (
 "fmt"
 "math"
 "math/rand"
 "time"
)

func main() {
 count := 100_000_000
 inSector := 0

 // Инициализация генератора случайных чисел
 rand.Seed(time.Now().UnixNano())

 for i := 0; i < count; i++ {
  x := rand.Float64()
  y := rand.Float64()
  // Условие с корнем
  if math.Sqrt(x*x+y*y) <= 1.0 {
   inSector++
  }
 }

 pi := 4.0 * float64(inSector) / float64(count)
 fmt.Printf("pi: %f\n", pi)
}
