import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String option, des, correctAnswer, optionSelected;
  OptionTile(
      {@required this.option,
      @required this.des,
      @required this.correctAnswer,
      @required this.optionSelected});

  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(children: [
        Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              border: Border.all(
                  color: widget.des == widget.optionSelected
                      ? widget.optionSelected == widget.correctAnswer
                          ? Colors.blue
                          : Colors.blue
                      : Colors.grey,
                  width: 1.4),
              borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.center,
            child: Text("${widget.option}",
                style: TextStyle(
                  color: widget.optionSelected == widget.des
                      ? widget.correctAnswer == widget.optionSelected
                          ? Colors.blue
                          : Colors.blue
                      : Colors.grey,
                ))),
        SizedBox(width: 8),
        Text(
          widget.des,
          style: TextStyle(fontSize: 16, color: Colors.black54),
        )
      ]),
    );
  }
}
