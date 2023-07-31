// Déclaration de la classe Burger
class Burger {
  // Déclaration de la référence du Burger
  String? ref;
  // Déclaration du titre du Burger
  String? title;
  // Déclaration de la description du Burger
  String? description;
  // Déclaration de la miniature du Burger
  String? thumbnail;
  // Déclaration du prix du Burger
  int? price;
  // Déclaration du prix formaté du Burger
  double? priceFormatted;
  // Déclaration du nombre de Burgers
  int nbrBurger;

  // Constructeur de la classe Burger
  Burger({
    this.ref,
    this.title,
    this.description,
    this.thumbnail,
    this.price,
    this.priceFormatted,
    this.nbrBurger = 0  // Initialisation de nbrBurger à zéro par défaut
  });

  // Méthode factory pour créer un Burger à partir d'un Map
  factory Burger.fromJson(Map<String, dynamic> json) {
    return Burger(
      ref: json['ref'],
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      price: json['price'],
    );
  }
}
