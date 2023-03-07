abstract class Animal {
  String? name;
  int? age;

  Animal(this.name, this.age);

  void die();

  void eat() {
    print('Eating');
  }

  void sleep() {
    print('Sleeping');
  }

  @override
  String toString() {
    return 'Name: $name, age: $age';
  }
}
