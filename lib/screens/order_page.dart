import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:testapp/screens/HomePage.dart';
import 'package:testapp/screens/ProfileScreen.dart';
import 'package:testapp/screens/SettingsPage.dart';

import 'payment_page.dart';

void main() {
  runApp(MaterialApp(
    home: OrderingPage(),
  ));
}

class OrderingPage extends StatefulWidget {
  @override
  _OrderingPageState createState() => _OrderingPageState();
}

class _OrderingPageState extends State<OrderingPage> {
  String? prescriptionNumber;
  String? tcKimlikNumber;
  String? selectedCity;
  String? selectedDistrict;
  String? selectedPharmacy;

  Map<String, List<String>> districts = {
    'İstanbul': ['Kadıköy', 'Beşiktaş', 'Şişli'],
    'Ankara': ['Çankaya', 'Kızılay', 'Keçiören'],
    'İzmir': ['Karşıyaka', 'Buca', 'Konak'],
  };

  Map<String, List<String>> pharmacies = {
    'Kadıköy': ['Meydan Eczanesi', 'Ocak Eczanesi', 'Nöbetçi Eczane'],
    'Beşiktaş': ['Demet Eczanesi', 'Emek Eczanesi', 'Nöbetçi Eczane'],
    'Şişli': ['Pozitif Eczanesi', 'Gülden Eczanesi', 'Nöbetçi Eczane'],
    'Çankaya': ['Karaca Eczanesi', 'Ay Güneş Eczanesi', 'Nöbetçi Eczane'],
    'Kızılay': ['Çoşkun Eczanesi', 'Yorulmaz Eczanesi', 'Nöbetçi Eczane'],
    'Keçiören': ['Uğurhan Eczanesi', 'Erbil Eczanesi', 'Nöbetçi Eczane'],
    'Karşıyaka': ['Çalışkan Eczanesi', 'Öztekin Eczanesi', 'Nöbetçi Eczane'],
    'Buca': ['Okyanus Eczanesi', 'Aksu Eczanesi', 'Nöbetçi Eczanesi'],
    'Konak': ['Ada Eczanesi', 'Fakülte Eczanesi', 'Nöbetçi Eczane'],
  };

  Map<String, bool> pharmacyAvailability = {
    'Meydan Eczanesi': true,
    'Ocak Eczanesi': true,
    'Nöbetçi Eczane': false,
    'Demet Eczanesi': true,
    'Emek Eczanesi': true,
    'Nöbetçi Eczane': false,
    'Pozitif Eczanesi': true,
    'Gülden Eczanesi': true,
    'Nöbetçi Eczane': false,
    'Karaca Eczanesi': true,
    'Ay Güneş Eczanesi': true,
    'Nöbetçi Eczane': false,
    'Çoşkun Eczanesi': true,
    'Yorulmaz Eczanesi': true,
    'Nöbetçi Eczane': false,
    'Uğurhan Eczanesi': true,
    'Erbil Eczanesi': true,
    'Nöbetçi Eczane': false,
    'Çalışkan Eczanesi': true,
    'Öztekin Eczanesi': true,
    'Nöbetçi Eczane': false,
    'Okyanus Eczanesi': true,
    'Aksu Eczanesi': true,
    'Nöbetçi Eczane': false,
    'Ada Eczanesi': true,
    'Fakülte Eczanesi': true,
    'Nöbetçi Eczane': false,
  };

  List<String> getNightPharmacies() {
    return pharmacyAvailability.entries
        .where((entry) => !entry.value)
        .map((entry) => entry.key)
        .toList();
  }

  List<String> getPharmaciesForDeliveryTime(String deliveryTime) {
    bool isNightTime = deliveryTime.startsWith('17:00') ||
        deliveryTime.startsWith('18:00') ||
        deliveryTime.startsWith('19:00') ||
        deliveryTime.startsWith('20:00') ||
        deliveryTime.startsWith('21:00') ||
        deliveryTime.startsWith('22:00');
    return isNightTime
        ? getNightPharmacies()
        : pharmacyAvailability.keys.toList();
  }

  bool isTcKimlikValid(String? tcKimlik) {
    if (tcKimlik == null || tcKimlik.length != 11) {
      return false;
    }
    int lastDigit = int.parse(tcKimlik[10]);
    return lastDigit % 2 == 0;
  }

