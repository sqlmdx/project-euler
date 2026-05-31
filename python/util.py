import time

def time_it_decorator(func):
    def wrapper(*args, **kwargs):
        t0 = time.perf_counter()
        result = func(*args, **kwargs)
        t1 = time.perf_counter()
        print(f"{func.__name__} took {t1 - t0:.2f}s")
        return result
    return wrapper

def time_it(func, *args, **kwargs):
    t0 = time.perf_counter()
    result = func(*args, **kwargs)
    t1 = time.perf_counter()
    print(f"Elapsed time: {t1 - t0:.2f}s")
    return result