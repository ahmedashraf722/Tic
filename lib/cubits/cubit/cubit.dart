import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictac/cubits/state/state.dart';
import 'package:tictac/game_logic/game_logic.dart';

class TicCubit extends Cubit<TicStates> {
  TicCubit() : super(TicInitialState());

  static TicCubit get(BuildContext context) => BlocProvider.of(context);

  bool isSwitched = false;

  void switchedPlayers(bool value) {
    isSwitched = value;
    emit(TicSwitchTurnState());
  }

  String activePlayer = 'X';
  String result = '';
  bool gameOver = false;
  int turn = 0;

  void repeatGame() {
    Player.playerX = [];
    Player.playerO = [];
    activePlayer = 'X';
    gameOver = false;
    turn = 0;
    result = '';
    emit(TicRepeatGameState());
  }

  Game game = Game();

  void onTap(int index) async {
    if ((!Player.playerX.contains(index) || Player.playerX.isEmpty) &&
        (!Player.playerO.contains(index) || Player.playerO.isEmpty)) {
      game.playGame(index, activePlayer);
      activePlayer = (activePlayer == 'X') ? 'O' : 'X';
      turn++;
      String winnerPlayer = game.checkWinner();
      if (winnerPlayer != 'D') {
        gameOver = true;
        result = '$winnerPlayer is the Winner';
      } else if (!gameOver && turn == 9) {
        result = 'It\'s Draw';
      }
      if (!isSwitched && !gameOver && turn != 9) {
        await game.autoPlayer(activePlayer);
        activePlayer = (activePlayer == 'X') ? 'O' : 'X';
        turn++;
        String winnerPlayer = game.checkWinner();
        if (winnerPlayer != 'D') {
          gameOver = true;
          result = '$winnerPlayer is the Winner';
        } else if (!gameOver && turn == 9) {
          result = 'It\'s Draw';
        }
      }
      emit(TicActiveGameState());
    }
  }
}
