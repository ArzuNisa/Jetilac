import 'package:flutter/material.dart';

import 'HomePage.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({Key? key});

  @override
  _LoginPageViewState createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                "𝐉𝐞𝐭ilaca Hoşgeldin",
                style: TextStyle(color: Colors.grey[700], fontSize: 20),
              ),
              _sizedBox25(),
              UserNameTextField(
                hintText: "Kullanıcı Adı",
                controller: usernameController,
                obscureText: false,
              ),
              _sizedBox10(),
              UserNameTextField(
                hintText: "Şifre",
                controller: passwordController,
                obscureText: true,
              ),
              const _passwordTextButton(),
              _sizedBox10(),
              SizedBox(
                height: 65,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    String username = "admin";
                    String password = "admin123";

                    String enteredUsername = usernameController.text;
                    String enteredPassword = passwordController.text;

                    if (enteredUsername.isEmpty || enteredPassword.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Kullanıcı adı ve şifre alanları boş bırakılamaz."),
                        ),
                      );
                    } else if (enteredUsername == username &&
                        enteredPassword == password) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Geçersiz kullanıcı adı veya şifre. "),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(), primary: Colors.black),
                  child: const Text("Giriş yap"),
                ),
              ),
              _sizedBox50(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.9,
                        color: Colors.grey[500],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Veya",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.9,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              _sizedBox50(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  _boxButtonImages(
                    imagepath: "assets/google.png",
                  ),
                ],
              ),
              _sizedBox25(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Üye değil misin?",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Şimdi üye ol",
                      style: TextStyle(color: Colors.blue[800]),
                    ),
                  ),
                ],
              )
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
}

class _boxButtonImages extends StatelessWidget {
  const _boxButtonImages({
    Key? key,
    this.imagepath,
  });

  final imagepath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("clicked");
      },
      child: Ink(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          imagepath,
          height: 40,
        ),
      ),
    );
  }
}

class _iconPerson extends StatelessWidget {
  const _iconPerson({
    Key? key,
  });

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

class _passwordTextButton extends StatelessWidget {
  const _passwordTextButton({
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(primary: Colors.grey[800]),
            child: const Text("Şifremi Unuttum?"),
          ),
        ],
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
  });

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
