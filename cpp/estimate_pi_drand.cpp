#include <iostream>
#include <cmath>
#include <cstdlib>
#include <ctime>

int main() {
    const long count = 100'000'000;
    int inSector = 0;

    // Инициализация генератора drand48
    srand48(time(nullptr));

    for (long i = 0; i < count; ++i) {
        double x = drand48();
        double y = drand48();

        if (std::sqrt(x * x + y * y) <= 1.0) {
            ++inSector;
        }
    }

    double pi = 4.0 * static_cast<double>(inSector) / static_cast<double>(count);
    std::cout << "pi: " << pi << std::endl;

    return 0;
}
