// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'dart:async';

class Disney {
  final String nombre;
  String? peli;
  String? avatar;
  String? apiname;


  int rating = 10;

  Disney(this.nombre);

  // factory Disney.fromJson(Map<String, dynamic> json) { return Disney( json['nombre'], json['peli'], json['avatar']); }

  Future getImageUrl() async {
    if (avatar != null) {
      return;
    }

    HttpClient http = HttpClient();
    try {

      apiname = nombre.toLowerCase().trim();
      final uri = Uri.https('mockapi.io', '/disney/personajes/$apiname');
      final request = await http.getUrl(uri);
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();

      List data = json.decode(responseBody);
      avatar = data[0]["img"];
      peli = data[0]["peli"];

      //print(levelDigimon);
    } catch (exception) {
      //print(exception);
    }
  }

  static Future<List<Disney>> loadDisneyCharacters() async 
  {
    final List<Disney> personatgesDisney = [];

    HttpClient http = HttpClient();
    
    try {

      var uri = Uri.https('mockapi.io', '/disney/personajes');
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();
      final Map<String, dynamic> data = json.decode(responseBody);
      final resultats = data['resultats'] as List<dynamic>?; 
      if (resultats == null) return personatgesDisney;

      final futures = <Future<Disney?>>[];
      
      for (final items in resultats) 
      {
        futures.add(() async 
        {
            try 
            {
              final nombre = (items['nombre'] as String?) ?? '';
              final peli = (items['peli'] as String?) ?? '';
              final avatar = (items['avatar'] as String?) ?? '';
            } 
            catch (_) 
            {
              
            }
        });
      }


      //print(levelDigimon);
    } catch (_) {
      //print(exception);
    }

    return personatgesDisney; 
  }
  

}
