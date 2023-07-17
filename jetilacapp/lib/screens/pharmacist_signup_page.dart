import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testapp/screens/pharmacist_loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: PharmacistRegisterPage(),
    );
  }
}

class PharmacistRegisterPage extends StatelessWidget {
  PharmacistRegisterPage({Key? key}) : super(key: key);

  final pharmacyNameController = TextEditingController();
  final pharmacyEmailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Colors.lightBlueAccent, Colors.blueGrey],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 250.0, 80.0));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              const _iconPharmacy(),
              SizedBox(height: 25),
              Text(
                "Eczacı Kayıt",
                style: TextStyle(foreground: Paint()..shader = linearGradient, fontSize: 25,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 25),
              PharmacyNameTextField(
                hintText: "Eczane Adı",
                controller: pharmacyNameController,
              ),
              SizedBox(height: 15),
              PharmacyEmailTextField(
                hintText: "E-posta",
                controller: pharmacyEmailController,
              ),
              SizedBox(height: 15),
              PhoneNumberTextField(
                hintText: "Telefon Numarası",
                controller: phoneNumberController,
              ),
              SizedBox(height: 15),
              UserNameTextField(
                hintText: "Şifre",
                controller: passwordController,
                obscureText: true,
              ),
              SizedBox(height: 25),
              SizedBox(
                height: 65,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    if (pharmacyNameController.text.isNotEmpty &&
                        pharmacyEmailController.text.isNotEmpty &&
                        phoneNumberController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      _handleSignUp(context);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Hata'),
                            content: Text(
                              'Lütfen tüm alanları doldurun.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Tamam'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

                  ),
                  child: const Text("Kayıt Ol",style: TextStyle(fontSize: 17,letterSpacing: 1),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignUp(BuildContext context) async {
    final auth = FirebaseAuth.instance;

    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: pharmacyEmailController.text,
        password: passwordController.text,
      );

      await userCredential.user!.updateDisplayName(pharmacyNameController.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PharmacyLogin(),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Kayıt Olma Hatası'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    }
  }
}

class _iconPharmacy extends StatelessWidget {
  const _iconPharmacy({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Icon(
          Icons.local_pharmacy_rounded,
          size: 100,
          color: Colors.lightBlueAccent,
        ),
      ),
    );
  }
}

class PharmacyNameTextField extends StatelessWidget {
  const PharmacyNameTextField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.local_pharmacy),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.grey,width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.grey,width: 2),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          labelText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}

class PharmacyEmailTextField extends StatelessWidget {
  const PharmacyEmailTextField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          enabledBorder: const OutlineInputBorder(

            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.grey,width: 2),
          ),
          focusedBorder: OutlineInputBorder(

            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.grey,width: 2),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          labelText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}

class PhoneNumberTextField extends StatelessWidget {
  const PhoneNumberTextField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          enabledBorder: const OutlineInputBorder(

            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.grey,width: 2),
          ),
          focusedBorder: OutlineInputBorder(

            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.grey,width: 2),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          labelText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}

class UserNameTextField extends StatelessWidget {
  const UserNameTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.obscureText,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.password),
          enabledBorder: const OutlineInputBorder(

            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.grey,width: 2),
          ),
          focusedBorder: OutlineInputBorder(

            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.grey,width: 2),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          labelText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
