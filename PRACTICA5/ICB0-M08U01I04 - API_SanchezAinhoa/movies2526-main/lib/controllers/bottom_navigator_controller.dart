import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/screens/home_screen.dart';
import 'package:movies/screens/search_screen.dart';
import 'package:movies/screens/watch_list_screen.dart';

// Controlador que gestiona la navegació inferior (bottom navigation bar) de l'aplicació.
class BottomNavigatorController extends GetxController {
  // Array amb les tres pantalles principals de l'aplicació
  var screens = <Widget>[
    HomeScreen(),
    const SearchScreen(),
    const WatchList(),
  ];
  
  // Índex de la pantalla actual mostrada (0, 1 o 2)
  var index = 0.obs;
  
  // Canvia l'índex de la pantalla actual.
  void setIndex(indx) => index.value = indx;
}

