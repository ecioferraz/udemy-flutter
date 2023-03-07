import 'Animal.dart';

class Dog extends Animal {
  Dog(String name, int age) : super(name, age) {
    print('Dog named $name created');
  }

  void bark() {
    print('$name said \'woof\'');
  }

  @override
  void sleep() {
    print('$name is snoring');
  }

  @override
  void die() {
    print('rip');
  }

  @override
  String toString() {
    return 'Dog - Name: $name, age: $age';
  }
}
