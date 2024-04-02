import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../service/services/boards_services.dart';
import 'card.dart';

class BoardsList extends StatelessWidget {
  const BoardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Boards>(
      builder: (context, boards, child) {
        return ListView.builder(
          itemCount: boards.boards.length,
          shrinkWrap: true,
          primary: false,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return CardComponent(
              iconData: Icons.data_usage,
              title: boards.boards[index].name,
              subtitle: boards.boards[index].desc == '' ? 'Pas de description' : boards.boards[index].desc,
              onTap: () => {
                context.go('/board/${boards.boards[index].id}')
              },
            );
          },
        );
      },
    );
  }
}