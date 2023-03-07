import 'Inanimate.dart';
import 'Mobile.dart';

class Car implements Mobile, Inanimate {
  String? brand;

  @override
  void goLeft() {
    // TODO: implement goLeft
  }

  @override
  void goRight() {
    // TODO: implement goRight
  }

  @override
  void goUp() {
    // TODO: implement goUp
  }

  @override
  double salePrice() {
    return 50000;
  }
}
