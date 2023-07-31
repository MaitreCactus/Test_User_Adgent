// Importation de la classe Burger
import 'Burger.dart';

// Déclaration de la classe CartItem
class CartItem {
  // Déclaration de l'objet Burger
  final Burger burger;
  // Déclaration de la quantité de Burger
  int quantity;
  // Déclaration de l'état de sélection du Burger
  bool? isSelected;

  // Constructeur de la classe CartItem
  CartItem({
    required this.burger,  // Exige un Burger lors de la création de l'objet CartItem
    this.quantity = 0,    // Initialise la quantité à zéro par défaut
    this.isSelected       // L'état de sélection n'est pas initialisé par défaut
  });
}
