import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_page_view.dart';

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
      home: RegisterPageView(),
    );
  }
}

class RegisterPageView extends StatelessWidget {
  RegisterPageView({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              _sizedBox50(),
              const _iconPerson(),
              _sizedBox20(),
              Text(
                "Kayıt Ol",
                style: TextStyle(color: Colors.grey[700], fontSize: 20),
              ),
              _sizedBox25(),
              UserNameTextField(
                hintText: "Ad",
                controller: nameController,
                obscureText: false,
              ),
              _sizedBox10(),
              UserNameTextField(
                hintText: "Soyad",
                controller: surnameController,
                obscureText: false,
              ),
              _sizedBox10(),
              UserNameTextField(
                hintText: "E-posta",
                controller: emailController,
                obscureText: false,
              ),
              _sizedBox10(),
              UserNameTextField(
                hintText: "Şifre",
                controller: passwordController,
                obscureText: true,
              ),
              _sizedBox10(),
              SizedBox(
                height: 65,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      _handleSignUp(context);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Hata'),
                            content: Text(
                                'E-posta ve şifre alanları boş bırakılamaz.'),
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
                    shape: const StadiumBorder(),
                    primary: Colors.black,
                  ),
                  child: const Text("Kayıt Ol"),
                ),
              ),
              _sizedBox50(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Zaten hesabınız var mı?",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Giriş yap",
                      style: TextStyle(color: Colors.blue[800]),
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

  SizedBox _sizedBox10() => const SizedBox(
        height: 10,
      );

  SizedBox _sizedBox25() => const SizedBox(
        height: 25,
      );

  SizedBox _sizedBox20() => const SizedBox(
        height: 20,
      );

  SizedBox _sizedBox50() => const SizedBox(
        height: 50,
      );

  Future<void> _handleSignUp(BuildContext context) async {
    final auth = FirebaseAuth.instance;

    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await userCredential.user!.updateDisplayName(
          '${nameController.text} ${surnameController.text}');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPageView(),
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

class _iconPerson extends StatelessWidget {
  const _iconPerson({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Icon(
          Icons.person,
          size: 100,
          color: Colors.black,
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
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
