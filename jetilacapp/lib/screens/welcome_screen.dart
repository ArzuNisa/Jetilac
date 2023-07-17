import 'package:flutter/material.dart';
import 'package:testapp/screens/login_page_view.dart';
import 'package:testapp/screens/pharmacist_loginpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jetilaç',
      theme: ThemeData(
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final Shader linearGradient = const LinearGradient(
  colors: <Color>[Colors.lightBlueAccent, Colors.blueGrey],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
         Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 40,),
                      SizedBox(width: 200,height:200,child: Image(image: AssetImage('assets/images/1c5cca94-72d8-4f35-bff2-3b8ff292b898.jpg'))),
                      SizedBox(height: 40,),
                      Align(alignment: Alignment.centerLeft,child: Text("Jetilaç",style: TextStyle(fontSize: 55,fontWeight: FontWeight.w800,foreground: Paint()..shader = linearGradient),)),
                      Align(alignment: Alignment.centerLeft,child: Text("Hoşgeldiniz",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              elevatedButtonWidget(title: "Kullanıcı",),
              const SizedBox(height: 15,),
              elevatedButtonWidget(title: "Eczacı"),
            ],
          ),

      /*Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hoş Geldiniz!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPageView()),
                );
              },
              child: Text('Kullanıcılar İçin Giriş'),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PharmacistLoginPage()),
                );
              },
              child: Text('Eczacılar İçin Giriş'),
            ),
          ],
        ),
      ),*/
    );
  }
}

class elevatedButtonWidget extends StatefulWidget {
  final String title;
  elevatedButtonWidget({
    super.key,required this.title
  });

  @override
  State<elevatedButtonWidget> createState() => _elevatedButtonWidgetState();
}

class _elevatedButtonWidgetState extends State<elevatedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {
      if(widget.title=="Kullanıcı"){
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const LoginPageView()),
          );
        });
      }
      else{
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const PharmacyLogin()),
          );
        });
      }
    }, child:Container(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.person,size: 50,),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${widget.title}",style: const TextStyle(fontSize: 20),),
                  const Text("Girişi",style: TextStyle(fontSize: 17),)
                ],
              ),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      elevation: MaterialStateProperty.all(20),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),)
    ),);
  }
}
