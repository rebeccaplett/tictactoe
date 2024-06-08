import 'package:connectfour_game/game_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // This widget is the root of your application.
  @override
  State<HomeScreen> createState() => _HomeScreenState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}


class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState> ();

  final TextEditingController player1Controller = TextEditingController();
  final TextEditingController player2Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF323D5B),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text("Enter Players Name",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )
            ),
            SizedBox(height: 20),
            Padding(
              padding:EdgeInsets.all(15),
              child: TextFormField(
                controller: player1Controller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ), //OutlineInputBorder
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)
                    ), //OutlineInputBorder
                     enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                    ), //OutlineInputBorder
                     errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)
                    ), //OutlineInputBorder
                    hintText: "Player 1 Name",
                    hintStyle: TextStyle(color: Colors.white)

                  ), //InputDecoration
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Please enter player 1 name";
                    }
                    return null;
                  },
                ), //TextFormField
            ), //Padding
            
            
            Padding(
              padding:EdgeInsets.all(15),
              child: TextFormField(
                controller: player2Controller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ), //OutlineInputBorder
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)
                    ), //OutlineInputBorder
                     enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                    ), //OutlineInputBorder
                     errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)
                    ), //OutlineInputBorder
                    hintText: "Player 2 Name",
                    hintStyle: TextStyle(color: Colors.white)

                  ), //InputDecoration
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Please enter player 2 name";
                    }
                    return null;
                  },
                ), //TextFormField
            ), 
            SizedBox(height: 20),
            InkWell(
              onTap: (){
                if (_formKey.currentState!.validate()){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameSreen(
                          player1: player1Controller.text, 
                          player2: player2Controller.text
                        ),
                      ));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                child: Text("Start Game",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            )
          ],
        ), //Column
      ), //Form
    ); //Scaffold
  }
}
