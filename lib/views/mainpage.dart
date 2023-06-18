import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/views/closestpharmacy.dart';
import 'package:untitled2/views/settings.dart';
class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  int index = 1;
  final screens=[
    closestpharmacy(),
    mainpage(),
    settingspage(),

  ];
  List<CurvedNavigationBarItem> finalItems = [
    CurvedNavigationBarItem(
      child: Icon(Icons.local_pharmacy),
      label: 'Nöbetçi Eczaneler',
    ),
    CurvedNavigationBarItem(
      child: Icon(Icons.home),
      label: 'Eczaneler',
    ),
    CurvedNavigationBarItem(
      child: Icon(Icons.settings),
      label: 'Ayarlar',
    ),
  ];
  final List<String> entries = <String>['Eczane 1', 'Eczane 2', 'Eczane 3','Eczane 4'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(-2.0, 5.0),
              blurRadius: 4.0,
            )
          ]),
          child: AppBar(
            elevation: 0.0,
            title: Text("Eczaneleri Gör",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 30,letterSpacing: 0.75),),
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),

        ListView.builder(
        itemCount: entries.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
    return TextButton(
        onPressed: () {

        },
        child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.add_business,color: Colors.teal,size: 50.0,),
                      Container(
                        transform: Matrix4.translationValues(-50.0, 0.0, 0.0),
                        child: Column(
                          children: [
                            Text("${entries[index]}",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,overflow: TextOverflow.ellipsis),),
                            Text("eczane bilgisi")
                          ],
                        ),
                      ),
                      IconButton(onPressed: () {
                      }, icon: Icon(Icons.location_on,size: 40,color: Colors.blueGrey,))
                    ],
                  ),
                ),
          ),
    );
    }
    )
          ],
        ),
      ),
      bottomNavigationBar:  CurvedNavigationBar(
        backgroundColor: Colors.teal,
        items: finalItems,
        index: index,
        onTap:(selectedIndex) {
          setState(() {
            index=selectedIndex;
          });
        },
      ),
    );
  }
}
