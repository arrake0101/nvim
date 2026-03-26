def scale(value, factor):
    result = value * factor
    return result


def main():
    total = 0
    values = [2, 4, 6, 8]

    for index, value in enumerate(values, start=1):
        scaled = scale(value, index)
        total += scaled
        print(f"index={index}, value={value}, scaled={scaled}, total={total}")

    status = {
        "count": len(values),
        "total": total,
        "average": total / len(values),
    }

    print(f"done: {status}")


if __name__ == "__main__":
    main()
