import 'package:flutter/material.dart';
import 'package:testapp/screens/adress_info.dart';

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
  List<String> selectedHours = [];
  String? selectedPharmacy;

  Map<String, bool> pharmacyAvailability = {
    'Fatih Eczanesi': true,
    'Öznur Eczanesi': true,
    'Meydan Eczanesi': false,
    'Damla Eczanesi': true,
    'Tevfik Eczanesi': false,
  };

  List<String> getNightPharmacies() {
    return pharmacyAvailability.entries
        .where((entry) => !entry.value)
        .map((entry) => entry.key)
        .toList();
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    'Saatleri Seçin',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 15,
                  children: [
                    for (int i = 0; i < 24; i++)
                      GestureDetector(
                        onTap: () {
                          String hour = i.toString().padLeft(2, '0') + ':00';
                          setState(() {
                            if (selectedHours.contains(hour)) {
                              selectedHours.remove(hour);
                            } else {
                              selectedHours.add(hour);
                            }
                          });
                        },
                        child: Container(
                          width: 60,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: selectedHours.contains(
                                    i.toString().padLeft(2, '0') + ':00')
                                ? Colors.red
                                : Colors.black45,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text(
                                i.toString().padLeft(2, '0') + ':00',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              if (selectedHours.contains(
                                  i.toString().padLeft(2, '0') + ':00'))
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Eczane Seçin',
                  style: TextStyle(fontSize: 20),
                ),
                DropdownButtonFormField<String>(
                  value: selectedPharmacy,
                  items: pharmacyAvailability.keys.where((pharmacy) {
                    if (selectedHours.isEmpty) {
                      return true;
                    } else if (selectedHours.every((hour) =>
                        hour.compareTo('09:00') >= 0 &&
                        hour.compareTo('17:00') <= 0)) {
                      return pharmacyAvailability[pharmacy] == true;
                    } else {
                      return getNightPharmacies().contains(pharmacy);
                    }
                  }).map((pharmacy) {
                    bool isNightPharmacy =
                        getNightPharmacies().contains(pharmacy);
                    return DropdownMenuItem(
                      value: pharmacy,
                      child: Text(
                        pharmacy,
                        style: TextStyle(
                          color: isNightPharmacy ? Colors.red : Colors.black,
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
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Uyarı'),
                          content: Text(
                              'Lütfen reçete numarasını kontrol edin. Reçete numarası 8 haneli olmalıdır.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Tamam'),
                            ),
                          ],
                        ),
                      );
                    } else if (selectedPharmacy == null) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Uyarı'),
                          content: Text('Lütfen bir eczane seçin.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Tamam'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      // Sipariş işlemleri burada gerçekleştirilir
                      // Ödeme ekranına yönlendirilir ve sipariş numarası alınır
                      String orderNumber = '123456'; // Sipariş numarası örneği
                      // Kullanıcıya sipariş numarasını içeren bildirim gönderilir
                      // Sipariş takip sayfasına yönlendirilir
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddressPage(),
                          settings: RouteSettings(
                            arguments: orderNumber,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text('İleri'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
