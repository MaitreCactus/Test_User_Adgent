// Importation des packages nécessaires
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Déclaration de la classe PlatformButton, un StatelessWidget qui crée un bouton adapté à la plate-forme
class PlatformButton extends StatelessWidget {
  // Paramètres pour la fonction onPressed, le widget enfant et la couleur
  final VoidCallback onPressed;
  final Widget child;
  final Color color;

  // Constructeur de la classe
  const PlatformButton({Key? key, required this.onPressed, required this.child, required this.color}) : super(key: key);

  // La méthode build génère l'interface utilisateur pour le bouton
  @override
  Widget build(BuildContext context) {
    // Vérifie si la plate-forme est iOS
    if (Platform.isIOS) {
      // Si la plate-forme est iOS, utilise CupertinoButton
      return CupertinoButton(
        color: color, // couleur du bouton
        padding: EdgeInsets.zero, // padding du bouton
        onPressed: onPressed, // fonction à exécuter lorsque le bouton est pressé
        child: child, // contenu du bouton
      );
    } else {
      // Si la plate-forme n'est pas iOS (Android), utilise ElevatedButton
      return ElevatedButton(
        onPressed: onPressed, // fonction à exécuter lorsque le bouton est pressé
        child: child, // contenu du bouton
        style: ElevatedButton.styleFrom(
          primary: color, // couleur du fond du bouton
        ),
      );
    }
  }
}
