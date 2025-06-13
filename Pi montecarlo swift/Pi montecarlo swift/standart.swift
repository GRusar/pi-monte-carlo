import Foundation

func standart() {
    var inSector = 0
    let count = 100_000_000

    for _ in 0..<count {
        let x = Double.random(in: 0...1)
        let y = Double.random(in: 0...1)

        let z = sqrt(pow(x,2) + pow(y,2))

        if z <= 1 {
            inSector += 1
        }
    }

    let pInSector = Double(inSector) / Double(count)
    let piEstimate = 4 * pInSector

    print("Оценка pi = \(piEstimate)")

}
