import 'package:ecommerce_flutter/models/shoe.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  List<Shoe> shoeShop = [
    Shoe(
      name: 'Air Jordan',
      price: '250',
      description:
          "asdfasdfkasjhdlfkjhalskdjfhlkasjdhflk kajshd flkhas j hsdkfhalsdkjfh lasdf ljh lkadhsf",
      imagePath: 'assets/images/nike4.webp',
    ),
    Shoe(
      name: 'Air Jordan 2',
      price: '260',
      description:
          'alsjdf ;klj ;sldkfj kj kja sdljf h kajsdhf h asjdhflkjh kjhasd f ljkh k',
      imagePath: 'assets/images/nike2.jpg',
    ),
    Shoe(
      name: 'Air Jordan 3',
      price: '270',
      description:
          'kajkjsadflk. kj l;kajs dflkj k jlkjsadh fkjh kjhads kfjh jklahds f',
      imagePath: 'assets/images/nike3.jpg',
    ),
    Shoe(
      name: 'Air Jordan 4',
      price: '280',
      description:
          'kjahsdklfj.  jkashdf jasd fkjasd hfljkhasdfjkhads. askjdhf alskjd f',
      imagePath: 'assets/images/nike1.jpg',
    ),
    Shoe(
      name: 'Air Jordan 5',
      price: '300',
      description:
          'kjahsdfk j asd fkhjk halskdjfhakjsdfhalsdjk fas dfjashd fljkahsdf lkjahsdf.',
      imagePath: 'assets/images/nike5.webp',
    ),
  ];

  List<Shoe> userCart = [];

  List<Shoe> getShoeList() {
    return shoeShop;
  }

  List<Shoe> getUserCart() {
    return userCart;
  }

  void addItemToCart(Shoe shoe) {
    userCart.add(shoe);
    notifyListeners();
  }

  void removeItemFromCart(Shoe shoe) {
    userCart.remove(shoe);
    notifyListeners();
  }
}
