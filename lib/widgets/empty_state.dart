import 'package:flutter/widgets.dart';

class EmptyState extends StatelessWidget {
  final String message;

  const EmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) => Center(
        child: Text(message),
      );
}
