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

  // creem una llista de països per a l'autocompletat
  const List<String> paisos = [
    'Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Cyprus', 'Czech Republic', 'Denmark',
    'Estonia', 'Finland', 'France','Germany', 'Greece','Hungary', 'Ireland', 'Italy', 
    'Latvia', 'Lithuania', 'Luxembourg', 'Malta', 'Netherlands', 'Poland', 'Portugal',
    'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden', 'United Kingdom',
  ];


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
                    
                      //Container per Autocompletat de paisos
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
                          children: 
                          [

                            const Text(
                              'Autocomplete',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),

                            const SizedBox(height: 12),

                            FormBuilderField<String>(
                              name: 'paisos',
                              builder: (FormFieldState<String?> field) {
                                return Autocomplete<String>( // Widget d'autocompletat
                                  optionsBuilder: (TextEditingValue textEditingValue) {
                                    // Filtra la llista de països segons el text introduït per l'usuari i si esta buit mostra tota la llista
                                    if (textEditingValue.text.isEmpty) {
                                      return paisos;
                                    }
                                    return paisos.where((country) =>
                                        country.toLowerCase().contains(textEditingValue.text.toLowerCase()));
                                  },
                                  //Guarda el valor seleccionat al formulari i mostra per consola
                                  onSelected: (value) {
                                    field.didChange(value); // Guarda el valor al formulari
                                    debugPrint('Selected country: $value');
                                  },
                                  fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                                    //Builder per personalitzar el TextField intern de l'Autocompletat
                                    return TextField(
                                      controller: controller,
                                      focusNode: focusNode,
                                      decoration: InputDecoration(
                                        labelText: 'Autocomplete',
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                        filled: true,
                                      ),
                                      onSubmitted: (value) => onFieldSubmitted(),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),


                      //Container pel Date Picker
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

                            const Text(
                              'Date Picker',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),

                            const SizedBox(height: 12),

                            FormBuilderDateTimePicker(
                              name: 'date',
                              inputType: InputType.date, // Només data, sense hora
                              decoration: InputDecoration(
                                labelText: 'Date Picker',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,

                                //Afegim una icona de calendari al final del camp
                                suffixIcon: const Icon(Icons.calendar_month_rounded),
                              ),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                              onChanged: (value) {
                                debugPrint('Selected date: $value');
                              },
                            ),
                          ],
                        ),
                      ),


                      //Container pel Date Range Picker
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

                            const Text(
                              'Date Range Picker',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),

                            const SizedBox(height: 12),

                            FormBuilderDateRangePicker(
                              name: 'date_range',
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),

                              decoration: InputDecoration(
                                labelText: 'Date Range',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                suffixIcon: const Icon(Icons.date_range_rounded),
                              ),

                              onChanged: (value) {
                                debugPrint('Selected range: $value');
                              },
                            ),
                          ],
                        ),
                      ),
                      
                      //Container pel Time Picker
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

                            const Text(
                              'Time Picker',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),

                            const SizedBox(height: 12),

                            FormBuilderDateTimePicker(
                              name: 'time',
                              inputType: InputType.time, // només l'hora
                              decoration: InputDecoration(
                                labelText: 'Time Picker',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                suffixIcon: const Icon(Icons.access_time_rounded), // Icone del rellotge
                              ),

                              onChanged: (value) {
                                debugPrint('Selected time: $value');
                              },
                            ),
                          ],
                        ),
                      ),

                      //Container pels Input Chips
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

                            const Text(
                              'InputChips',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),

                            const SizedBox(height: 12),

                            FormBuilderChoiceChips<String>(
                              name: 'tech_skills',
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              options: const [
                                FormBuilderChipOption(value: 'HTML'),
                                FormBuilderChipOption(value: 'CSS'),
                                FormBuilderChipOption(value: 'React'),
                                FormBuilderChipOption(value: 'Dart'),
                                FormBuilderChipOption(value: 'TypeScript'),
                                FormBuilderChipOption(value: 'Angular'),
                              ],
                              onChanged: (value) {
                                debugPrint('Selected chips: $value');
                              },

                              selectedColor: Colors.teal,
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
