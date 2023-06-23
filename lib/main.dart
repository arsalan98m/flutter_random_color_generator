import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Random Color Generator',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 1. Define the hex list containing the hexadecimal digits
  final hex = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, "A", "B", "C", "D", "E", "F"];

  // 2. Creating an instance of the `Random` class from the `dart:math` library.
  Random random = Random();

  // 3. Define a function called getRandomNumber that takes no arguments.
  //  this function returns a random index within the range of the hex list.
  int getRandomNumber() {
    return random.nextInt(hex.length);
  }

  // 4. `_backgroundColor` holds the value of the generated color, which is
  // a string consisting of six hexadecimal characters. the `_backgroundColor`
  // variable is updated using `setState` to trigger a UI rebuild  and reflect
  // the new color on the background.
  var _backgroundColor = "0xffFFFFFF";

  // 5 .The `generateRandomColor` function generates a random six-character
  // hexadecimal color code by appending random values from the `hex` list.
  // The `setState` method is called to update the value of `_backgroundColor`,
  // triggering a rebuild of the UI and setting the background color of the
  // generated color
  void generateRandomColor() {
    var hexColor = "0xff";
    for (var i = 0; i < 6; i++) {
      hexColor += "${hex[getRandomNumber()]}";
    }

    _backgroundColor = hexColor;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: generateRandomColor,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(int.parse(_backgroundColor)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Hello there",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: _backgroundColor))
                      .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("color is copied to clipboard"),
                      ),
                    );
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: 80,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: const Color(0xff222222),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                          text: "Tap Here to Copy Color : ",
                          style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: _backgroundColor,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(
                              int.parse(_backgroundColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
