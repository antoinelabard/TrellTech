import 'package:flutter/material.dart';

class DeleteComponent extends IconButton {
  const DeleteComponent({
    super.key,
    required VoidCallback super.onPressed,
  }) : super(
          icon: const Icon(Icons.delete_outline_outlined),
          iconSize: 30,
          color: const Color.fromARGB(255, 213, 48, 3),
        );
}

class TestButton extends StatelessWidget {
  const TestButton({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: DeleteComponent(
            onPressed: () {
              print('Valide boutin delete TEST');
            },
          ),
        ),
      ),
    );
  }
}
