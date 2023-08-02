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
        SizedBox(height: 40),
        Row(
          children: [
            Icon(icon, color: Colors.deepPurple.shade400, size: 32,),
            SizedBox(width: 8,),
            Text(title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.deepPurple.shade400,
            )),
        ],),
        SizedBox(height: 4,),
        Text(description),
      ]
    );
  }
}