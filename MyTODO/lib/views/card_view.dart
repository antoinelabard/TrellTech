import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:mytodo/service/services/cards_service.dart';
import 'package:mytodo/service/services/lists_service.dart';
import 'package:mytodo/service/services/members_service.dart';
import 'package:mytodo/components/navbar.dart';
import 'package:mytodo/components/appbar.dart';
import 'package:mytodo/components/titles.dart';
import 'package:mytodo/components/delete.dart';
import 'package:mytodo/components/update.dart';

class CardScreen extends StatelessWidget {
  final String cardId;
  const CardScreen({super.key, required this.cardId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarComponent(),
        body: Consumer<Cards>(
          builder: (builder, cards, child){
            var trelloCard = cards.cardsById[cardId];
            var idList = trelloCard?.idList;
            return trelloCard == null
                ? const Text('Pas de card', style: TextStyle(fontFamily: 'Roboto'),)
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
                        child: TitleComponent(text: trelloCard.name),
                      ),
                      UpdateComponent(onPressed: () => context.go('/edit-card/$cardId')),
                      DeleteComponent(onPressed: () => showDialog(context: context, builder: (context){
                        return AlertDialog(
                          title: const Text("Supprimer card"),
                          content: const Text("Sur????"),
                          actions: [
                            TextButton(
                                onPressed: (){
                                  trelloCard.delete();
                                  Navigator.of(context).pop();
                                  idList == null ? context.go('/list/$idList') : context.go('/home');
                                },
                                child: const Text("Supprimer")
                            ),
                            TextButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Annuler")
                            ),
                          ],
                        );
                      })),
                    ],
                  ),
                  Row(
                    children: [
                      Badge(
                        backgroundColor: trelloCard.dueComplete ? Colors.green[200] : Colors.orange[100],
                        label: Text(
                          trelloCard.dueComplete ? "Validé" : "Non validé",
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Badge(
                        backgroundColor: trelloCard.subscribed ? Colors.blue[200] : Colors.pink[100],
                        label: Text(
                          trelloCard.subscribed ? "Favoris" : "Noon favoris",
                          style: const TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('list :',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xff141946),
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                    ),
                  ),
                  Consumer<TrelloLists>(
                    builder: (builder, lists, child){
                      var board = lists.listsById[trelloCard.idList];
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
                        child: Text(
                            board.name,
                            style: const TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.black,
                            )
                        ),
                        onPressed: (){
                          context.go('/list/${trelloCard.idList}');
                        },);
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 18,),
                      const Text(
                        ' Date de fin :',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Color(0xff141946),
                            fontWeight: FontWeight.w500,
                            fontSize: 16
                        ),
                      ),
                      Text(
                        trelloCard.due ?? " Pas de date de fin",
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          color: Color(0xff141946),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Descritpion :',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xff141946),
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                    ),
                  ),
                  Text(
                    trelloCard.desc ?? "Pas deescription",
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      color: Color(0xff141946),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Assigné à :',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Color(0xff141946),
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                    ),
                  ),
                  Row(
                    children: [
                      if(trelloCard.idMembers == null)  const Text('Pas de membres assigné', style: TextStyle(fontFamily: 'Roboto'),),
                      if(trelloCard.idMembers!.isEmpty) const Text('Pas de membres assigné', style: TextStyle(fontFamily: 'Roboto'),),
                      const SizedBox(width: 20),
                      Row(
                        children: trelloCard.idMembers!.map((memberId){
                          var member = Provider.of<Members>(context, listen: false).membersById[memberId];
                          return member == null
                              ? const Text('Pas de membres', style: TextStyle(fontFamily: 'Roboto'),)
                              : Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Text(
                              member.username,
                            ),
                          );
                        }).toList(),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.blue[100],
                        child: IconButton(
                          onPressed: (){
                            showDialog(context: context,
                                builder:
                                    (context) => AlertDialog(
                                  title: const Text('Ajouter un membre'),
                                  content: Column(
                                    children: [
                                      for(var member in Provider.of<Members>(context, listen: false).members)
                                        ListTile(
                                          title: Text(member.username, style: const TextStyle(fontFamily: 'Roboto')),
                                          onTap: (){
                                            trelloCard.addMember(member.id);
                                            Navigator.of(context).pop();
                                          },
                                        )
                                    ],
                                  ),
                                )
                            );
                          },
                          icon: const Icon(Icons.add),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: const NavigationBarComponent()
    );
  }
}