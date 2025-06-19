from euler_lib import is_prime

for i in range(1001, 9999, 2):
    for j in range(2, (9999 - i) // 2, 2):
        if (sorted(str(i)) == sorted(str(i+j)) and sorted(str(i)) == sorted(str(i+j+j))
            and is_prime(i) and is_prime(i+j) and is_prime(i+j+j) and i != 1487):
            print(f'{i}{i+j}{i+j+j}')