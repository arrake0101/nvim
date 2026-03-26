class NumberRunner:
    def __init__(self, numbers):
        self.numbers = numbers
        self.total = 0

    def run(self):
        for index, value in enumerate(self.numbers, start=1):
            doubled = value * 2
            self.total = self.total + doubled

            if doubled % 4 == 0:
                label = "multiple-of-4"
            else:
                label = "other"

            print(
                "loop",
                index,
                "value",
                value,
                "doubled",
                doubled,
                "label",
                label,
                "total",
                self.total,
            )

        return self.total


def safe_divide(left, right):
    try:
        return left / right
    except ZeroDivisionError:
        return None


def summarize(total, count):
    average = safe_divide(total, count)

    if average is None:
        status = "invalid"
    elif average > 4:
        status = "large"
    else:
        status = "small"

    return {
        "sum": total,
        "average": average,
        "status": status,
    }


def main():
    numbers = [1, 2, 3, 4]
    runner = NumberRunner(numbers)
    total = runner.run()

    result = summarize(total, len(numbers))
    print("summary", result)

    empty_result = summarize(10, 0)
    print("empty_result", empty_result)


if __name__ == "__main__":
    main()

