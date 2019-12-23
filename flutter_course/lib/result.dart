import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;
  String get resultPhrase{
    var resultText = "You did it";
    if(resultScore<= 8){
      resultText = 'You are awesome and innocent';

    } else if(resultScore<500){
      resultText = "You nailed it";
    } else {
      resultText = "Excellence";
    }
    return resultText;
  }
  Result(this.resultScore, this.resetHandler);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(resultPhrase,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)
          ),
          FlatButton(child: Text('Restart Quiz'), onPressed: resetHandler,)
        ],
      )
    );
  }
}
