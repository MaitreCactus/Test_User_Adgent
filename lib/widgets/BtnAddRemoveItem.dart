// Importations nécessaires pour le fichier

import 'dart:io';
import 'package:big_burger/model/Burger.dart';
import 'package:big_burger/viewModel/CartViewModel.dart';
import 'package:big_burger/widgets/PlatformButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Classe BtnAddRemoveItem, un StatelessWidget qui crée les boutons pour ajouter et supprimer des éléments du panier
class BtnAddRemoveItem extends StatelessWidget{

  // Burger est le seul paramètre nécessaire pour cette classe
  final Burger burger;

  // Constructeur de la classe
  const BtnAddRemoveItem(this.burger,{Key? key}) : super(key: key);

  // La méthode build génère l'interface utilisateur pour les boutons Ajouter/Supprimer
  @override
  Widget build(BuildContext context) {
    return Container(
      // Décorer le conteneur
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child:Center(
        child:SizedBox(
          child:Row(
            // Utilisez MainAxisAlignment.center pour centrer les boutons
            mainAxisAlignment: MainAxisAlignment.center,
            // Utilisez CrossAxisAlignment.center pour aligner les boutons au centre de l'axe transversal
            crossAxisAlignment: CrossAxisAlignment.center,
            // Utilisez MainAxisSize.max pour que la ligne prenne tout l'espace disponible
            mainAxisSize: MainAxisSize.max,
            children: [
              // Création du bouton d'ajout
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: btnAdd(context),
                ),
              ),
              // Création du bouton de suppression
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: btnRemove(context),
                ),
              ),
            ],
          ) ,
        ) ,
      ),
    );
  }

  // Fonction qui crée le bouton d'ajout
  Widget btnAdd(BuildContext context) {
    return PlatformButton(
        onPressed: () {
          // Quand le bouton est pressé, ajoutez le burger au CartViewModel
          Provider.of<CartViewModel>(context, listen: false).addItem(burger);
          // Imprime le total après l'ajout de l'élément
          print(Provider.of<CartViewModel>(context, listen: false).total);
        },
        color: Colors.green, // Bouton de couleur verte
        child: const Center(
          child: Icon(
            Icons.add, // Icone d'ajout
            color: Colors.white,
          ),
        ));
  }

  // Fonction qui crée le bouton de suppression
  Widget btnRemove(BuildContext context) {
    return PlatformButton(
        onPressed: () {
          // Quand le bouton est pressé, supprimez le burger de CartViewModel
          Provider.of<CartViewModel>(context, listen: false).removeItem(burger);
          // Imprime le total après la suppression de l'élément
          print(Provider.of<CartViewModel>(context, listen: false).total);
        },
        color: Colors.redAccent, // Bouton de couleur rouge
        child: const Center(
          child: Icon(
            Icons.remove, // Icone de suppression
            color: Colors.white,
          ),
        ));
  }
}
