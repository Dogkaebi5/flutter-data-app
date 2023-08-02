import 'package:data_project/widgets/widget_style.dart';
import 'package:flutter/material.dart';

class DetailCard extends StatefulWidget {
  String title;
  String date;
  String point;
  var onTap;
  DetailCard({
    required this.title,
    required this.date,
    required this.point,
    this.onTap,
    super.key});

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Card(
        margin: EdgeInsets.all(1),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title,
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 4,),
                  Text(
                    widget.date.split(' ')[0], 
                    style: fontSmallGrey
                  ),
                ],
              ),
              Text(widget.point,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widget.point.split(' ')[0] == "+"
                    ? Colors.deepPurple.shade300
                    : Colors.red.shade300
                ),)
          ]),
        ),
      ),
    );
  }
}