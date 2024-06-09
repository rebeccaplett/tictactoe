import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectfour_game/home_1.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GameScreen extends StatefulWidget {
  String player1;
  String player2;
  GameScreen({required this.player1, required this.player2});
  @override
  State<GameScreen> createState() => _GameSreenState();
}

class _GameSreenState extends State<GameScreen> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;

  @override
  void initState(){
    super.initState();
    _board = List.generate(3, (_) => List.generate(3, (_)=>""));
    _currentPlayer = "X";
    _winner = "";
    _gameOver = false;
  }

// Reset Game
  void _resetGame(){
    setState(() {
      _board = List.generate(3, (_) => List.generate(3, (_)=>""));
      _currentPlayer = "X";
      _winner = "";
      _gameOver = false;
    });

  }

  void _makeMove(int row, int col){
    if(_board[row][col] != "" || _gameOver){
      return;
    }

  setState(() {
    _board[row][col] = _currentPlayer;

    // Check for a winner (Simplified)
    for (int i = 0; i < 3; i++) {
      if (_board[row][i] != _currentPlayer) break;
      if (i == 2) {
        _winner = _currentPlayer;
        _gameOver = true;
      }
    }

    for (int i = 0; i < 3; i++) {
      if (_board[i][col] != _currentPlayer) break;
      if (i == 2) {
        _winner = _currentPlayer;
        _gameOver = true;
      }
    }

    if (_board[0][0] == _currentPlayer && _board[1][1] == _currentPlayer && _board[2][2] == _currentPlayer) {
      _winner = _currentPlayer;
      _gameOver = true;
    }

    if (_board[0][2] == _currentPlayer && _board[1][1] == _currentPlayer && _board[2][0] == _currentPlayer) {
      _winner = _currentPlayer;
      _gameOver = true;
    }

    // Switch players (Corrected)
    _currentPlayer = (_currentPlayer == "X") ? "O" : "X"; // Changed "0" to "O"

    // Check for a tie
    if (!_board.any((row) => row.any((cell) => cell == ""))) {
      _gameOver = true;
      _winner = "It's a tie!";
    }

      if(_winner != ""){
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
            btnOkText: "Play again",    
            title: _winner == "X" 
                ? widget.player1 + "Won!"
                : _winner == "O" 
                  ? widget.player2 + "Won!" 
                  : "Its a tie",
          btnOkOnPress: (){
            _resetGame();
          },
        ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF323D5B),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenHeight = constraints.maxHeight;
          double screenWidth = constraints.maxWidth;
          double boardSize = screenWidth < screenHeight
              ? screenWidth * 0.8
              : screenHeight * 0.6; // Adjust this factor as needed
          double cellSize = boardSize / 3;
          double fontSize = boardSize * 0.08; // Adjust for font size

          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              children: [
                SizedBox(height: screenHeight * 0.1), // Top padding
                Text(
                  "Turn: ${_currentPlayer == 'X' ? widget.player1 : widget.player2} ($_currentPlayer)",
                  style: TextStyle(
                    fontSize: fontSize * 1.5,
                    fontWeight: FontWeight.bold,
                    color: _currentPlayer == 'X' ? const Color(0xFFE25041) : const Color(0xFF1CBD9E),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05), // Spacing
                SizedBox(
                  width: boardSize,
                  height: boardSize,
                  child: GridView.builder(
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      int row = index ~/ 3;
                      int col = index % 3;
                      return GestureDetector(
                        onTap: () => _makeMove(row, col),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF0E1E3A),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Center(
                            child: Text(
                              _board[row][col],
                              style: TextStyle(
                                fontSize: cellSize * 0.8,
                                fontWeight: FontWeight.bold,
                                color: _board[row][col] == 'X' ? const Color(0xFFE25041) : const Color(0xFF1CBD9E),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.05), // Spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _resetGame,
                      child: Text("Reset Game", style: TextStyle(fontSize: fontSize)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement( 
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      },
                      child: Text("Restart Game", style: TextStyle(fontSize: fontSize)),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}