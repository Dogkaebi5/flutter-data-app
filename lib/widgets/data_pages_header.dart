import 'package:flutter/material.dart';

class DataPageHeader extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  const DataPageHeader({
    required this.title,
    required this.description,
    required this.icon,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Row(
          children: [
            Icon(icon, color: const Color.fromRGBO(126, 87, 194, 1), size: 32,),
            const SizedBox(width: 8,),
            Text(title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color.fromRGBO(126, 87, 194, 1),
            )),
        ],),
        const SizedBox(height: 4,),
        Text(description),
      ]
    );
  }
}