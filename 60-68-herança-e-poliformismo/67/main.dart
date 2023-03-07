import 'Car.dart';
import 'Fridge.dart';
import 'Inanimate.dart';
import 'Mobile.dart';
import 'Person.dart';

void main() {
  Mobile mobile1 = Person();
  mobile1.goUp();
  mobile1.goLeft();
  mobile1.goRight();

  Inanimate car1 = Car();

  Inanimate fridge1 = Fridge();

  print(car1.salePrice().toStringAsFixed(2));
  print(fridge1.salePrice().toStringAsFixed(2));
}
