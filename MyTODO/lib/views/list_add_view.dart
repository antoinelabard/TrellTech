import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:mytodo/service/services/boards_services.dart';
import 'package:mytodo/service/services/lists_service.dart';
import 'package:mytodo/components/navbar.dart';
import 'package:mytodo/components/button.dart';
import 'package:mytodo/components/titles.dart';
import 'package:mytodo/components/text_input.dart';

class CreateListScreen extends StatefulWidget {
  final String? boardId;
  const CreateListScreen({super.key, required this.boardId});

  @override
  _CreateListScreenState createState() => _CreateListScreenState();
}

class _CreateListScreenState extends State<CreateListScreen>{
  String listName = '';
  String? error;

  void validateForm(String? name) {
    if (name == null) {
      setState(() {
        error = 'Remplir tous les champs';
      });
      return;
    }
    context
        .read<TrelloLists>()
        .create(idBoard: widget.boardId!, name: name)
        .then((value) => context.go('/board/${widget.boardId}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleComponent(text: 'Créer une list'),
            const SizedBox(height: 20),
            const Text('Tableau: ', style: TextStyle(fontFamily: 'Roboto', fontSize: 16)),
            Text(context.read<Boards>().boardsById[widget.boardId]?.name ?? '', style: const TextStyle(fontFamily: 'Roboto')),
            const SizedBox(height: 20),
            TextComponent(
              name: "Naame",
              errorText: error,
              onTextChanged: (String value) {
                setState(() {
                  listName = value;
                });
              },
            ),
            const SizedBox(height: 20),
            if (error != null) Text(error!, style: const TextStyle(fontFamily: 'Roboto', color: Colors.redAccent),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                  iconName: Icons.add,
                  text: 'Créer une list',
                  onPressed: () {
                    validateForm(listName);
                  },
                ),
                const SizedBox(width: 20),
                TextButton(
                    style: ButtonStyle(

                      padding: MaterialStateProperty.all(
                        const EdgeInsets.all(16.0),
                      ),
                      backgroundColor:
                      MaterialStateProperty.all(Colors.lightBlueAccent),
                    ),
                    onPressed: () => context.go('/board/${widget.boardId}'),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.white,
                        ),
                        Text(" Retour",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Roboto',
                                color: Colors.white)),
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}