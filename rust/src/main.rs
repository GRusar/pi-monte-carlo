use rand::Rng;
use rand::rng;

fn main() {
    let count = 100_000_000;
    let mut rng = rng();
    let mut in_sector = 0;
    let mut x: f64;
    let mut y: f64;

    for _ in 0..count {
      x = rng.random_range(0.0..1.0);
      y = rng.random_range(0.0..1.0);

      if (x * x + y * y).sqrt() <= 1.0 {
        in_sector += 1;
      }
    }

    let pi: f64 = 4.0 * (in_sector as f64) / (count as f64);

    println!("pi: {pi}");
}