  void showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('warning'.tr),
          content: Text(message),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 400,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Order".tr,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: Colors.white70
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'prescription number'.tr,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    decoration: InputDecoration(
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
                      labelText: 'prescription number'.tr,
                      hintText: 'prescription number'.tr,
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                    onChanged: (value) {
                      setState(() {
                        prescriptionNumber = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'id'.tr,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    decoration: InputDecoration(
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
                      labelText: 'id'.tr,
                      hintText: 'id'.tr,
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                    onChanged: (value) {
                      setState(() {
                        tcKimlikNumber = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'select city'.tr,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10,),
                  DropdownButtonFormField<String>(
                    value: selectedCity,
                    items: ['İstanbul', 'Ankara', 'İzmir'].map((city) {
                      return DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCity = value;
                        selectedDistrict = null;
                        selectedPharmacy = null;
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.grey,width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.grey,width: 2),
                      ),
                      fillColor: Colors.grey.shade200,
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      hintText: 'select city'.tr,
                    ),
                  ),
                  SizedBox(height: 20),
                  if (selectedCity != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'select district'.tr,
                          style: TextStyle(fontSize: 20),
                        ),
                        DropdownButtonFormField<String>(
                          value: selectedDistrict,
                          items: districts[selectedCity!]!.map((district) {
                            return DropdownMenuItem(
                              value: district,
                              child: Text(district),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDistrict = value;
                              selectedPharmacy = null;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'select district'.tr,
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: Colors.grey,width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: Colors.grey,width: 2),
                            ),
                            fillColor: Colors.grey.shade200,
                            hintStyle: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'select a pharmacy'.tr,
                          style: TextStyle(fontSize: 20),
                        ),
                        if (selectedDistrict != null)
                          DropdownButtonFormField<String>(
                            value: selectedPharmacy,
                            items:
                                (pharmacies[selectedDistrict!] ?? []).map((pharmacy) {
                              bool isNightPharmacy =
                                  getNightPharmacies().contains(pharmacy);
                              return DropdownMenuItem<String>(
                                value: pharmacy,
                                child: Text(
                                  pharmacy,
                                  style: TextStyle(
                                    color:
                                        isNightPharmacy ? Colors.red : Colors.black,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedPharmacy = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'select a pharmacy'.tr,
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(color: Colors.grey,width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(color: Colors.grey,width: 2),
                              ),
                              fillColor: Colors.grey.shade200,
                              hintStyle: TextStyle(color: Colors.grey[500]),
                            ),
                          ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),)
                            ),
                            onPressed: () {
                              if (prescriptionNumber == null ||
                                  prescriptionNumber!.length != 8) {
                                showAlertDialog(
                                    'peavpn'.tr);
                              } else if (tcKimlikNumber == null ||
                                  tcKimlikNumber!.length != 11 ||
                                  !isTcKimlikValid(tcKimlikNumber)) {
                                showAlertDialog(
                                    'peavidn'.tr);
                              } else if (selectedCity == null ||
                                  selectedDistrict == null ||
                                  selectedPharmacy == null) {
                                showAlertDialog(
                                    'psccap'.tr);
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddressPage(
                                      prescriptionNumber: prescriptionNumber!,
                                      tcKimlikNumber: tcKimlikNumber!,
                                      city: selectedCity!,
                                      district: selectedDistrict!,
                                      pharmacy: selectedPharmacy!,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Text('contiune'.tr,style: TextStyle(fontSize: 17),),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}

class AddressPage extends StatelessWidget {
  final String prescriptionNumber;
  final String tcKimlikNumber;
  final String city;
  final String district;
  final String pharmacy;
  final TextEditingController addressController = TextEditingController();

  AddressPage({
    required this.prescriptionNumber,
    required this.tcKimlikNumber,
    required this.city,
    required this.district,
    required this.pharmacy,
  });

  bool isAddressValid(String address) {
    return address.trim().isNotEmpty;
  }

  void showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('warning'.tr),
          content: Text(message),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        title: Text('oaai'.tr),
      ),*/
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 400,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "oaai".tr,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: Colors.white70
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Table( // Allows to dd a border decoration around your table
                        children: [
                          TableRow(children :[
                            Text('prescription number'.tr ),
                            Text(': $prescriptionNumber'),
                          ]),
                          TableRow(children :[
                            Text('id'.tr,),
                            Text(': $tcKimlikNumber'),
                          ]),
                          TableRow(children :[
                            Text('city'.tr ),
                            Text(': $city'),
                          ]),
                          TableRow(children :[
                            Text('district'.tr ),
                            Text(': $district'),
                          ]),
                          TableRow(children :[
                            Text('pharmacy'.tr),
                            Text(': $pharmacy'),
                          ]),
                        ]
                    ),
                  )
                  /*Text(
                    'prescription number'.tr +': $prescriptionNumber',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'id'.tr + ': $tcKimlikNumber',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    'city'.tr + ': $city',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                      'district'.tr +': $district',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                      'pharmacy'.tr +': $pharmacy',
                    style: TextStyle(fontSize: 20),
                  ),*/,
                  SizedBox(height: 20),
                  Text(
                    'pcyoiitiamiti'.tr,
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back),
                        Text('go back'.tr),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    height: 1,
                    color: Colors.black,
                  ),
                  SizedBox(height: 20),
                  Text(
                      'address'.tr + ':',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Colors.grey,width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.grey,width: 2),
                      ),
                      hintText: 'peyfai'.tr,
                      labelText:'peyfai'.tr ,
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),)
    ),
                      onPressed: () {
                        String address = addressController.text;
                        if (!isAddressValid(address)) {
                          showAlertDialog(
                              context, 'peyfai'.tr);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Builder(
                                builder: (BuildContext context) {
                                  return ChangeNotifierProvider(
                                    create: (context) => OrderInfoProvider(),
                                    child: Payment(
                                      prescriptionNumber: prescriptionNumber,
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                      },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('go forward'.tr,style: TextStyle(fontSize: 17),),
                          ),
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
