import Foundation

func fast() {
    let count = 100_000_000
    var inSector: Double = 0

    var randomGenerator = SystemRandomNumberGenerator()

    for _ in 0..<count {
        let x = Double.random(in: 0...1, using: &randomGenerator)
        let y = Double.random(in: 0...1, using: &randomGenerator)
        
        let z = sqrt(x * x + y * y)
        if z <= 1 {
            inSector += 1
        }
    }

    let piEstimate = 4.0 * inSector / Double(count)
    print("Оценка pi = \(piEstimate)")
}
