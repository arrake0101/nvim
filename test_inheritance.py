"""Simple introduction to Python inheritance, overriding, and polymorphism."""

from __future__ import annotations


class Animal:
    """Parent class: shared attributes and methods live here."""

    kingdom = "Animalia"

    def __init__(self, name: str, age: int) -> None:
        if age < 0:
            raise ValueError("age must be non-negative")
        self.name = name
        self.age = age
        self.energy = 50

    def describe(self) -> str:
        return f"{self.name} is {self.age} years old and has {self.energy} energy."

    def speak(self) -> str:
        return f"{self.name} makes a sound."

    def move(self) -> str:
        return f"{self.name} moves around."

    def celebrate_birthday(self) -> str:
        self.age += 1
        return f"Happy birthday, {self.name}! Age is now {self.age}."

    def eat(self, food: str, energy_gain: int = 10) -> str:
        self.energy += energy_gain
        return f"{self.name} eats {food} and now has {self.energy} energy."


class Dog(Animal):
    """Dog inherits from Animal and adds its own data and behavior."""

    def __init__(self, name: str, age: int, breed: str, trained: bool = False) -> None:
        super().__init__(name, age)
        self.breed = breed
        self.trained = trained

    def describe(self) -> str:
        base_text = super().describe()
        trained_text = "trained" if self.trained else "still learning"
        return f"{base_text} Breed: {self.breed}. Status: {trained_text}."

    def speak(self) -> str:
        return f"{self.name} barks."

    def fetch(self, item: str) -> str:
        self.energy = max(0, self.energy - 8)
        return f"{self.name} is fetching the {item}. Energy is now {self.energy}."

    def train(self) -> str:
        self.trained = True
        return f"{self.name} learned a new trick."


class Cat(Animal):
    """Cat also inherits from Animal and overrides parent methods."""

    def __init__(self, name: str, age: int, indoor: bool = True) -> None:
        super().__init__(name, age)
        self.indoor = indoor
        self.lives_left = 9

    def describe(self) -> str:
        base_text = super().describe()
        lifestyle = "indoor" if self.indoor else "outdoor"
        return f"{base_text} Lifestyle: {lifestyle}. Lives left: {self.lives_left}."

    def speak(self) -> str:
        return f"{self.name} meows."

    def move(self) -> str:
        return f"{self.name} walks quietly."

    def scratch(self) -> str:
        return f"{self.name} is scratching the sofa."

    def nap(self) -> str:
        self.energy += 12
        return f"{self.name} takes a nap and restores energy to {self.energy}."


class Bird(Animal):
    """Bird is another subclass with its own movement and custom method."""

    def __init__(self, name: str, age: int, wing_span_cm: int) -> None:
        super().__init__(name, age)
        self.wing_span_cm = wing_span_cm

    def describe(self) -> str:
        base_text = super().describe()
        return f"{base_text} Wing span: {self.wing_span_cm} cm."

    def speak(self) -> str:
        return f"{self.name} chirps."

    def move(self) -> str:
        return f"{self.name} flies across the sky."

    def fly(self, distance_km: float) -> str:
        energy_cost = max(1, int(distance_km * 6))
        self.energy = max(0, self.energy - energy_cost)
        return (
            f"{self.name} flies {distance_km:.1f} km and now has "
            f"{self.energy} energy."
        )


class AnimalShelter:
    """Manage multiple Animal objects and operate on them polymorphically."""

    def __init__(self) -> None:
        self.animals: list[Animal] = []

    def add_animal(self, animal: Animal) -> None:
        self.animals.append(animal)

    def feed_all(self, food: str) -> list[str]:
        return [animal.eat(food) for animal in self.animals]

    def count_by_type(self) -> dict[str, int]:
        counts: dict[str, int] = {}
        for animal in self.animals:
            animal_type = animal.__class__.__name__
            counts[animal_type] = counts.get(animal_type, 0) + 1
        return counts

    def oldest_animal(self) -> Animal | None:
        if not self.animals:
            return None
        return max(self.animals, key=lambda animal: animal.age)


def introduce_animals(animals: list[Animal]) -> None:
    """Show polymorphism: the same method call behaves differently per subclass."""

    for animal in animals:
        print(f"{animal.__class__.__name__}: {animal.describe()}")
        print("  speak ->", animal.speak())
        print("  move  ->", animal.move())


def show_unique_behaviors(dog: Dog, cat: Cat, bird: Bird) -> None:
    """Demonstrate behavior that only exists on specific subclasses."""

    print("Dog custom method:", dog.fetch("ball"))
    print("Dog training:", dog.train())
    print("Cat custom method:", cat.scratch())
    print("Cat recovery:", cat.nap())
    print("Bird custom method:", bird.fly(2.5))


def main() -> None:
    print("Python inheritance syntax")
    print("-" * 40)
    print("1. class Dog(Animal): Dog inherits from Animal")
    print("2. super().__init__(...): reuse parent initialization")
    print("3. describe()/speak()/move(): subclasses can override methods")
    print("4. fetch()/scratch()/fly(): subclass-only methods")
    print("5. list[Animal] and AnimalShelter: demonstrate polymorphism")
    print("-" * 40)

    animal = Animal("Generic Animal", 5)
    dog = Dog("Buddy", 3, "Golden Retriever")
    cat = Cat("Mimi", 2)
    bird = Bird("Kiwi", 1, 35)
    shelter = AnimalShelter()

    for current_animal in [animal, dog, cat, bird]:
        shelter.add_animal(current_animal)

    print("Parent method:", animal.speak())
    print("Dog override:", dog.speak())
    print("Cat override:", cat.speak())
    print("Bird override:", bird.speak())
    print("Dog breed:", dog.breed)
    print("Class attribute:", Animal.kingdom)
    print("isinstance(dog, Animal):", isinstance(dog, Animal))
    print("issubclass(Dog, Animal):", issubclass(Dog, Animal))
    print("State change:", animal.celebrate_birthday())
    print("Shared method:", dog.eat("biscuits"))

    print("-" * 40)
    introduce_animals(shelter.animals)

    print("-" * 40)
    show_unique_behaviors(dog, cat, bird)

    print("-" * 40)
    print("Shelter counts:", shelter.count_by_type())
    oldest = shelter.oldest_animal()
    if oldest is not None:
        print("Oldest animal:", oldest.name, f"({oldest.age} years old)")
    print("Feed everyone:")
    for result in shelter.feed_all("lunch"):
        print(" ", result)


if __name__ == "__main__":
    main()
