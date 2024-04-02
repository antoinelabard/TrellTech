import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:mytodo/service/services/boards_services.dart';
import 'package:mytodo/service/services/lists_service.dart';
import 'package:mytodo/service/services/organization_service.dart';
import 'package:mytodo/components/navbar.dart';
import 'package:mytodo/components/appbar.dart';
import 'package:mytodo/components/button.dart';
import 'package:mytodo/components/card.dart';
import 'package:mytodo/components/titles.dart';
import 'package:mytodo/components/delete.dart';
import 'package:mytodo/components/update.dart';

class BoardScreen extends StatelessWidget {
  final String? boardId;
  const BoardScreen({super.key, required this.boardId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(),
      body: SingleChildScrollView(
          primary: true,
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Consumer<Boards>(
            builder: (context, boards, child) {
              var board = boards.boardsById[boardId];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TitleComponent(text: board?.name ?? "Pas de tableau"),
                      ),
                      UpdateComponent(onPressed: (){context.go('/edit-board/${board!.id}');}),
                      DeleteComponent(onPressed: ()=>{
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: const Text("Supprimer le tableau"),
                            content: const Text("Sur???"),
                            actions: [
                              TextButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Annuler")
                              ),
                              TextButton(
                                  onPressed: (){
                                    board?.delete();
                                    Navigator.of(context).pop();
                                    context.go('/home');
                                  },
                                  child: const Text("Supprimer")
                              ),
                            ],
                          );
                        }),
                      })
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 16),
                    child:  Badge(
                      label: Text(board!.closed ? 'fermer' : 'ouvert',
                        style: const TextStyle(
                          color: Color.fromRGBO(20, 25, 70, 1),
                          fontFamily: 'Roboto',
                          fontSize: 12,
                        ),
                      ),
                      backgroundColor: board.closed ? Colors.red[100] : Colors.greenAccent[200],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Descritpion : ',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(20, 25, 70, 1),
                    ),
                  ),
                  Text(
                    board.desc.isEmpty ? 'Pas de description' : board.desc,
                    softWrap: true,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      color: Color.fromRGBO(20, 25, 70, 1),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Consumer<Organizations>(
                    builder: (context, organizations, child) {
                      var organization = organizations.organizationsById[board.idOrganization];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Espace de travail : ',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(20, 25, 70, 1),
                            ),
                          ),
                          organization?.id == null
                              ? const Text('Pas despace de travail', style: TextStyle(fontFamily: 'Roboto'),)
                              : TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.blue[100]),
                                textStyle: MaterialStateProperty.all(const TextStyle(fontFamily: 'Roboto', color: Colors.black)),
                              ),
                              onPressed: () => context.go('/org/${organization.id}'),
                              child: Text(
                                organization!.displayName,
                                style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black,
                                ),)
                          )
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  const Text(
                    'lists',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(20, 25, 70, 1),
                    ),
                  ),
                  Consumer<TrelloLists>(
                      builder: (context, lists, child) {
                        return lists.listsByBoardId[boardId] == null ?
                        const Text(
                          'Pas de lists',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Color.fromRGBO(20, 25, 70, 1),
                          ),) :
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            for (var list in lists.listsByBoardId[boardId]!)
                              CardComponent(
                                iconData: Icons.attachment_sharp,
                                title: list.name,
                                subtitle: list.closed ? '❌ fermer' : '✅ ouvert',
                                onTap: () => {
                                  context.go('/list/${list.id}')
                                },
                              ),
                            Button(
                                text: "Créer une list",
                                iconName: Icons.add,
                                onPressed: () => context.go('/create-list/${board.id}')
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      }
                  ),
                ],
              );
            },
          )
      ),
      bottomNavigationBar: const NavigationBarComponent(),
    );
  }
}