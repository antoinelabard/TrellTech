import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:mytodo/service/services/cards_service.dart';
import 'package:mytodo/components/navbar.dart';
import 'package:mytodo/components/appbar.dart';
import 'package:mytodo/components/button.dart';
import 'package:mytodo/components/titles.dart';
import 'package:mytodo/components/text_input.dart';

class CreateCardScreen extends StatefulWidget {
  final String listId;
  const CreateCardScreen({super.key, required this.listId, });

  @override
  _CreateCardScreenState createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen>{
  String? cardName;
  String? cardDesc;
  String? error;
  String? dueDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarComponent(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const TitleComponent(text: 'Créer une card'),
              const SizedBox(height: 40),
              TextComponent(
                  name: "Name",
                  onTextChanged: (String value) {
                    setState(() {
                      cardName = value;
                    });
                  }),
              const SizedBox(height: 20),
              TextComponent(
                  name: "Description",
                  onTextChanged: (String value) {
                    setState(() {
                      cardDesc = value;
                    });
                  }),
              const SizedBox(height: 20),
              InputDatePickerFormField(
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2025),
                  onDateSaved: (value){
                    setState(() {
                      dueDate = value.toString();
                    });
                  }),
              Button(
                iconName: Icons.add,
                text: 'Créer une card',
                onPressed: (){
                  if(cardName == null || cardDesc == null){
                    setState(() {
                      error = 'Remplir tous les champs';
                    });
                    return;
                  }
                  context.read<Cards>().createCard(
                    idList: widget.listId,
                    name: cardName!,
                    desc: cardDesc,
                    due: dueDate
                  );
                  context.go('/list/${widget.listId}');
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: const NavigationBarComponent()
    );
  }

}