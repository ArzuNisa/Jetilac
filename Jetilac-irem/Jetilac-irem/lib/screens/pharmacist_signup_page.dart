import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              const _iconPharmacy(),
              SizedBox(height: 20),
              Text(
                'pregister'.tr,
                style: TextStyle(color: Colors.grey[700], fontSize: 20),
              ),
              SizedBox(height: 25),
              PharmacyNameTextField(
                hintText: 'pname'.tr,
                controller: pharmacyNameController,
              ),
              SizedBox(height: 10),
              PharmacyEmailTextField(
                hintText: 'mail'.tr,
                controller: pharmacyEmailController,
              ),
              SizedBox(height: 10),
              PhoneNumberTextField(
                hintText: 'phone'.tr,
                controller: phoneNumberController,
              ),
              SizedBox(height: 10),
              UserNameTextField(
                hintText: 'password'.tr,
                controller: passwordController,
                obscureText: true,
              ),
              SizedBox(height: 10),
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
                            title: Text('error'.tr),
                            content: Text(
                              'pfiaf'.tr,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('ok'.tr),
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
                  child: Text('rregister'.tr),
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
          builder: (context) => PharmacistLoginPage(),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('rerror'.tr),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('ok'.tr),
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
          color: Colors.black,
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
