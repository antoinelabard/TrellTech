import 'package:flutter/material.dart';

class UpdateComponent extends IconButton {
  const UpdateComponent({
    super.key,
    required VoidCallback super.onPressed,
  }) : super(
          icon: const Icon(Icons.update_outlined),
          iconSize: 30,
          color: const Color(0xff678dec),
        );
}

class TestButton extends StatelessWidget {
  const TestButton({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: UpdateComponent(
            onPressed: () {
              print('Update TEST');
            },
          ),
        ),
      ),
    );
  }
}
