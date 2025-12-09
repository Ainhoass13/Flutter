import 'package:digimon_2526/disney_model.dart';
import 'package:flutter/material.dart';


class AddDisneyFormPage extends StatefulWidget {
  const AddDisneyFormPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddDisneyFormPageState createState() => _AddDisneyFormPageState();
}

class _AddDisneyFormPageState extends State<AddDisneyFormPage> {
  TextEditingController ctrNombre = TextEditingController();

  void submitPup(BuildContext context) {
    if (ctrNombre.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('You forgot to insert some information'),
      ));
    } else {
      var newDisney = Disney(ctrNombre.text);
      Navigator.of(context).pop(newDisney);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new digimon'),
        backgroundColor: const Color(0xFF0B479E),
      ),
      body: Container(
        color: const Color(0xFFABCAED),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: 
              
              Column(children: [

                TextField(
                controller: ctrNombre,
                style: const TextStyle(decoration: TextDecoration.none),
                onChanged: (v) => ctrNombre.text = v,
                decoration: const InputDecoration(
                  labelText: 'Disney Name',
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),

              ])
             
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => submitPup(context),
                    child: const Text('Submit Disney character'),
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
