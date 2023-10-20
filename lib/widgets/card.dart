import 'package:flutter/material.dart';

class RemiCard extends StatefulWidget {
  const RemiCard({super.key, required this.imgSrc, required this.serviceName});
  final String imgSrc;
  final String serviceName;




  @override
  State<RemiCard> createState() => _RemiCardState();
}

class _RemiCardState extends State<RemiCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.1,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              child: Image.network(
                widget.imgSrc,
                width: 191,
                height: 136,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Text(
                widget.serviceName,
                overflow: TextOverflow.ellipsis,
              ),
              )
            ],
          )
        ],
      ),
    );
  }
}