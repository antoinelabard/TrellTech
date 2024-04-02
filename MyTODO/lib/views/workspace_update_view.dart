import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:mytodo/service/services/organization_service.dart';
import 'package:mytodo/components/navbar.dart';
import 'package:mytodo/components/titles.dart';
import 'package:mytodo/components/text_input.dart';

import '../components/button.dart';

class EditOrganizationScreen extends StatefulWidget {
  final String? orgId;
  const EditOrganizationScreen({super.key, required this.orgId});

  @override
  EditOrganizationScreenState createState() => EditOrganizationScreenState();
}

class EditOrganizationScreenState extends State<EditOrganizationScreen> {
  String? newOrgName;
  String? newOrgDesc;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(),
      body: Consumer<Organizations>(
        builder: (builder, organizations, child) {
          var organization = organizations.organizationsById[widget.orgId];
          return widget.orgId == null
              ? const Text("Pas despace de travail")
              : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleComponent(text: 'modifier espace de travail ${organization?.displayName}'),
                const SizedBox(height: 40),
                TextComponent(
                    name: "Name",
                    helperText: '${organization?.displayName}',
                    onTextChanged: (String value) {
                      setState(() {
                        newOrgName = value;
                      });
                    }),
                const SizedBox(height: 40),
                TextComponent(
                    name: "Description",
                    helperText: '${organization?.desc}',
                    onTextChanged: (String value) {
                      setState(() {
                        newOrgDesc = value;
                      });
                    }),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(
                        iconName: Icons.save,
                        text: 'Sauvegarder',
                        onPressed: () {
                          if (newOrgName == null || newOrgDesc == null) {
                            setState(() {
                              error = 'remplir le formulaire';
                            });
                            return;
                          }
                          if(newOrgName == organization!.displayName && newOrgDesc == organization.desc){
                            setState(() {
                              error = 'Pas de changement';
                            });
                            return;
                          }
                          if(newOrgName == null && newOrgDesc != null && newOrgDesc != organization.desc){
                            newOrgName = organization.displayName;
                          }
                          if(newOrgName != null && newOrgDesc == null && newOrgName != organization.displayName){
                            newOrgDesc = organization.desc;
                          }
                          organization.update(
                              displayName: newOrgName,
                              desc: newOrgDesc
                          );
                          context.go('/org/${widget.orgId}');
                        }),
                    const SizedBox(width: 20),
                    TextButton(
                        style: ButtonStyle(

                          padding: MaterialStateProperty.all(
                            const EdgeInsets.all(16.0),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.lightBlueAccent
                          ),
                        ),
                        onPressed: (){
                          context.go('/org/${widget.orgId}');
                        },
                        child:const Row(
                          children: [
                            Icon(Icons.arrow_back_ios, color: Colors.white,),
                            Text(" Retour", style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Roboto',
                                color: Colors.white
                            )),
                          ],
                        ))
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    error.isEmpty ? "" : error,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.redAccent,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

