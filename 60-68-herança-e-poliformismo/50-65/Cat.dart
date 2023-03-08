import 'Animal.dart';

class Cat extends Animal {
  int lives = 7;

  Cat(String name, int age) : super(name, age) {
    print('Cat named $name created');
  }

  void meow() {
    print('$name said \'meow\'');
  }

  @override
  die() {
    if (lives == 0) {
      print('rip');
    } else {
      lives--;
      print('Remaining lives: $lives');
    }
  }

  @override
  String toString() {
    return 'Cat - Name: $name, age: $age';
  }
}
