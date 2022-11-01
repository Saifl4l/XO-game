import 'package:flutter/material.dart';
import 'package:play/model.dart';
import 'package:play/var.dart';

class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SwitchListTile.adaptive(
                title: const Text("Tow Player",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,)),
                  value: Var.isSwitched,
                  onChanged: (newValue){
                  Var.isSwitched = newValue;
                  setState(() {

                  });
                  }),
            ),

            SizedBox(height: 15,),
            Text("It's ${Var.activePlayer} turn".toLowerCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 35,)),

            SizedBox(height: 55,),
            Expanded(
              child:GridView.count(
                  padding:const EdgeInsets.all(15),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 1.0,
                  crossAxisCount: 3,
                  children: List.generate(9, (index) => GestureDetector(
                    onTap:Var.gameOver? null: ()=> _onTap(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).shadowColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child:  Text(
                          Player.Playerx.contains(index)?
                            "X":Player.Playero.contains(index)?"O":" ",

                            style:  TextStyle(
                              color:Player.Playerx.contains(index)?Colors.blue:Colors.pinkAccent,
                              fontSize: 35,)),
                      ),
                    ),
                  ))
              ),
            ),

            Text(Var.result,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 35,)),
            SizedBox(height: 15,),

            GestureDetector(
              onTap: (){
                setState(() {
                  Player.Playerx=[];
                  Player.Playero=[];
                   Var.activePlayer="x";
                   Var.gameOver=false;
                   Var.turn=0;
                   Var.result=" ";
                });
              },
              child: Container(
                width:170,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).splashColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:const [
                    Icon(Icons.reply),
                    Text("Repeat the game"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 35,),
          ],
        ),
      ),
    );
  }

  _onTap(int index) async {
    if((Player.Playerx.isEmpty || !Player.Playerx.contains(index)) &&
        (Player.Playero.isEmpty || !Player.Playero.contains(index))) {
      Var.game.PlayGame(index,Var.activePlayer);
      Update();

      if(!Var.isSwitched && !Var.gameOver){
        await Var.game.autoplay(Var.activePlayer);
        Update();
      }
    }

  }

  void Update() {
     setState(() {
      Var.activePlayer = (Var.activePlayer =="X")?"O":"X";
      Var.turn++;

      String winnerplayer=Var.game.CheckWinner();
      if(winnerplayer != ""){
        Var.gameOver=true;
        Var.result="$winnerplayer is the winner";
      }
      else if(!Var.gameOver && Var.turn==9){
        Var.result ="It\'s Draw";
      };
    });
  }
}
