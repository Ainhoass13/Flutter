import 'package:flutter/material.dart';
import 'dart:async';
import 'disney_model.dart';
import 'disney_list.dart';
import 'new_disney_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personatges Disney',
      theme: ThemeData(brightness: Brightness.dark),
      home: const MyHomePage(
        title: 'Personatges Disney',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //Disney("Bella", "Bella y la Bestia", "https://i.pinimg.com/474x/3c/2e/50/3c2e50a6892ac6df8df281dea9bda243.jpg")
  List<Disney> personatges = [];
  

  Future _fetchDisneyCharacters() async 
  {
    
  }

  Future _showNewDisneyForm() async {
    Disney? newPersonatge = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return const AddDisneyFormPage();
    }));
    //print(newDigimon);
    if (newPersonatge != null){
      personatges.add(newPersonatge);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF0B479E),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showNewDisneyForm,
          ),
        ],
      ),
      body: Container(
          color: const Color.fromARGB(255, 88, 111, 137),
          child: Center(
            child: DisneyList(personatges),
          )),
    );
  }
}
