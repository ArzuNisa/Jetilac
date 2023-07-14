import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:testapp/screens/pharmacist_signup_page.dart';
import 'package:testapp/screens/pharmacy_homePage.dart';

class PharmacistLoginPage extends StatefulWidget {
  const PharmacistLoginPage({Key? key}) : super(key: key);

  @override
  _PharmacistLoginPageState createState() => _PharmacistLoginPageState();
}

class _PharmacistLoginPageState extends State<PharmacistLoginPage> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController verificationCodeController = TextEditingController();
  late FirebaseAuth _firebaseAuth;

  @override
  void initState() {
    super.initState();
    _firebaseAuth = FirebaseAuth.instance;
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    verificationCodeController.dispose();
    super.dispose();
  }

  Future<void> _verifyPhoneNumber(String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('validation error'.tr),
                content: Text(e.message ?? ''),
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
        },
        codeSent: (String verificationId, int? resendToken) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('verification code'.tr),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        'petvcstyp'.tr),
                    SizedBox(height: 10),
                    TextField(
                      controller: verificationCodeController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('cancel'.tr),
                  ),
                  TextButton(
                    onPressed: () {
                      String verificationCode =
                          verificationCodeController.text.trim();
                      _signInWithPhoneNumber(verificationId, verificationCode);
                      Navigator.of(context).pop();
                    },
                    child: Text('verify'.tr),
                  ),
                ],
              );
            },
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('validation error'.tr),
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

  Future<void> _signInWithPhoneNumber(
      String verificationId, String verificationCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: verificationCode,
      );

      await _firebaseAuth.signInWithCredential(credential);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PharmacyHomePage()),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('login error'.tr),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              const Icon(
                Icons.person,
                size: 100,
                color: Colors.black,
              ),
              SizedBox(height: 25),
              Text(
                'pharmacist login'.tr,
                style: TextStyle(color: Colors.grey[700], fontSize: 20),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: 'phone'.tr,
                    hintStyle: TextStyle(color: Colors.grey[500]),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 65,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    String phoneNumber = phoneNumberController.text.trim();
                    if (phoneNumber.isNotEmpty) {
                      _verifyPhoneNumber(phoneNumber);
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('error'.tr),
                            content: Text('pncblb'.tr),
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
                    shape: StadiumBorder(),
                    primary: Colors.black,
                  ),
                  child: Text('verify phone'.tr),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PharmacistRegisterPage()),
                  );
                },
                child: Text(
                  'sign up'.tr,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
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
