import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testapp/screens/pharmacist_signup_page.dart';
import 'package:testapp/screens/pharmacy_homePage.dart';
import 'login_page_view.dart';

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
                title: Text('Doğrulama Hatası'),
                content: Text(e.message ?? ''),
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
        },
        codeSent: (String verificationId, int? resendToken) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Doğrulama Kodu'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        'Lütfen telefonunuza gönderilen doğrulama kodunu girin:'),
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
                    child: Text('İptal'),
                  ),
                  TextButton(
                    onPressed: () {
                      String verificationCode =
                          verificationCodeController.text.trim();
                      _signInWithPhoneNumber(verificationId, verificationCode);
                      Navigator.of(context).pop();
                    },
                    child: Text('Doğrula'),
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
            title: Text('Doğrulama Hatası'),
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
            title: Text('Giriş Hatası'),
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
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: const Icon(
                  Icons.person,
                  size: 100,
                  color: Colors.lightBlueAccent,
                ),
              ),
              SizedBox(height: 25),
              Text(
                "Eczacı Girişi",
                style: TextStyle(foreground: Paint()..shader = linearGradient, fontSize: 25,fontWeight: FontWeight.bold),

              ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: Colors.grey,width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: "Telefon Numarası",
                    labelText: "Telefon Numarası",
                    prefixIcon: Icon(Icons.phone),
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
                            elevation: 20,
                            backgroundColor: Colors.white70,
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)) ,
                            title: Text('Hata'),
                            content: Text('Telefon numarası boş bırakılamaz.'),
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
                  child: Text("Telefonu Doğrula",style: TextStyle(fontSize: 17,letterSpacing: 1),),
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
                  "Üye Ol",
                  style: TextStyle(
                    color: Colors.blueGrey,
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
