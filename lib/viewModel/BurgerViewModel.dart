import 'package:flutter/material.dart';
import '../model/Burger.dart';
import '../services/Burger_Service.dart';

// Définition du modèle de vue du burger qui étend la classe ChangeNotifier.

class BurgerViewModel extends ChangeNotifier {

  // Liste de burgers. Elle sera remplie lors du chargement des données depuis le réseau.
  List<Burger>? burgers;

  // Un booléen pour suivre si des données sont actuellement en cours de chargement.
  bool isLoading = false;

  // Une chaîne pour suivre les erreurs éventuelles qui se produisent lors du chargement des données.
  String? error;



  // Constructeur de la classe, qui lance immédiatement le chargement des données.
  BurgerViewModel() {
    fetchBurgers();
  }

  // Méthode pour charger les burgers depuis le réseau.
  Future<void> fetchBurgers() async {
    // Indique que le chargement des données a commencé.
    isLoading = true;
    notifyListeners(); // Informe les écouteurs qu'un changement a eu lieu.

    try {
      // Essayez de charger les burgers. En cas de succès, stockez-les dans la liste de burgers et effacez toute erreur précédente.
      burgers = await BurgerService.fetchBurgers();
      // Parcourir chaque burger dans la liste de burgers
      for (var burger in burgers!) {

        // Déclarer une variable pour stocker le prix formaté du burger
        //double priceFormatted;

        // Si le prix du burger est supérieur à 20000 centimes, divisez-le par 10000 pour obtenir le prix en euros
        if(burger.price! > 20000){
          burger.priceFormatted = burger.price! / 10000;
        }
        // Si le prix du burger est entre 10000 et 15000 centimes, divisez-le par 1000 pour obtenir le prix en euros
        else if(burger.price! > 10000 && burger.price! < 15000){
          burger.priceFormatted = burger.price! / 1000;
        }
        // Si le prix du burger est inférieur à 10000 centimes, divisez-le par 100 pour obtenir le prix en euros
        else {
          burger.priceFormatted = burger.price! / 100;
        }

      }


      error = null;
    } catch (e) {
      // Si une erreur se produit lors du chargement des données, stockez l'erreur.
      error = e.toString();
    } finally {
      // Une fois que les données ont été chargées (ou qu'une erreur s'est produite), indiquez que le chargement est terminé.
      isLoading = false;
      notifyListeners(); // Informe les écouteurs qu'un changement a eu lieu.
    }
  }
}


