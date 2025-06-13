import Foundation

let count = 100_000_000


func d_rand() {
  var inSector = 0
  for _ in 0..<count {
      let x = drand48()
      let y = drand48()

      let z = sqrt(pow(x,2) + pow(y,2))

      if z <= 1 {
          inSector += 1
      }
  }

  let pInSector = Double(inSector) / Double(count)
  let piEstimate = 4 * pInSector

  print("Оценка pi = \(piEstimate)")
}

d_rand()
