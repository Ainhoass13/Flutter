import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget 
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return const MaterialApp(
      title: 'Recuperar el valor d''un camp de text',
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget 
{
  const MyCustomForm({super.key});
  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> 
{
  final myController = TextEditingController();

  @override
  void dispose() 
  {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar el valor d\'un camp de text'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),

        //Afegim una column --> per ficar tots el botons 
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.stretch, //Aixi el boto ocupa tot l'ample de la pagina
          children: 
          [
            TextField
            (
              controller: myController,
            ),
            const SizedBox(height: 20), // Separació entre el input de text i el 1r boto

            ElevatedButton
            (
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context)
                  {
                    return Container(
                        decoration: const BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        height: 200,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(myController.text),
                              ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Tancar BottomSheet'),
                              )
                            ],
                          ),
                        )
                      );
                  });
            },
            child: const Icon(Icons.text_fields),
          ),

          ElevatedButton
          (
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context)
                  {
                    return SimpleDialog(
                          backgroundColor: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)
                        ),
                        
                        children: 
                        [
                          Center
                          (
                            child: Column
                            (
                              mainAxisSize: MainAxisSize.min,
                              children: 
                              [
                                Text(myController.text),
                                ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text('Tancar Dialog'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                  },
              );
            },

            child: const Icon(Icons.text_fields),
          ),

          ElevatedButton
          (
            onPressed: () {
              // Mostrem un SnackBar amb el text introduit
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Valor del camp de text: ${myController.text}'),
                  backgroundColor: Colors.blueGrey,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(16),
                ),
              );
            },
            child: const Icon(Icons.text_fields),
          ),

          ElevatedButton
          (
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) 
                {
                  return AlertDialog
                  (
                    backgroundColor: Colors.blueGrey,
                    shape: const RoundedRectangleBorder
                    (
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    content: Column
                    (
                      mainAxisSize: MainAxisSize.min,
                      children: 
                      [
                        Text
                        (
                          myController.text,
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton
                        (
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Tancar AlertDialog'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: const Icon(Icons.text_fields),
          ),
          ]
        )
      ),
    );
  }
}
