import 'Animal.dart';
import 'Cat.dart';
import 'Dog.dart';

void main() {
  Cat cat1 = Cat('Cat', 2);
  // cat1.meow();
  // cat1.sleep();

  Dog dog1 = Dog('Sushi', 3);
  // dog1.bark();
  // dog1.sleep();

  List<Animal> animals = [];

  animals.add(cat1);
  animals.add(dog1);

  Animal firstAnimal = animals.first;

  if (firstAnimal is Dog) {
    firstAnimal.bark();
  } else if (firstAnimal is Cat) {
    firstAnimal.meow();
  }

  print(cat1);
  print(dog1);

  cat1.die();
  cat1.die();
  cat1.die();
  cat1.die();
  cat1.die();
  cat1.die();
  cat1.die();
}
