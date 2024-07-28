import 'package:flutter/material.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Todo Screen',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}