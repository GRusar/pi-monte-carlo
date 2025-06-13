import Foundation

func parallel() {
    let totalIterations = 100_000_000
    let numThreads = ProcessInfo.processInfo.activeProcessorCount
    let iterationsPerThread = totalIterations / numThreads

    let group = DispatchGroup()
    let lock = NSLock()
    var totalInCircle = 0

    for _ in 0..<numThreads {
        group.enter()
        DispatchQueue.global().async {
            var localCount = 0
            var rng = SystemRandomNumberGenerator()

            for _ in 0..<iterationsPerThread {
                let x = Double.random(in: 0...1, using: &rng)
                let y = Double.random(in: 0...1, using: &rng)
                if x * x + y * y <= 1 {
                    localCount += 1
                }
            }

            lock.lock()
            totalInCircle += localCount
            lock.unlock()

            group.leave()
        }
    }

    group.wait()

    let piEstimate = 4.0 * Double(totalInCircle) / Double(totalIterations)
    print("Оценка pi = \(piEstimate)")

}

parallel()