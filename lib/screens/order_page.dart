import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          title: Text('Uyarı'),
          content: Text(message),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sipariş Ver'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reçete Numarası',
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  prescriptionNumber = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Reçete Numarasını Girin',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'TC Kimlik Numarası',
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  tcKimlikNumber = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'TC Kimlik Numarasını Girin',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Şehir Seçin',
              style: TextStyle(fontSize: 20),
            ),
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
                hintText: 'Şehir Seçin',
              ),
            ),
            SizedBox(height: 20),
            if (selectedCity != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'İlçe Seçin',
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
                      hintText: 'İlçe Seçin',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Eczane Seçin',
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
                        hintText: 'Eczane Seçin',
                      ),
                    ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (prescriptionNumber == null ||
                          prescriptionNumber!.length != 8) {
                        showAlertDialog(
                            'Lütfen geçerli bir reçete numarası girin (8 haneli olmalı).');
                      } else if (tcKimlikNumber == null ||
                          tcKimlikNumber!.length != 11 ||
                          !isTcKimlikValid(tcKimlikNumber)) {
                        showAlertDialog(
                            'Lütfen geçerli bir TC kimlik numarası girin (11 haneli, sonu çift rakam olmalı).');
                      } else if (selectedCity == null ||
                          selectedDistrict == null ||
                          selectedPharmacy == null) {
                        showAlertDialog(
                            'Lütfen şehir, ilçe ve eczane seçimi yapın.');
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
                    child: Text('Devam'),
                  ),
                ],
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
          title: Text('Uyarı'),
          content: Text(message),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sipariş ve Adres Bilgileri'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reçete Numarası: $prescriptionNumber',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'TC Kimlik Numarası: $tcKimlikNumber',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Şehir: $city',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'İlçe: $district',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Eczane: $pharmacy',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Lütfen sipariş bilgilerinizi kontrol ediniz. Bilgilerde yanlışlık varsa önceki sayfaya geri dönerek bilgilerinizi güncelleyiniz.',
              style: TextStyle(color: Colors.red, fontSize: 15),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(Icons.arrow_back),
                  Text('Geri Dön'),
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
              'Adres:',
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(
                hintText: 'Lütfen tam adres bilginizi giriniz',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String address = addressController.text;
                if (!isAddressValid(address)) {
                  showAlertDialog(
                      context, 'Lütfen tam adres bilginizi giriniz.');
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
              child: Text('İleri'),
            ),
          ],
        ),
      ),
    );
  }
}
