import 'package:flutter/material.dart';
import 'package:game1/board_tile.dart';
import 'package:game1/showDialogue.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BoardTile> tileList;

  var currentPlayer;

  int counter;
  BoardTile presentTile;
  BoardTile nextTile;
  bool blueWinner;
  bool redWinner;

  @override
  void initState(){
    super.initState();
    tileList = doInit();
  }


  void increaseCounter (BoardTile old){
    setState(() {
      counter ++;
      presentTile = old;
    });
  }


  void playMove(BoardTile current, BoardTile next){
    setState(() {

      if(isNeighbor(current, next) && next.tileColor == Colors.green[100] ){
        if(currentPlayer == 1){
       
        next.tileColor = Colors.red;
        currentPlayer =2;
        current.tileColor = Colors.green[100];
        
        
        } else {
        current.tileColor = Colors.green[100];
        next.tileColor = Colors.blue;
        currentPlayer = 1;
        

      }
      }
      counter++;
    
      checkWinner();

    });
  }

  
  bool isNeighbor(BoardTile first, BoardTile second){
   
    if(first.idX==second.idX || first.idY == second.idY){
      return false;
    }

    if((first.idX -second.idX).abs()==1 ||(first.idY-second.idY).abs() ==1){
      return true;
    }

    return false;
  }



  void checkWinner(){
    blueWinner = true;
    redWinner = true;
    for(var j =0; j<6; j++){
      if(tileList[j].tileColor != Colors.red){
        redWinner =false;
      }
      if(tileList[24-j].tileColor != Colors.blue){
        blueWinner =false;
      }
    }

    if(tileList[9].tileColor!= Colors.red){
      redWinner = false;
    }

    if(tileList[15].tileColor != Colors.blue){
      blueWinner = false;
    }

    if(blueWinner || redWinner){
      String congrats = "";
      if(currentPlayer ==1){
        congrats= "Player 2 with blue Color is winner";
      } else {
        congrats= "Player 1  with red Color is winner";
      }
      showDialog(
            context: context,
            builder: (_) => new WinnerDialogue("Game Ends", resetBoard,congrats));
      
    }
  }

  void resetBoard() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      tileList = doInit();
    });
  }
  List<BoardTile> doInit(){

    currentPlayer =1;
    counter =0;
    var gameButtons = <BoardTile>[];

    for (var i = 0; i<5; i++){
      for(var j = 0; j<5; j ++)
      gameButtons.add(new BoardTile(idX:i, idY:j, tileColor: Colors.green[100]));
    }

    for(var j =0; j<6; j++){
      gameButtons[j].tileColor = Colors.blue;
      gameButtons[24-j].tileColor =Colors.red;
    }
    gameButtons[9].tileColor =Colors.blue;
    gameButtons[15].tileColor =Colors.red;

    return gameButtons;
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Five Field kono"),
      ),
      body: Column(
        children: <Widget>[
          new Expanded(
            child: new GridView.builder(
            padding: const EdgeInsets.all(15.0),
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 1,
              crossAxisSpacing: 50,
              mainAxisSpacing: 50
            ),
            itemCount: tileList.length,
            itemBuilder: (context,i) => new SizedBox(
              width: 1,
              height: 1,
              child: new RaisedButton(
                padding: const EdgeInsets.all(8.0),
                

                onPressed: (){
                  if(counter%2 ==0){
                    if(currentPlayer == 1 && tileList[i].tileColor == Colors.red){
                      increaseCounter(tileList[i]);
                    }

                    if(currentPlayer == 2 && tileList[i].tileColor == Colors.blue){
                      increaseCounter(tileList[i]);
                    } 
                  } else { 
                    playMove( presentTile, tileList[i]);
                    if(currentPlayer == 1 && tileList[i].tileColor == Colors.red){
                      increaseCounter(tileList[i]);
                      counter =1;
                    } else if(currentPlayer == 2 && tileList[i].tileColor == Colors.blue){
                      increaseCounter(tileList[i]);
                      counter =1;
                    } 
                  }
                },
                color: tileList[i].tileColor,
                disabledColor: tileList[i].tileColor,

              )
            )
          ),
          ),

            new RaisedButton(
              child: new Text(
                "Reset",
                style: new TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              color: Colors.red,
              padding: const EdgeInsets.all(20.0),
              onPressed: resetBoard,
            )
        ],
      )
    );
  }
}