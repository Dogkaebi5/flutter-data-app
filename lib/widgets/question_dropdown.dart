import 'package:flutter/material.dart';

class QuestionDropDown extends StatefulWidget {
  final bool isEnabled;
  final String question;
  final List options;
  String? selected;
  final onChanged;
  QuestionDropDown({
    required this.isEnabled,
    required this.question,
    required this.options,
    required this.selected,
    required this.onChanged,
    super.key});

  @override
  State<QuestionDropDown> createState() => _QuestionDropDownState();
}

class _QuestionDropDownState extends State<QuestionDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: (widget.isEnabled)
          ? Colors.deepPurple.shade50
          : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.question,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8, right:8),
            child: DropdownButton(
              isExpanded: true,
              value: widget.selected,
              items: widget.options.map((e) => DropdownMenuItem(
                enabled: widget.isEnabled,
                value: e,
                child: Text(e))).toList(), 
              onChanged: (value) {
                setState(()=> widget.selected = value as String?);
                widget.onChanged(widget.selected);
              }
            ),
          ),
        ],
      ),
    );
  }
}