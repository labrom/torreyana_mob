import 'package:flutter/widgets.dart';

class EmptyState extends StatelessWidget {

  const EmptyState({required this.message, super.key});
  final String message;

  @override
  Widget build(BuildContext context) => Center(
        child: Text(message),
      );
}
