select sum(power(i * 2 + 1, 2) * 4 - 6 * 2 * i) + 1 result
from generate_series(1, (1001 - 1) / 2) i;