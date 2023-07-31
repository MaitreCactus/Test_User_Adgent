// Importations nécessaires pour le fichier
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/Burger.dart';
import '../viewModel/CartViewModel.dart';
import 'package:google_fonts/google_fonts.dart';

// Déclaration de la classe BurgerCard, un StatelessWidget qui crée une carte pour chaque burger
class BurgerCard extends StatelessWidget {
  // Paramètres pour le burger et la fonction onTap
  final Burger burger;
  final VoidCallback onTap;

  // Constructeur de la classe
  const BurgerCard({Key? key, required this.burger, required this.onTap})
      : super(key: key);

  // La méthode build génère l'interface utilisateur pour la carte de chaque burger
  @override
  Widget build(BuildContext context) {
    // Vérifier si le burger est déjà dans le panier
    bool isSelected = context.watch<CartViewModel>().items.any((item) => item.burger == burger);

    // Retourne une carte avec tous les détails pertinents du burger
    return Card(
      color: Colors.black, // Couleur de fond de la carte
      elevation: 4.0, // Ombre de la carte
      margin: EdgeInsets.all(10), // Marge autour de la carte
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // Forme de la carte
      child: InkWell(
        onTap: onTap, // Fonction à appeler lorsque la carte est touchée
        child: Padding(
          padding: EdgeInsets.all(10), // Espacement à l'intérieur de la carte
          child: Row( // Utilise une ligne pour organiser les éléments de la carte
            children: <Widget>[
              // Widget pour l'image du burger
              SizedBox(
                height: 80,
                width: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AspectRatio(
                    aspectRatio: 1/1,
                    child: Image.network(
                      burger.thumbnail.toString(),
                      fit: BoxFit.cover,
                      // Si l'image ne peut pas être chargée, affiche une icône d'erreur
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return const Icon(Icons.error, size: 50, color: Colors.grey,);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20), // Espace entre l'image et le texte
              // Widget pour le titre du burger et le nombre de burgers si le burger est dans le panier
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Titre du burger
                    Text(
                        burger.title!,
                        style: GoogleFonts.actor(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18)
                    ),
                    // Si le burger est dans le panier, affiche le nombre de burgers
                    if(isSelected)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Badge(
                          label: Text(burger.nbrBurger.toString()),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
