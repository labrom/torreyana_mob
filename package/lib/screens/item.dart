import 'package:flutter/material.dart';

class ItemScreen extends StatelessWidget {

  const ItemScreen({
    required this.itemId, super.key,
  });
  final String itemId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Detail screen for $itemId'),
      ),
    );
  }
}
