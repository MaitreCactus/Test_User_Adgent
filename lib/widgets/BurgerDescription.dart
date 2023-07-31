import 'dart:io';
import 'package:big_burger/widgets/PlatformButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/Burger.dart';
import '../viewModel/CartViewModel.dart';
import 'BtnAddRemoveItem.dart';

// La classe BurgerDescription affiche une page détaillée d'information sur un burger
class BurgerDescription extends StatelessWidget {
  // On reçoit un objet Burger à afficher
  final Burger burger;

  // Constructeur de la classe BurgerDescription
  const BurgerDescription(this.burger, {super.key});

  // La fonction build sert à construire l'interface utilisateur de cette page
  @override
  Widget build(BuildContext context) {
    // On utilise un GestureDetector pour permettre à l'utilisateur de fermer la page en la faisant glisser vers le bas
    return GestureDetector(
      // Si la page est glissée vers le bas, on ferme la page
      onVerticalDragEnd: (detail) {
        if (detail.primaryVelocity! > 0) {
          Navigator.pop(context);
        }
      },
      // Le contenu principal de la page est dans un Container
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 20, right: 20),
        margin:  EdgeInsets.only(top: Platform.isIOS? MediaQuery.of(context).size.height*0.1:0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: CupertinoColors.white),
        child: body(context),
      ),
    );
  }

  // La fonction body sert à construire le contenu principal de la page
  Widget body(BuildContext context) {

    // Formater le prix pour la locale actuelle
    final formattedPrice = NumberFormat.currency(locale: Localizations.localeOf(context).toString()).format(burger.priceFormatted);
    final currencySymbol = NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).toString()).currencySymbol;
    final priceWithCurrencySymbol = "$formattedPrice $currencySymbol";

    // Le contenu de la page est une liste verticale de widgets
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        // Un bouton pour fermer la page
        back(context),
        // Une image du burger
        Image.network(burger.thumbnail.toString(),
            fit: BoxFit.cover, height: 80),
        // Des espacements entre chaque élément
        SizedBox(height: Platform.isIOS? MediaQuery.of(context).size.height*0.03:MediaQuery.of(context).size.height*0.01),
        // Le titre du burger
        Text(burger.title.toString()),
        SizedBox(height:Platform.isIOS? MediaQuery.of(context).size.height*0.03:MediaQuery.of(context).size.height*0.01),
        // La description du burger
        Text(burger.description.toString()),
        // Un autre espacement
        SizedBox(height:Platform.isIOS? MediaQuery.of(context).size.height*0.06:MediaQuery.of(context).size.height*0.01),
        // Le prix du burger avec son symbole de devise
        Text(
          priceWithCurrencySymbol,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.green,
          ),
        ),
        // Un autre espacement
        SizedBox(height:Platform.isIOS? MediaQuery.of(context).size.height*0.06:MediaQuery.of(context).size.height*0.03),
        // Afficher le nombre de ce burger dans le panier et le total du panier
        Consumer<CartViewModel>(
            builder: (context, cartViewModel, child) {
              return Column(
                children: [
                  // Le nombre de ce burger dans le panier
                  Text(burger.nbrBurger.toString()),
                  // Le total du panier
                  Text(cartViewModel.total.toStringAsFixed(2))
                ],
              );
            }
        ),
        // Un autre espacement
        SizedBox(height:Platform.isIOS? MediaQuery.of(context).size.height*0.1:MediaQuery.of(context).size.height*0.03),
        // Les boutons pour ajouter ou retirer le burger du panier
        BtnAddRemoveItem(burger),
      ],
    );
  }

  // La fonction back construit le bouton pour fermer la page
  Widget back(BuildContext context) {
    return Row(
      children: [
        PlatformButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.clear,color: CupertinoColors.black,)
        )
      ],
    );
  }
}
