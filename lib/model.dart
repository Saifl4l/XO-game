import 'dart:math';
import 'package:play/var.dart';


class Player{
static const x="X";
static const o="O";

static List<int> Playerx=[];
static List<int> Playero=[];

}

extension ContinsAll on List{
  bool continsAll(int x, int y,[z]){
    if(z==null)
      return contains(x) && contains(y);
    else return contains(x) && contains(y) && contains(z) ;
  }
}

class Game{

void PlayGame(int index,String activPlayer){
  if(Var.activePlayer =="X"){
    Player.Playerx.add(index);
  }
  else{
    Player.Playero.add(index);
  }
}

  String CheckWinner(){
  String winner="";
  if(Player.Playerx.continsAll(0, 1, 2)||
      Player.Playerx.continsAll(3, 4, 5)||
      Player.Playerx.continsAll(6, 7, 8)||
      Player.Playerx.continsAll(0, 3, 6)||
      Player.Playerx.continsAll(1, 4, 7)||
      Player.Playerx.continsAll(2, 5, 8)||
      Player.Playerx.continsAll(1, 4, 8)||
      Player.Playerx.continsAll(2, 4, 6)) winner="X";

  else if(Player.Playero.continsAll(0, 1, 2)||
      Player.Playero.continsAll(3, 4, 5)||
      Player.Playero.continsAll(6, 7, 8)||
      Player.Playero.continsAll(0, 3, 6)||
      Player.Playero.continsAll(1, 4, 7)||
      Player.Playero.continsAll(2, 5, 8)||
      Player.Playero.continsAll(1, 4, 8)||
      Player.Playero.continsAll(2, 4, 6)) winner="O";

  else winner="";
  return winner;
  }


  Future autoplay(activePlayer) async{
  int index=0;
  List<int> empty=[];
  for(var i=0;i<9;i++){
    if(!(Player.Playerx.contains(i) || Player.Playero.contains(i))){
      empty.add(i);
    }
  }
  Random random=Random();
  int randomIndex = random.nextInt(empty.length);
  index=empty[randomIndex];
  PlayGame(index,activePlayer);

}
}