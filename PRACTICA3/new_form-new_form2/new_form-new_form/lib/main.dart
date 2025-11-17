  import 'package:flutter/material.dart';
  import 'package:flutter_form_builder/flutter_form_builder.dart';

  void main() {
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Ainhoa Sánchez - 2025-26 - Form (C)',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        home: MyHomePage(),
      );
    }
  }

  class MyHomePage extends StatelessWidget {
    MyHomePage({super.key});
    final String title = 'Ainhoa Sánchez 25/26';
    final _formKey = GlobalKey<FormBuilderState>();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(title),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FormBuilder(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    //Aliniem tot el contingut a l'esquerra
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    
                      //Container pels CoiceChips
                      Container(
                      //Marges i decoració del container
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          //Títol del ChoiceChips
                          const Text(
                            'ChoiceChips',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 12),

                          FormBuilderChoiceChips<String>(
                          //nom amb el que identifiquem aquest grup
                          name: 'plataformes',
                          decoration: const InputDecoration(border: InputBorder.none),

                          //Centrem les opcions horitzontalment
                          alignment: WrapAlignment.center,
                          spacing: 12,
                          runSpacing: 12,

                          //Llista d'opcions seleccionables
                          options: const [
                            FormBuilderChipOption<String>(
                              value: 'Flutter',
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(width: 6),
                                  Text('Flutter', style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                            FormBuilderChipOption<String>(
                              value: 'Android',
                              child: Text('Android', style: TextStyle(color: Colors.white)),
                            ),
                            FormBuilderChipOption<String>(
                              value: 'Chrome OS',
                              child: Text('Chrome OS', style: TextStyle(color: Colors.white)),
                            ),
                          ],
                          selectedColor: Colors.teal, // color quan està seleccionat
                          backgroundColor: Colors.blue.shade100, // color sense seleccionar
                          checkmarkColor: Colors.white,
                          onChanged: (value) {
                            debugPrint('Selected platform: $value');
                          },
                        ),
                        ],
                      ),
                    ),

                      //Container pel switch
                      Container(
                      //Marges i decoració del container
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          //Títol del switch
                          const Text(
                            'Switch',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 12),

                          //Switch
                          FormBuilderSwitch(
                            name: 'switch',
                            title: const Text(
                              'This is a switch',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            initialValue: false,
                            activeColor: Colors.teal,
                            onChanged: (value) {
                              debugPrint('Switch changed: $value');
                            },
                          ),
                        ],
                      ),
                    ),



                    //Container pel Textfield
                    Container(
                      //Marges i decoració del container
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          //Títol del Textfield
                          const Text(
                            'Text Field',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 12),

                          //Textfield
                          FormBuilderTextField(
                            name: 'remark',
                            // limit de caràcters
                            maxLength: 15,
                            decoration: InputDecoration(
                              prefix: const Text
                              (
                                'A',
                                style: TextStyle
                                (
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline, //Text Subtratllat
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                            ),
                              buildCounter: (
                                BuildContext context, {
                                required int currentLength,
                                required int? maxLength,
                                required bool isFocused,
                              }) {
                                return Text('$currentLength/$maxLength'); // comptador va sumant els caràcters introduïts i quants en total es poden introduir
                              },
                            onChanged: (String? value) {
                              debugPrint(value);
                            },
                          ),
                        ],
                      ),
                    ),


                    //Container pel DropDown Field
                    Container(
                      //Marges i decoració del container
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          //Títol del Dropdown Field
                          const Text(
                            'Dropdown Field',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 12),
                          FormBuilderDropdown<String>(
                            name: 'DropDown', // Nom per identificar el camp
                            decoration: InputDecoration(
                              border: OutlineInputBorder( 
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(value: 'Flutter', child: Text('Flutter')),
                              DropdownMenuItem(value: 'Android', child: Text('Android')),
                              DropdownMenuItem(value: 'iOS', child: Text('iOS')),
                              DropdownMenuItem(value: 'Web', child: Text('Web')),
                            ],
                            onChanged: (String? value) {
                              debugPrint('Selected value: $value');
                            },
                          ),
                        ],
                      ),
                    ),

                    //Container pel RadioGroup
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // Títol del RadioGroup
                          const Text(
                            'Radio Group Model',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 12),

                          // RadioGroup
                          FormBuilderRadioGroup<String>(
                            name: 'RadioGroup', // Nom per identificar el camp
                            options: const [
                              FormBuilderFieldOption(value: 'Option 1', child: Text('1')),
                              FormBuilderFieldOption(value: 'Option 2', child: Text('2')),
                              FormBuilderFieldOption(value: 'Option 3', child: Text('3')),
                              FormBuilderFieldOption(value: 'Option 4', child: Text('4')),
                            ],
                            onChanged: (value) {
                              debugPrint('Selected vehicle type: $value');
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none, // Sin borde extra dentro del RadioGroup
                            ),
                          ),
                        ],
                      ),
                    ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.upload),
            onPressed: () {
              _formKey.currentState?.saveAndValidate();
              String? formString = _formKey.currentState?.value.toString();
              alertDialog(context, formString!);
            }),
      );
    }
  }

  void alertDialog(BuildContext context, String contentText) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text("Submission Completed"),
        icon: const Icon(Icons.check_circle),
        content: Text(contentText),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Tancar'),
            child: const Text('Tancar'),
          ),
        ],
      ),
    );
  }
