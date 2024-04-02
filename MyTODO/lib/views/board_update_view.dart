import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:mytodo/service/services/boards_services.dart';
import 'package:mytodo/service/services/organization_service.dart';
import 'package:mytodo/components/navbar.dart';
import 'package:mytodo/components/button.dart';
import 'package:mytodo/components/titles.dart';
import 'package:mytodo/components/text_input.dart';

class EditBoardScreen extends StatefulWidget {
  final String boardId;
  const EditBoardScreen({super.key, required this.boardId});

  @override
  EditBoardScreenState createState() => EditBoardScreenState();
}

class EditBoardScreenState extends State<EditBoardScreen> {
  String name = '';
  String? boardDesc;
  String orgId = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(),
      body: SingleChildScrollView(
        child: Consumer<Boards>(
          builder: (builder, boards, child) {
            var board = boards.boardsById[widget.boardId]!;
            orgId = board.idOrganization ?? '';
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TitleComponent(text: 'Modifier le tableau ${board.name}'),
                const SizedBox(height: 40),
                TextComponent(
                    name: 'Name',
                    onTextChanged: (String value) => {
                          setState(() {
                            name = value;
                          })
                        }),
                TextComponent(
                    name: 'Description',
                    onTextChanged: (String value) => {
                          setState(() {
                            boardDesc = value;
                          })
                        }),
                Consumer<Organizations>(
                    builder: (builder, organizations, child) {
                  return Center(
                    child: DropdownMenu(
                      inputDecorationTheme: const InputDecorationTheme(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(95, 150, 253, 1.0),
                              width: 3),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(104, 151, 239, 1.0),
                              width: 3),
                        ),
                      ),
                      menuStyle: MenuStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        side: MaterialStateProperty.all(const BorderSide(
                          color: Color.fromRGBO(95, 132, 201, 1.0),
                          width: 3,
                        )),
                      ),
                      label: Text(
                        organizations.organizationsById[board.idOrganization]!
                            .displayName,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          color: Color.fromRGBO(9, 9, 9, 1.0),
                        ),
                      ),
                      dropdownMenuEntries: organizations.organizations
                          .map((e) => DropdownMenuEntry(
                              label: e.displayName,
                              value: e.id,
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  textStyle:
                                      MaterialStateProperty.all(const TextStyle(
                                    color: Color.fromRGBO(10, 10, 10, 1.0),
                                    fontFamily: 'Roboto',
                                  )))))
                          .toList(),
                      onSelected: (String? value) {
                        orgId = value!;
                      },
                    ),
                  );
                }),
                const SizedBox(height: 40),
                if (!board.closed)
                  SizedBox(
                    width: 200,
                    child: TextButton(
                        onPressed: () {
                          board.update(closed: true);
                          context.go('/board/${board.id}');
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
                              ' Fermer le tableau',
                              style: TextStyle(
                                  fontFamily: 'Roboto', color: Colors.black),
                            )
                          ],
                        )),
                  ),
                if (board.closed)
                  SizedBox(
                    width: 200,
                    child: TextButton(
                        onPressed: () {
                          board.update(closed: false);
                          context.go('/board/${board.id}');
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
                              ' Ouvrir le tableau',
                              style: TextStyle(
                                  fontFamily: 'Roboto', color: Colors.black),
                            )
                          ],
                        )),
                  ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(
                        iconName: Icons.save_outlined,
                        text: 'Save',
                        onPressed: () async {
                          if (name == '' &&
                              boardDesc != board.desc &&
                              boardDesc != '') {
                            name = board.name;
                          }
                          if (boardDesc == '' &&
                              name != board.name &&
                              name != '') {
                            boardDesc = board.desc;
                          }
                          if (orgId == '') {
                            orgId = board.idOrganization ?? '';
                          }
                          board
                              .update(
                                  name: name,
                                  desc: boardDesc,
                                  idOrganization: orgId)
                              .then((lol) => context.go('/board/${board.id}'));
                        }),
                    const SizedBox(width: 20),
                    TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.all(16.0),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.lightBlueAccent),
                        ),
                        onPressed: () {
                          context.go('/board/${widget.boardId}');
                        },
                        child: const Row(
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
                        ))
                  ],
                ),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
