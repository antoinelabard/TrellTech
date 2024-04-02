import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:mytodo/service/services/cards_service.dart';
import 'package:mytodo/components/button.dart';
import 'package:mytodo/components/titles.dart';
import 'package:mytodo/components/text_input.dart';

class EditCardScreen extends StatefulWidget {
  final String cardId;

  EditCardScreen({required this.cardId, Key? key});

  @override
  _EditCardScreenState createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen>{
  String? cardName;
  String? cardDesc;
  String? error;
  String? dueDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Modifier Card'),
        ),
        body: Consumer<Cards>(
          builder: (builder, cards, child){
            var card = cards.cardsById[widget.cardId];
            return Column(
              children: [
                TitleComponent(text: 'Modifier card ${card!.name}'),
                const SizedBox(height: 40),
                TextComponent(
                    name: "Name",
                    helperText: card.name,
                    onTextChanged: (String value) {
                      setState(() {
                        cardName = value;
                      });
                    }),
                const SizedBox(height: 20),
                TextComponent(
                    name: "Description",
                    helperText: card.desc,
                    onTextChanged: (String value) {
                      setState(() {
                        cardDesc = value;
                      });
                    }),
                const SizedBox(height: 20),
                Button(
                  iconName: Icons.save_outlined,
                  text: 'Modifier card',
                  onPressed: () {
                    if (cardName != null && cardDesc != null) {
                      Provider.of<Cards>(context, listen: false).cardsById[widget.cardId]?.update(
                        name: cardName!,
                        desc: cardDesc!,
                      );
                      context.go('/card/${widget.cardId}');
                    } else {
                      setState(() {
                        error = 'Error';
                      });
                    }
                  },
                ),
                if (error != null) Text(error!),
              ],
            );
          },
        ));
  }
}

