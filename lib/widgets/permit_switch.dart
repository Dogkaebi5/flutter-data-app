import 'package:flutter/material.dart';

class PermitSwitch extends StatefulWidget {
  final String title;
  final bool hasValue;
  final bool switchValue;
  final onChanged;

  PermitSwitch({
    required this.title,
    required this.hasValue,
    required this.switchValue,
    required this.onChanged,
    super.key});

  @override
  State<PermitSwitch> createState() => _PermitSwitchState();
}

class _PermitSwitchState extends State<PermitSwitch> {
  @override
  Widget build(BuildContext context) {
    bool switchValue = widget.switchValue;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title, style: const TextStyle(color: Colors.black87, fontSize: 16)),
        Switch(
          value: switchValue, 
          onChanged: (widget.hasValue)?(value){
            setState(() => switchValue = value);
            widget.onChanged(value);
          }:null
        )
    ]);
  }
}