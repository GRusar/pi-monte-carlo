package main

import (
 "fmt"
 "math"
 "math/rand"
 "runtime"
 "sync"
 "time"
)

func main() {
 count := 100_000_000
 numCPU := runtime.NumCPU()
 iterationsPerWorker := count / numCPU

 var wg sync.WaitGroup
 wg.Add(numCPU)

 results := make(chan int, numCPU)

 for i := 0; i < numCPU; i++ {
  go func(seed int64) {
   defer wg.Done()
   r := rand.New(rand.NewSource(seed))
   localCount := 0
   for j := 0; j < iterationsPerWorker; j++ {
    x := r.Float64()
    y := r.Float64()
    if math.Sqrt(x*x+y*y) <= 1.0 {
     localCount++
    }
   }
   results <- localCount
  }(time.Now().UnixNano() + int64(i))
 }

 wg.Wait()
 close(results)

 totalInSector := 0
 for v := range results {
  totalInSector += v
 }

 remainder := count % numCPU
 for j := 0; j < remainder; j++ {
  x := rand.Float64()
  y := rand.Float64()
  if math.Sqrt(x*x+y*y) <= 1.0 {
   totalInSector++
  }
 }

 pi := 4.0 * float64(totalInSector) / float64(count)
 fmt.Printf("pi: %f\n", pi)
}
