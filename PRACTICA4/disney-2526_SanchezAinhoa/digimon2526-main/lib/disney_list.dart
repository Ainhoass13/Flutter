import 'package:digimon_2526/disney_card.dart';
import 'package:flutter/material.dart';
import 'disney_model.dart';

class DisneyList extends StatelessWidget {
  final List<Disney> personatgesList;
  const DisneyList(this.personatgesList, {super.key});

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  ListView _buildList(context) {
    return ListView.builder(
      itemCount: personatgesList.length,
      // ignore: avoid_types_as_parameter_names
      itemBuilder: (context, int) {
        return DisneyCard(personatgesList[int]);
      },
    );
  }
}
