import 'package:flutter/material.dart';

class PermitSwitch extends StatefulWidget {
  final String title;
  final bool hasValue;
  bool switchValue;
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title, style: TextStyle(color: Colors.black87, fontSize: 16)),
        Switch(
          value: widget.switchValue, 
          onChanged: (widget.hasValue)?(value){
            setState(() => widget.switchValue = value);
            widget.onChanged(value);
          }:null
        )
    ]);
  }
}