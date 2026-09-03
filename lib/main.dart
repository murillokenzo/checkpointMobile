import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const int maxCapacity = 50;

  int count = 0;

  void decrement() {
    if (count > 0) {
      setState(() {
        count--;
      });
    }
  }

  void increment() {
    if (count < maxCapacity) {
      setState(() {
        count++;
      });
    }
  }

  bool get isEmpty => count == 0;

  bool get isFull => count == maxCapacity;

  bool get isAlmostFull => count >= maxCapacity * 0.8;

  String get situationMessage {
    if (isEmpty) {
      return "Cinema vazio";
    } else if (isFull) {
      return "Cinema lotado";
    } else if (isAlmostFull) {
      return "Atenção: cinema quase cheio";
    } else {
      return "Pode entrar";
    }
  }

  Color get situationColor {
    if (isFull) {
      return Colors.red;
    } else if (isAlmostFull) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cinema_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withAlpha(130),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "CONTROLE DE LOTAÇÃO",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 10),

              Text(
                "CINEMA",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 30),

              Text(
                situationMessage,
                style: TextStyle(
                  fontSize: 24,
                  color: situationColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 100,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                "pessoas no local",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),

              SizedBox(height: 10),

              Text(
                "Capacidade máxima: $maxCapacity pessoas",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),

              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: isEmpty ? null : decrement,
                    style: TextButton.styleFrom(
                      backgroundColor: isEmpty
                          ? Colors.white.withAlpha(90)
                          : Colors.white,
                      fixedSize: Size(120, 45),
                    ),
                    child: Text(
                      "Saiu",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),

                  SizedBox(width: 20),

                  TextButton(
                    onPressed: isFull ? null : increment,
                    style: TextButton.styleFrom(
                      backgroundColor: isFull
                          ? Colors.white.withAlpha(90)
                          : Colors.white,
                      fixedSize: Size(120, 45),
                    ),
                    child: Text(
                      "Entrou",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
