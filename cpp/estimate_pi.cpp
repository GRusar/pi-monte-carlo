#include <iostream>
#include <random>
#include <cmath>

int main() {
    const long count = 100'000'000;
    int inSector = 0;

    // Инициализация 64-битного генератора случайных чисел
    std::random_device rd;
    std::mt19937_64 gen(rd());
    std::uniform_real_distribution<double> dist(0.0, 1.0);
    double x, y;

    for (long i = 0; i < count; ++i) {
        x = dist(gen);
        y = dist(gen);
        if (std::sqrt(x * x + y * y) <= 1.0) {
            ++inSector;
        }
    }

    double pi = 4.0 * static_cast<double>(inSector) / static_cast<double>(count);
    std::cout << "pi: " << pi << std::endl;

    return 0;
}
