import 'dart:io';
import 'package:big_burger/view/Burger_card.dart';
import 'package:big_burger/view/CartScreen.dart';
import 'package:big_burger/viewModel/BurgerViewModel.dart';
import 'package:big_burger/viewModel/CartViewModel.dart';
import 'package:big_burger/widgets/BurgerDescription.dart';
import 'package:big_burger/widgets/PlatformButton.dart';
import 'package:big_burger/widgets/PlatformScaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'model/Burger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context) => BurgerViewModel(),),
        ChangeNotifierProvider(create: (context) => CartViewModel(),),
      ],
      child: Platform.isAndroid ? MaterialApp(

        theme: ThemeData(
        brightness: Brightness.light, // Or Brightness.dark for dark mode
        primaryColor: Colors.red[300],
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.black,
        ),
        textTheme: TextTheme(
          bodyText2: GoogleFonts.cabin(color: Colors.red[300], fontSize: 16),
          headline6: GoogleFonts.abhayaLibre(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.red[300]),
        ),
      ),

      home: const HomePage(),
      ): CupertinoApp(

        theme: CupertinoThemeData(
          brightness: Brightness.light, // Or Brightness.dark for dark mode
          primaryColor: CupertinoColors.destructiveRed.withOpacity(0.5),
          scaffoldBackgroundColor: CupertinoColors.white,
          barBackgroundColor: CupertinoColors.black,
          textTheme: CupertinoTextThemeData(
            textStyle: GoogleFonts.cabin(color: CupertinoColors.destructiveRed.withOpacity(0.5),fontSize: 16),
            navActionTextStyle: GoogleFonts.aboreto(),
            navTitleTextStyle: GoogleFonts.aboreto(color: CupertinoColors.destructiveRed.withOpacity(0.5),fontSize: 18,fontWeight: FontWeight.w700),
          ),


        ),
        home: HomePage(),
      ),
    );
  }

}

class HomePage extends StatefulWidget {
  const HomePage({super.key,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // Get the BurgerViewModel from the context.
      final burgerViewModel = Provider.of<BurgerViewModel>(context, listen: false);

      // Fetch the burgers.
      burgerViewModel.fetchBurgers();
    });
  }

  @override
  void dispose() {

    super.dispose();
  }

  // La méthode `build` construit l'interface utilisateur de la page d'accueil.
  @override
  Widget build(BuildContext context) {
    // On observe le BurgerViewModel pour détecter les changements d'état.
    final BurgerViewModel burgerViewModel = context.watch<BurgerViewModel>();

    return PlatformScaffold(
      // La barre d'application sera différente en fonction de la plateforme (Android ou iOS).
      androidAppBar: AppBar(
        title:  Text('Big Burger',style: GoogleFonts.cabin(decoration: TextDecoration.none),),
        // L'icône du panier ouvre un BottomSheet contenant le panier quand elle est cliquée.
        actions:  [GestureDetector(child:const Icon(Icons.shopping_cart,size: 20,),onTap: (){
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => Container(
                // Le BottomSheet prend 90% de la hauteur de l'écran.
                  height: MediaQuery.of(context).size.height * 0.9,
                  child: CartScreen()
              ));
        },),],
      ),
      // La barre d'application pour iOS.
      iosAppBar:  CupertinoNavigationBar(
        middle: const Text('Big Burger'),
        trailing: GestureDetector(child:const Icon(Icons.shopping_cart,size: 20,),onTap: (){
          showCupertinoModalPopup(
            context: context,
            builder: (context) => const CartScreen(),
          );
        },),
      ),
      // Le corps de la page d'accueil. Il affiche une liste de burgers ou un indicateur de chargement.
      body: Selector<BurgerViewModel, List<Burger>>(
        selector: (_, viewModel) => viewModel.burgers ?? [],
        shouldRebuild: (prev, next) => prev != next,
        builder: (context, burgers, child) {
          // Si la liste de burgers est null, on affiche un indicateur de chargement.
          if (burgers == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // Si les données sont en cours de chargement, on affiche un indicateur de chargement.
            return burgerViewModel.isLoading
                ? const Center(child: CircularProgressIndicator())
            // Si une erreur s'est produite lors du chargement des données, on affiche un bouton pour réessayer.
                : burgerViewModel.error != null
                ? Center(
                child: PlatformButton(
                  color: Colors.red,
                  onPressed: () {
                    burgerViewModel.fetchBurgers();
                  }, child: const Text(
                    "Une erreur s'est produite, appuyez sur pour réessayer"),)
            )
            // Si les données ont été chargées avec succès, on affiche une liste de burgers.
                : ListView.builder(
              itemExtent: 100,
              itemCount: burgers.length,
              itemBuilder: (context, index) {
                Burger burger = burgers[index];
                // Chaque élément de la liste est une carte de burger.
                return BurgerCard(
                  burger: burger,
                  onTap: () {
                    // Lorsqu'on clique sur la carte, on affiche la description du burger dans un modal.
                    if (Platform.isAndroid) {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: BurgerDescription(burger)
                        ),
                      );
                    } else if (Platform.isIOS) {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => BurgerDescription(burger),
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}


