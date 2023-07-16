import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'HomePage.dart';
import 'signup_screen.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({Key? key});

  @override
  _LoginPageViewState createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late GoogleSignIn _googleSignIn;
  late FirebaseAuth _firebaseAuth;

  @override
  void initState() {
    super.initState();
    _googleSignIn = GoogleSignIn();
    _firebaseAuth = FirebaseAuth.instance;
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = const LinearGradient(
      colors: <Color>[Colors.lightBlueAccent, Colors.blueGrey],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 250.0, 80.0));
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              _sizedBox25(),
              const _iconPerson(),
              _sizedBox25(),
              Text(
                "Kullanıcı Girişi",
                style: TextStyle(foreground: Paint()..shader = linearGradient, fontSize: 25,fontWeight: FontWeight.bold),
              ),
              _sizedBox25(),
              UserNameTextField(
                icon: Icon(Icons.mail_lock),
                hintText: "E-posta",
                controller: usernameController,
                obscureText: false,
              ),
              _sizedBox20(),
              UserNameTextField(
                icon: Icon(Icons.password),
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
                  onPressed: () async {
                    String enteredUsername = usernameController.text;
                    String enteredPassword = passwordController.text;

                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                        email: enteredUsername,
                        password: enteredPassword,
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.black12,
                          elevation: 20,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          content: Text("Geçersiz kullanıcı adı veya şifre."),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                  ),
                  child: const Text("Giriş yap",style: TextStyle(fontSize: 17,letterSpacing: 1),),
                ),
              ),
              _sizedBox10(),
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
              _sizedBox25(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _signInWithGoogle();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      primary: Colors.grey[200],
                    ),
                    icon: Image.asset(
                      "assets/images/google.png",
                      height: 20,
                    ),
                    label: Text(
                      "Google ile Giriş Yap",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Üye değil misin?",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPageView(),
                            ),
                          );
                        },
                        child: Text(
                          "Şimdi üye ol",
                          style: TextStyle(color: Colors.blue[800]),
                        ),
                      ),
                    ],
                  )
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

  void _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Google ile giriş yaparken bir hata oluştu."),
        ),
      );
    }
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
          color: Colors.lightBlueAccent,
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

class UserNameTextField extends StatefulWidget {
  const UserNameTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.obscureText,
    required this.icon,
  });

  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Icon icon;

  @override
  State<UserNameTextField> createState() => _UserNameTextFieldState();
}

class _UserNameTextFieldState extends State<UserNameTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          prefixIcon: widget.icon ,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.grey,width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          labelText: widget.hintText,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
