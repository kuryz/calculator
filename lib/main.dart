import 'package:Calc/widget/button_wiget.dart';
import 'package:Calc/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
 
void main() {
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Brand-Regular',
        accentColor: Color.fromRGBO(0, 0, 0, 0.5),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ); // MaterialApp
  }
}
 
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
 
class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '0';
  bool isDay = false;
  bool isThemeDark = true;
  //bool isThem
 
  // Array of button
  final List<String> buttons = [
    'AC',
    '+/-',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '6',
    '5',
    '4',
    '-',
    '1',
    '2',
    '3',
    '+',
    'r',
    '0',
    '.',
    '=',
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: new AppBar(
      //   title: new Text("Calculator"),
      // ), //AppBar
      backgroundColor: isThemeDark ? CalColors.colorDarkTheme : Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 20,),
                  Container(
                    width: 110,
                    margin: EdgeInsets.symmetric(horizontal:20),
                    padding: EdgeInsets.only(left: 17, right: 17, top: 11, bottom: 11),
                    decoration: BoxDecoration(
                      color: isThemeDark ? CalColors.colorDark : CalColors.colorLight,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => toggle(),
                          child: Icon(Icons.wb_sunny_outlined, color: isThemeDark ? CalColors.colorfade : CalColors.colorIconDark,)
                          ),
                        GestureDetector(
                          onTap: () => toggleD(),
                          child: isThemeDark ? Image.asset('asset/moon_light.png') : Image.asset('asset/moon_dark.png'),
                          // child: Icon(Icons.nights_stay_outlined, color: isThemeDark ? Colors.white : CalColors.colorfade2,)
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 70),
                  Container(
                    padding: EdgeInsets.only(right:20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: TextStyle(fontSize: 22, color: !isThemeDark ? Colors.black : Colors.white,),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right:15),
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer ?? 0,
                      style: TextStyle(
                          fontSize: 54,
                          color: !isThemeDark ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ]
              ),
            ),
          ),
          Container(
            height: 409,
            padding: EdgeInsets.symmetric(horizontal: 31),
            decoration: BoxDecoration(
              color: isThemeDark ? CalColors.colorDark : CalColors.colorLight,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) {
                // Clear Button
                if (index == 0) {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        userInput = '';
                        answer = '0';
                      });
                    },
                    buttonText: buttons[index],
                    color: isThemeDark ? CalColors.colorButton : CalColors.colorButtonLight,
                    textColor: CalColors.colorGreen,
                    bdrColor: isThemeDark,
                  );
                }

                // +/- button
                else if (index == 1) {
                  return MyButton(
                    buttonText: buttons[index],
                    color: isThemeDark ? CalColors.colorButton : CalColors.colorButtonLight,
                    textColor: CalColors.colorGreen,
                    bdrColor: isThemeDark,
                  );
                }
                // % Button
                else if (index == 2) {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        userInput += buttons[index];
                      });
                    },
                    buttonText: buttons[index],
                    color: isThemeDark ? CalColors.colorButton : CalColors.colorButtonLight,
                    textColor: CalColors.colorGreen,
                    bdrColor: isThemeDark,
                  );
                }
                // Delete Button
                else if (index == 16) {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        userInput =
                            userInput.substring(0, userInput.length - 1);
                      });
                    },
                    buttonText: buttons[index],
                    color: isThemeDark ? CalColors.colorButton : CalColors.colorButtonLight,
                    textColor: isThemeDark ? Colors.white : Colors.black,
                    bdrColor: isThemeDark,
                  );
                }
                // Equal_to Button
                else if (index == 19) {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        equalPressed();
                      });
                    },
                    buttonText: buttons[index],
                    color: isThemeDark ? CalColors.colorButton : CalColors.colorButtonLight,
                    textColor: CalColors.colorRed,
                    bdrColor: isThemeDark,
                  );
                }

                //  other buttons
                else {
                  return MyButton(
                    buttontapped: () {
                      setState(() {
                        userInput += buttons[index];
                      });
                    },
                    buttonText: buttons[index],
                    color: isOperator(buttons[index])
                        ? isThemeDark ? CalColors.colorButton : CalColors.colorButtonLight
                        : isThemeDark ? CalColors.colorButton : CalColors.colorButtonLight,
                    textColor: isOperator(buttons[index])
                        ? CalColors.colorRed
                        : isThemeDark ? Colors.white : Colors.black,
                    bdrColor: isThemeDark,
                  );
                }
              }
            ), // GridView.builder
          ),
        ],
      ),
    );
  }
 
  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }
 
// function to calculate the input operation
  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('x', '*');
 
    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toString();
  }

  void toggle() {
    setState(() {
      if (isThemeDark) {
        isThemeDark = false;
      } 
    });
  }
  void toggleD(){
    setState(() {
      if(!isThemeDark) {
        isThemeDark = true;
      }
    });
  }
}