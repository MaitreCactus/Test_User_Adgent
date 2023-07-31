import 'package:flutter/material.dart';
import '../model/Burger.dart';
import '../model/CartItem.dart';

class CartViewModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;


  void addItem(Burger burger) {
    CartItem? item;

    for (CartItem element in _items) {
      if (element.burger == burger) {
        item = element;
        break;
      }
    }

    if (item == null) {
      item = CartItem(burger: burger);
      _items.add(item);
    }

    item.quantity++;

    burger.nbrBurger++;
    notifyListeners();
  }


  void removeItem(Burger burger) {
    for (CartItem item in _items) {
      if (item.burger == burger && item.quantity > 0) {
        item.quantity--;
        burger.nbrBurger--;
        if (item.quantity == 0) {
          _items.remove(item);
        }
        notifyListeners();
        return;
      }
    }
  }



  double get total {
    return _items.fold(0.0, (total, item) => total + (item.quantity * item.burger.priceFormatted!));
  }




}
