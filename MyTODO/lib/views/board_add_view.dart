import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:mytodo/service/services/boards_services.dart';
import 'package:mytodo/service/services/organization_service.dart';
import 'package:mytodo/components/navbar.dart';
import 'package:mytodo/components/appbar.dart';
import 'package:mytodo/components/button.dart';
import 'package:mytodo/components/titles.dart';
import 'package:mytodo/components/text_input.dart';

class CreateBoardScreen extends StatefulWidget {
  const CreateBoardScreen({super.key});

  @override
  CreateBoardScreenState createState() => CreateBoardScreenState();
}

class CreateBoardScreenState extends State<CreateBoardScreen> {
  String? selectedBoard;
  String? selectedOrg;
  String boardName = '';
  String? boardDesc;
  String? error;

  void validateForm(String? board, String? org, String? name, String? desc) {
    if (board == null || org == null || name == null || desc == null) {
      setState(() {
        error = 'Remplir tous les champs';
      });
      return;
    }
    context
        .read<Boards>()
        .createBoard(
            idBoardSource: board, idOrganization: org, name: name, desc: desc)
        .then((value) => context.go('/home'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const TitleComponent(text: 'Créer un tableau'),
            const SizedBox(height: 40),
            TextComponent(
                name: "Name",
                onTextChanged: (String value) {
                  setState(() {
                    boardName = value;
                  });
                }),
            const SizedBox(height: 20),
            TextComponent(
                name: "Description",
                onTextChanged: (String value) {
                  setState(() {
                    boardDesc = value;
                  });
                }),
            const SizedBox(height: 28),
            Consumer<Boards>(
              builder: (builder, boards, child) {
                return DropdownMenu(
                  inputDecorationTheme: const InputDecorationTheme(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Color(0xFF51CCF6)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Color(0xFF51CCF6)),
                    ),
                  ),
                  menuStyle: MenuStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.white,
                    ),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        side: BorderSide(
                            width: 3, color: Color(0xFF51CCF6)),
                      ),
                    ),
                  ),
                  label: const Text(
                    "Choisir un template",
                    style: TextStyle(
                      color: Color.fromRGBO(20, 25, 70, 1),
                      fontFamily: 'Roboto',
                    ),
                  ),
                  expandedInsets: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 16.0),
                  dropdownMenuEntries: boards.boards.map((board) {
                    return DropdownMenuEntry(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(
                            color: Color.fromRGBO(20, 25, 70, 1),
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ),
                      value: board.id,
                      label: board.name,
                    );
                  }).toList(),
                  onSelected: (String? value) => {
                    setState(() {
                      selectedBoard = value;
                    })
                  },
                );
              },
            ),
            const SizedBox(height: 32),
            Consumer<Organizations>(builder: (builder, organizations, child) {
              return DropdownMenu(
                inputDecorationTheme: const InputDecorationTheme(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Color(0xFF51CCF6)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Color(0xFF51CCF6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Color(0xFF51CCF6)),
                  ),
                ),
                label: const Text(
                  "Choisir un espace de travail",
                  style: TextStyle(
                    color: Color.fromRGBO(20, 25, 70, 1),
                    fontFamily: 'Roboto',
                  ),
                ),
                dropdownMenuEntries:
                    organizations.organizations.map((organization) {
                  return DropdownMenuEntry(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(
                          color: Color.fromRGBO(20, 25, 70, 1),
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),
                    value: organization.id,
                    label: organization.name,
                  );
                }).toList(),
                onSelected: (String? value) => {
                  setState(() {
                    selectedOrg = value;
                  })
                },
              );
            }),
            const SizedBox(height: 28),
            Button(
                text: 'Creér le tableau',
                iconName: Icons.add,
                onPressed: () => {
                      validateForm(
                          selectedBoard, selectedOrg, boardName, boardDesc),
                    }),
            const SizedBox(height: 16),
            Text(
              error ?? "",
              style: const TextStyle(
                fontFamily: 'Roboto',
                color: Colors.redAccent,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const NavigationBarComponent(),
    );
  }
}
