import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/Burger.dart';

class BurgerService {
  // L'URL de l'API est définie comme constante pour une meilleure gestion et lisibilité du code.
  static const String _apiUrl = 'https://uad.io/bigburger';

  // Méthode pour récupérer la liste des burgers.
  static Future<List<Burger>> fetchBurgers() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));

      // Vérifiez si la requête a réussi.
      if (response.statusCode == 200) {
        // Si la requête a réussi, décodez la réponse en JSON et transformez chaque élément en un objet Burger.
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((item) => Burger.fromJson(item)).toList();
      } else {
        // Si le code de statut n'est pas 200, lancez une exception avec le code de statut pour indiquer l'échec de la requête.
        throw Exception('Failed to load burgers from API, Status code: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } on HttpException {
      throw Exception("Couldn't find the post");
      } on FormatException {
      throw Exception('Bad response format');
      }
      }
}
