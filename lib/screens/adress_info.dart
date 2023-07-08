import 'package:flutter/material.dart';

import 'order_page.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  String? selectedCountry;
  String? selectedCity;
  String? selectedDistrict;
  String? selectedNeighborhood;

  List<String> countries = [
    'Türkiye',
    'Azerbaycan',
    'KKTC',
    // Diğer ülkeler...
  ];

  Map<String, List<String>> citiesByCountry = {
    'Türkiye': ['İstanbul', 'Ankara', 'İzmir'],
    'Azerbaycan': ['City 4', 'City 5', 'City 6'],
    'KKTC': ['City 7', 'City 8', 'City 9'],
    // Diğer ülkelerin şehirleri...
  };

  Map<String, List<String>> districtsByCity = {
    'İstanbul': ['Kadıköy', 'Kartal', 'Pendik'],
    'Ankara': ['Çankaya', 'Yenimahalle', 'Keçiören'],
    'İzmir': ['Bornova', 'Karşıyaka', 'Konak'],
    // Diğer şehirlerin ilçeleri...
  };

  Map<String, List<String>> neighborhoodsByDistrict = {
    'District 1': ['Neighborhood 1', 'Neighborhood 2', 'Neighborhood 3'],
    'District 2': ['Neighborhood 4', 'Neighborhood 5', 'Neighborhood 6'],
    'District 3': ['Neighborhood 7', 'Neighborhood 8', 'Neighborhood 9'],
    // Diğer ilçelerin mahalleleri...
  };

  String? street;
  String? buildingName;
  String? buildingNumber;
  String? apartmentNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adres ve İletişim Bilgileri'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Ülke',
              style: TextStyle(fontSize: 20),
            ),
            DropdownButtonFormField<String>(
              value: selectedCountry,
              items: countries.map((country) {
                return DropdownMenuItem(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCountry = value;
                  selectedCity = null;
                  selectedDistrict = null;
                  selectedNeighborhood = null;
                });
              },
              decoration: InputDecoration(
                hintText: 'Ülke Seçin',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Şehir',
              style: TextStyle(fontSize: 20),
            ),
            DropdownButtonFormField<String>(
              value: selectedCity,
              items: selectedCountry != null
                  ? citiesByCountry[selectedCountry!]!.map((city) {
                      return DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      );
                    }).toList()
                  : [],
              onChanged: (value) {
                setState(() {
                  selectedCity = value;
                  selectedDistrict = null;
                  selectedNeighborhood = null;
                });
              },
              decoration: InputDecoration(
                hintText: 'Şehir Seçin',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'İlçe',
              style: TextStyle(fontSize: 20),
            ),
            DropdownButtonFormField<String>(
              value: selectedDistrict,
              items: selectedCity != null
                  ? districtsByCity[selectedCity!]!.map((district) {
                      return DropdownMenuItem(
                        value: district,
                        child: Text(district),
                      );
                    }).toList()
                  : [],
              onChanged: (value) {
                setState(() {
                  selectedDistrict = value;
                  selectedNeighborhood = null;
                });
              },
              decoration: InputDecoration(
                hintText: 'İlçe Seçin',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Mahalle',
              style: TextStyle(fontSize: 20),
            ),
            DropdownButtonFormField<String>(
              value: selectedNeighborhood,
              items: selectedDistrict != null
                  ? neighborhoodsByDistrict[selectedDistrict!]!
                      .map((neighborhood) {
                      return DropdownMenuItem(
                        value: neighborhood,
                        child: Text(neighborhood),
                      );
                    }).toList()
                  : [],
              onChanged: (value) {
                setState(() {
                  selectedNeighborhood = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Mahalle Seçin',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Sokak',
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  street = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Sokak Adını Girin',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Apartman Adı',
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  buildingName = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Apartman Adını Girin',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Apartman No',
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  buildingNumber = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Apartman No Girin',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Daire No',
              style: TextStyle(fontSize: 20),
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  apartmentNumber = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Daire No Girin',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Adres bilgileri burada kullanılabilir
              },
              child: Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: OrderingPage(),
    routes: {
      '/address': (context) => AddressPage(),
    },
  ));
}
