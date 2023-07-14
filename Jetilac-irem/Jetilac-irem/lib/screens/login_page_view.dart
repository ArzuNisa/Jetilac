import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
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
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              _sizedBox25(),
              const _iconPerson(),
              _sizedBox25(),
              Text(
                'user login'.tr,
                style: TextStyle(color: Colors.grey[700], fontSize: 20),
              ),
              _sizedBox25(),
              UserNameTextField(
                hintText: 'mail'.tr,
                controller: usernameController,
                obscureText: false,
              ),
              _sizedBox20(),
              UserNameTextField(
                hintText: 'password'.tr,
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
                          content: Text('iuop'.tr),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    primary: Colors.black,
                  ),
                  child: Text('login'.tr),
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
                      child: Text('or'.tr,
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
                      'siwg'.tr,
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
                        'nam'.tr,
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
                          'register'.tr,
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
          content: Text('twaeliwg'.tr),
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
            child: Text('ifmp'.tr),
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
