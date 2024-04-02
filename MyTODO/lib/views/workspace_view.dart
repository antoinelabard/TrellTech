import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:mytodo/service/services/boards_services.dart';
import 'package:mytodo/service/services/organization_service.dart';
import 'package:mytodo/components/navbar.dart';
import 'package:mytodo/components/appbar.dart';
import 'package:mytodo/components/button.dart';
import 'package:mytodo/components/card.dart';
import 'package:mytodo/components/titles.dart';
import 'package:mytodo/components/delete.dart';
import 'package:mytodo/components/update.dart';

class OrganizationScreen extends StatelessWidget {
  const OrganizationScreen({super.key, required this.orgId});
  final String? orgId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(),
      body: SingleChildScrollView(
        primary: true,
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Consumer<Organizations>(
          builder: (context, organizations, child) {
            var organization = organizations.organizationsById[orgId];
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: TitleComponent(text: organization?.displayName ?? "Pas despace de travail"),
                      ),
                      UpdateComponent(onPressed: (){
                        context.go('/edit-organization/${organization?.id}');
                      }),
                      DeleteComponent(onPressed: (){
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            title: const Text("Supprimer espace de travail"),
                            content: const Text("Sur??"),
                            actions: [
                              TextButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Annuler")
                              ),
                              TextButton(
                                  onPressed: (){
                                    organization?.delete();
                                    Navigator.of(context).pop();
                                    context.go('/home');
                                  },
                                  child: const Text("Supprimer")
                              ),
                            ],
                          );
                        });
                      })
                    ]
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                        "Description : ",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(20, 25, 70, 1),
                          fontFamily: 'Roboto',
                        )
                    ),
                    Text(
                      organization?.desc ?? "Pas de description",
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        color: Color.fromRGBO(20, 25, 70, 1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Membres : ",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(20, 25, 70, 1),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      organization?.membersCount.toString() ?? "0",
                      style: const TextStyle(
                        fontFamily: "Roboto",
                        color: Color.fromRGBO(20, 25, 70, 1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                const Text(
                  "Tableaux",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(20, 25, 70, 1),
                  ),
                ),
                Consumer<Boards>(
                    builder: (context, boards, child) {
                      var boardsByOrg = boards.boardsByOrganizationId[orgId];
                      return boardsByOrg == null
                          ? const Text(
                        "Pas de tableau",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color.fromRGBO(20, 25, 70, 1),
                        ),
                      )
                          : ListView.builder(itemBuilder: (context, index)
                      {
                        return CardComponent(
                          iconData: Icons.dataset_outlined,
                          title: boardsByOrg[index].name,
                          subtitle: boardsByOrg[index].desc == '' ? 'Pas de tableau' : boardsByOrg[index].desc,
                          onTap: (){
                            context.go('/board/${boardsByOrg[index].id}');
                          },
                        );
                      },
                        itemCount: boardsByOrg.length,
                        shrinkWrap: true,
                        primary: false,
                      );}
                ),
                const SizedBox(height: 20),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Button(text: 'Créer un tableau', iconName: Icons.add, onPressed: (){
                     context.go('/create-board');
                   }),
                 ],
               ),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const NavigationBarComponent(),
    );
  }
}