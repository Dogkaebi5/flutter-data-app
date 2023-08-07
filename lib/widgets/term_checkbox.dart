import 'package:flutter/material.dart';

class TermCheckbox extends StatefulWidget {
  final String text;
  final bool isLink;
  final bool isRequired;
  bool isChecked;
  final textOnTap;
  final checkboxOnChanged;

  TermCheckbox({
    required this.text,
    required this.isLink,
    required this.isRequired,
    required this.isChecked,
    required this.textOnTap,
    required this.checkboxOnChanged,
    super.key});

  @override
  State<TermCheckbox> createState() => _TermCheckboxState();
}

class _TermCheckboxState extends State<TermCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        (widget.isLink)
        ?InkWell(
          onTap: ()=> widget.textOnTap,
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: .8,
            ))),
            child: Text(widget.text)))
        :Text(widget.text),
        if (widget.isRequired) const Text(" (필수)", style: TextStyle(color: Colors.deepPurple)),
        const Spacer(),
        Checkbox(
          value: widget.isChecked, 
          onChanged: (value){
            setState(() => widget.isChecked = value!);
            widget.checkboxOnChanged(value);
          }
        )
      ],
    );
  }
}