import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:mytodo/service/services/boards_services.dart';
import 'package:mytodo/service/services/cards_service.dart';
import 'package:mytodo/service/services/lists_service.dart';
import 'package:mytodo/components/navbar.dart';
import 'package:mytodo/components/appbar.dart';
import 'package:mytodo/components/button.dart';
import 'package:mytodo/components/card.dart';
import 'package:mytodo/components/titles.dart';
import 'package:mytodo/components/delete.dart';
import 'package:mytodo/components/update.dart';

class ListScreen extends StatelessWidget {
  final String listId;
  const ListScreen({super.key, required this.listId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(),
      body: Consumer<TrelloLists>(
        builder: (builder, lists, child){
          var list = lists.listsById[listId];
          return list == null
              ? const Text('Pas de list', style: TextStyle(fontFamily: 'Roboto'),)
              : SingleChildScrollView(
            primary: true,
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TitleComponent(text: lists.listsById[listId]!.name,),
                    ),
                    UpdateComponent(
                      onPressed: () => context.go('/edit-list/${list.id}'),
                    ),
                    DeleteComponent(
                        onPressed: (){
                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: const Text("Supprimer list"),
                              content: const Text("Supprimer la liste?"),
                              actions: [
                                TextButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Ok")
                                ),
                              ],
                            );
                          });
                        }
                    ),
                  ],
                ),
                Row(
                  children: [
                    Badge(
                      label: Text(
                        list.closed ? 'fermer' : 'ouvert',
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: list.closed ? Colors.redAccent[100] : Colors.greenAccent[200],
                    ),
                    const SizedBox(width: 10),
                    Badge(
                      label: Text(
                        list.subscribed == null ? 'pas de favoris' : list.subscribed == true ? 'favoris' : 'pas de favoris',
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: list.subscribed! ? Colors.cyanAccent[200] : Colors.pink[100],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text("Tableau :",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                    )),
                Consumer<Boards>(
                  builder: (builder, boards, child){
                    var board = boards.boardsById[list.idBoard];
                    return board == null
                        ? const Text('Pas de tableau', style: TextStyle(fontFamily: 'Roboto'),)
                        : TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue[100]),
                          textStyle: MaterialStateProperty.all(
                            const TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.black),
                          ),
                        ),
                        onPressed: () => context.go('/board/${board.id}'),
                        child: Text(
                          board.name,
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.black,
                          ),)
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Text("Card :",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                    )),
                Consumer<Cards>(
                  builder: (builder, cards, child){
                    var cardsList = cards.cardsByListId[listId];
                    return cardsList == null
                        ? const Text('Pas de card', style: TextStyle(fontFamily: 'Roboto'),)
                        : Column(
                      children: cardsList.map((card){
                        return CardComponent(
                          title: card.name,
                          subtitle: '${card.desc ?? "Pas de description"}, créer la ${card.due ?? "jamais"}',
                          iconData: Icons.task_alt_outlined,
                          onTap: ()=> context.go('/card/${card.id}'),);
                      }).toList(),
                    );

                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child:   Button(
                      text: 'Créer card',
                      iconName: Icons.add,
                      onPressed: () => context.go('/create-card/$listId')
                  ),
                )
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const NavigationBarComponent(),
    );
  }
}