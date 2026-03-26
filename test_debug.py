"""Simple introduction to Python class syntax."""


class Person:
    """A basic class with a class attribute and instance methods."""

    species = "Human"

    def __init__(self, name, age):
        self.name = name
        self.age = age

    def introduce(self):
        return f"My name is {self.name}, and I am {self.age} years old."

    def have_birthday(self):
        self.age += 1
        return f"Happy birthday, {self.name}! You are now {self.age}."


class Student(Person):
    """Student inherits from Person and adds a new attribute."""

    def __init__(self, name, age, grade):
        super().__init__(name, age)
        self.grade = grade

    def study(self, subject):
        return f"{self.name} is studying {subject}."

    def introduce(self):
        base_text = super().introduce()
        return f"{base_text} I am in grade {self.grade}."


def main():
    print("Python class syntax introduction")
    print("-" * 40)

    person = Person("Alice", 20)
    print("Class attribute:", Person.species)
    print("Instance attribute:", person.name, person.age)
    print("Instance method:", person.introduce())
    print("Update instance state:", person.have_birthday())

    print("-" * 40)

    student = Student("Bob", 16, 10)
    print("Inherited class attribute:", student.species)
    print("Overridden method:", student.introduce())
    print("New subclass method:", student.study("Python"))


if __name__ == "__main__":
    main()
