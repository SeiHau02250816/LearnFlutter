import 'package:ecommerce/models/shoe.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  // List of shoes for sales
  List<Shoe> shoeShop = [
    Shoe(
      name: "Air Jordan",
      description: "ABC",
      price: 236,
      imagePath: "lib/pics/air-jordan.jpg",
    ),
    Shoe(
      name: "Nike Lunargato",
      description: "EFG",
      price: 309,
      imagePath: "lib/pics/NIKE+LUNARGATO.png",
    ),
    Shoe(
      name: "Pegasus",
      description: "HIJ",
      price: 399,
      imagePath: "lib/pics/pegasus.png",
    ),
    Shoe(
      name: "V2K Run",
      description: "KLM",
      price: 816,
      imagePath: "lib/pics/v2k_run.png",
    ),
  ];

  // List of items in user cart
  List<Shoe> userCart = [];

  // Get list of shoes for sales
  List<Shoe> getShoeList() {
    return shoeShop;
  }

  // Get cart
  List<Shoe> getUserCart() {
    return userCart;
  }

  // Add item to cart
  void addItemToCart(Shoe shoe) {
    userCart.add(shoe);
    notifyListeners();
  }

  // Remove item from cart
  void removeItemFromCart(Shoe shoe) {
    userCart.remove(shoe);
    notifyListeners();
  }
}
