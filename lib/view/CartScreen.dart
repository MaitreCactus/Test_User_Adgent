import 'package:big_burger/widgets/PlatformButton.dart';
import 'package:big_burger/widgets/PlatformScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModel/CartViewModel.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      iosAppBar: const CupertinoNavigationBar(
        middle: Text('Cart'),
      ),
      androidAppBar: AppBar(
        title: Text('Cart'),
      ),
      body: Consumer<CartViewModel>(
        builder: (context, cartViewModel, child) {
          return Stack(
            children: [
              if (cartViewModel.items.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: cartViewModel.items.length,
                    itemBuilder: (context, index) {
                      final item = cartViewModel.items[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  item.burger.thumbnail.toString(),
                                  height: 80,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.burger.title!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      '${item.burger.priceFormatted} x ${item.quantity}',
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        PlatformButton(
                                          onPressed: () {
                                            cartViewModel.addItem(item.burger);
                                            item.burger.nbrBurger =
                                            item.burger.nbrBurger != null
                                                ? item.burger.nbrBurger! + 1
                                                : 1;
                                          },
                                          color: Colors.green,
                                          child: const Icon(Icons.add_shopping_cart),
                                        ),
                                        PlatformButton(
                                          onPressed: () {
                                            cartViewModel.removeItem(item.burger);
                                            if (item.burger.nbrBurger != null &&
                                                item.burger.nbrBurger! > 0) {
                                              item.burger.nbrBurger = item.burger.nbrBurger! - 1;
                                            }
                                          },
                                          color: Colors.red,
                                          child: const Icon(Icons.remove_shopping_cart),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              if (cartViewModel.items.isEmpty)
                 Center(
                  child: Text(
                    'Votre panier est vide. Ajoutez des burgers!',
                    style: GoogleFonts.aboreto(decoration: TextDecoration.none),
                    textAlign: TextAlign.center,
                  ),
                ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Card(
                  color: Colors.white,
                  elevation: 8.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${cartViewModel.total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
