import 'package:flutter/material.dart';

class ScaffoldMsg extends StatelessWidget {
  final String message;

  const ScaffoldMsg({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: Colors.redAccent),
      ),
    );
  }
}
