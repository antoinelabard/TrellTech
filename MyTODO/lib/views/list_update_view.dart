import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:mytodo/service/services/boards_services.dart';
import 'package:mytodo/service/services/lists_service.dart';
import 'package:mytodo/components/checkbox.dart';
import 'package:mytodo/components/navbar.dart';
import 'package:mytodo/components/button.dart';
import 'package:mytodo/components/titles.dart';
import 'package:mytodo/components/text_input.dart';

class EditListScreen extends StatefulWidget {
  final String listId;
  const EditListScreen({super.key, required this.listId});

  @override
  _EditListScreenState createState() => _EditListScreenState();
}

class _EditListScreenState extends State<EditListScreen>{
  String listName = '';
  String? boardId;
  String? error;
  bool subscribed = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBarComponent(),
      body: SingleChildScrollView(
        child: Consumer<TrelloLists>(
          builder: (builder, lists, child){
            var list = lists.listsById[widget.listId];
            if(list == null) return const Text('Pas de list', style: TextStyle(fontFamily: 'Roboto'),);
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TitleComponent(text: 'Modifier list ${list.name}'),
                const SizedBox(height: 20),
                TextComponent(
                  name: "Name",
                  helperText: list.name,
                  errorText: error,
                  onTextChanged: (String value){
                    setState(() {
                      listName = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Consumer<Boards>(
                    builder: (builder, boards, child){
                      return DropdownMenu(
                        label: const Text('Tableau: ', style: TextStyle(fontFamily: 'Roboto'),),
                        inputDecorationTheme: const InputDecorationTheme(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(234, 191, 22, 1.0),
                                width: 3),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(234, 191, 22, 1.0),
                                width: 3),
                          ),
                        ),
                        menuStyle: MenuStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.white),
                          side: MaterialStateProperty.all(const BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 1.0),
                            width: 3,
                          )),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Color.fromRGBO(234, 191, 22, 1.0),
                                  width: 3),
                            ),
                          ),
                        ),
                        onSelected: (String? value){
                          setState(() {
                            boardId = value;
                          });
                        },
                        dropdownMenuEntries: boards.boards
                            .map((e) => DropdownMenuEntry(
                            value: e.id,
                            label: e.name,
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                                textStyle:
                                MaterialStateProperty.all(const TextStyle(
                                  color: Color.fromRGBO(20, 25, 70, 1),
                                  fontFamily: 'Roboto',
                                ))),
                        ))
                            .toList(),
                      );
                    }),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Favoris :', style: TextStyle(fontFamily: 'Roboto', fontSize: 16)),
                    CheckComponent(
                      value: subscribed,
                      onChanged: (value){
                        setState(() {
                          subscribed = value ?? false;
                        });
                      },
                    ),
                  ],
                ),
                if (!list.closed)
                  SizedBox(
                    width: 200,
                    child: TextButton(
                        onPressed: () {
                          list.update(closed: true);
                          context.go('/board/${list.id}');
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(top: 16.0, bottom: 16.0)),
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              fontFamily: 'Roboto', color: Colors.black)),
                          backgroundColor:
                          MaterialStateProperty.all(Colors.red[100]),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.close,
                              color: Colors.redAccent,
                            ),
                            Text(
                              ' Tbaleau fermé',
                              style: TextStyle(
                                  fontFamily: 'Roboto', color: Colors.black),
                            )
                          ],
                        )),
                  ),
                if (list.closed)
                  SizedBox(
                    width: 200,
                    child: TextButton(
                        onPressed: () {
                          list.update(closed: false);
                          context.go('/list/${list.id}');
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.only(top: 16.0, bottom: 16.0)),
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              fontFamily: 'Roboto', color: Colors.black)),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.greenAccent[100]),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.open_in_browser,
                              color: Colors.greenAccent,
                            ),
                            Text(
                              ' Tableau ouvert',
                              style: TextStyle(
                                  fontFamily: 'Roboto', color: Colors.black),
                            )
                          ],
                        )),
                  ),
                const SizedBox(height: 20),
                if (error != null) Text(error!, style: const TextStyle(fontFamily: 'Roboto', color: Colors.redAccent),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(
                      iconName: Icons.edit_note_outlined,
                      text: 'Modifier list',
                      onPressed: () {
                        if(listName == '' && boardId == null){
                          setState(() {
                            error = 'Remplir tous les champs';
                          });
                          return;
                        }
                        list.update(
                            name: listName,
                            idBoard: boardId,
                            subscribed: subscribed
                        );
                        context.go('/list/${list.id}');
                      },
                    ),
                    const SizedBox(width: 20),
                    TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.all(16.0),
                          ),
                          backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlueAccent),
                        ),
                        onPressed: () => context.go('/board/${list.idBoard}'),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
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
            );
          },
        ),
      ),
    );
  }
}