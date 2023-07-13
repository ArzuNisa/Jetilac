import 'package:flutter/material.dart';
import 'package:testapp/screens/welcome_screen.dart';

class Success extends StatefulWidget {
  const Success({
    Key? key,
  }) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/images/green_tick-mark.png"),
            height: 200.0,
          ),
          Text(
            'Başarılı',
            style: TextStyle(color: Colors.black, fontSize: 30.0, height: 3.0),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Siparişin başarılı bir şekilde gerçekleştirildi.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WelcomeScreen(),
                ),
              );
            },
            child: Text('Tamam'),
          ),
        ],
      ),
    );
  }
}
