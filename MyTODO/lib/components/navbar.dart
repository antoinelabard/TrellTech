import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mytodo/service/services/user_info_service.dart';

class AppBarComponent extends AppBar {
  AppBarComponent({super.key})
      : super(
    backgroundColor: Colors.white,
    title: Consumer<TokenMember>(
      builder: (context, tokenMember, child) {
        return Container(
            alignment: Alignment.centerRight,
            child: Text(
              'Bonjour ${tokenMember.member?.fullName ?? 'Inconnu ?'} !',
              textAlign: TextAlign.end,
              textWidthBasis: TextWidthBasis.longestLine,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: Colors.black,
              ),
            )
        );
      },
    ),
  );
}