import 'package:flutter/material.dart';

class ListsComponent extends StatelessWidget {
  const ListsComponent({
    super.key,
    required this.cardTitle,
    required this.memberAvatar,
    required this.onTap,
  });

  final String cardTitle;
  final String memberAvatar;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: () {
            onTap();
          },
          tileColor: const Color(0xFF51CCF6),
          contentPadding: const EdgeInsets.all(16.0),
          style: ListTileStyle.list,
          title: Text(
            cardTitle,
            style: const TextStyle(
              fontFamily: 'Roboto',
              color: Color(0xff141946),
            ),
          ),
          trailing: CircleAvatar(
            backgroundImage: NetworkImage(memberAvatar),
          )
        ));
  }
}
