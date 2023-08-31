import 'package:data_project/widgets/widget_style.dart';
import 'package:flutter/material.dart';

class DetailCard extends StatefulWidget {
  final String title;
  final DateTime date;
  final int point;
  final onTap;
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
    String detailDate = widget.date.toString().split(' ')[0];
    String detailsPoint = (widget.point > 0) ? "+ ${widget.point}" : "- ${widget.point}";

    return InkWell(
      onTap: widget.onTap,
      child: Card(
        margin: const EdgeInsets.all(1),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4,),
                  Text(detailDate, style: fontSmallGrey),
                ],
              ),
              Text(detailsPoint,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: detailsPoint.split(' ')[0] == "+"
                    ? const Color.fromRGBO(149, 117, 205, 1)
                    : const Color.fromRGBO(229, 115, 115, 1)
                ),)
          ]),
        ),
      ),
    );
  }
}