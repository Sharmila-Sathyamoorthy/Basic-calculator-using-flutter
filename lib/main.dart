import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

// Main app widget
class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prodigy Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.teal,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Home Screen with Logo and Auto-navigation
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the CalculatorScreen after 6 seconds
    Future.delayed(Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CalculatorScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calculate,
              color: Colors.tealAccent,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Prodigy Calculator',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Calculator Screen with Advanced Functions and Overflow Fix
class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _display = '';
  String _result = '';

  void _onPressed(String text) {
    setState(() {
      _display += text;
    });
  }

  void _clear() {
    setState(() {
      _display = '';
      _result = '';
    });
  }

  void _calculate() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_display);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        _result = eval.toString();
      });
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }

  Widget _buildButton(String text, {Color color = Colors.grey}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: text == 'C'
              ? _clear
              : text == '='
                  ? _calculate
                  : () => _onPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PRODIGY'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Color(0xFF1E1E1E),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: Text(
              _display,
              style: TextStyle(fontSize: 28, color: Colors.white70),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: Text(
              _result,
              style: TextStyle(fontSize: 40, color: Colors.tealAccent),
            ),
          ),
          Divider(color: Colors.white24, height: 1),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton('sin(', color: Colors.teal),
                    _buildButton('cos(', color: Colors.teal),
                    _buildButton('tan(', color: Colors.teal),
                    _buildButton('√', color: Colors.teal),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('log(', color: Colors.teal),
                    _buildButton('(', color: Colors.teal),
                    _buildButton(')', color: Colors.teal),
                    _buildButton('÷', color: Colors.teal),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('×', color: Colors.teal),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('-', color: Colors.teal),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('+', color: Colors.teal),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('0'),
                    _buildButton('.'),
                    _buildButton('=', color: Colors.tealAccent),
                    _buildButton('C', color: Colors.redAccent),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
