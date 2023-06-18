import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:untitled1/widgets/bottom_navbar.dart';
import 'package:url_launcher/url_launcher_string.dart';
class main_page extends StatefulWidget {
  const main_page({Key? key}) : super(key: key);

  @override
  State<main_page> createState() => _main_pageState();
}

class _main_pageState extends State<main_page> {
  String locationMessage= "current loc of the user,mini not :burada kullanıcı konumu gösterilecektir.";
  late String lat;
  late String long;
  final List<String> entries = <String>['ECZANE ismi 1', 'ECZANE ismi 2', 'ECZANE ismi 3','ECZANE ismi 4'];
  final List<String> infos = <String>['ECZANE tanımı 1', 'ECZANE tanımı 2', 'ECZANE tanımı 3','ECZANE tanımı 4'];
  final  List<Color> colors = [Colors.blue, Colors.amber, Colors.red,Colors.green];

  Future <void> _openMap(String lat,String long) async{
    String googleUrl="";
    await canLaunchUrlString(googleUrl) ? await launchUrlString(googleUrl) : throw "Could not launch $googleUrl";
  }
  Future<Position> _getCurrentLocation() async{
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error("Location services are disable");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission== LocationPermission.denied){
      permission =await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error("location permissions are denied");
      }
    }
    if(permission == LocationPermission.deniedForever){
      return Future.error(
        "Location permissions are permanantl denied,we cannot request"
      );
    }
    return await Geolocator.getCurrentPosition();
  }
  void _liveLocation(){
    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
      lat= position.latitude.toString();
      long= position.longitude.toString();
      setState(() {
        locationMessage="Latitude :$lat , Longtitude:$long";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.tealAccent,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Yakındaki Eczaneler"),
        ),
      ) ,
      body: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            Text(locationMessage,textAlign: TextAlign.center),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(onPressed: () {
                _getCurrentLocation().then((value){
                  lat = "${value.latitude}";
                  long = "${value.longitude}";
                  setState(() {
                    locationMessage= "Latitude : $lat,Longitude : $long";
                  });
                  _liveLocation();
                });
              }, child: Text("get current location")
              ),
            ),
            SizedBox( height: 20,),
            ElevatedButton(onPressed: () {
              _openMap(lat,long);
            }, child: const Text("open google map")),
      ListView.builder(
          shrinkWrap: true,
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return  TextButton(
              onPressed: () {

              },
              child: Center(
                child: Card(
                  child: SizedBox(
                    child: Padding(padding: EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.add_business,
                              color: Colors.teal,
                              size:60.0 ,),
                          ],
                        ),

                        Column(
                          children: [
                            Text("${entries[index]}",style: TextStyle(fontWeight: FontWeight.w900)
                            ),
                            SizedBox(height: 10,),
                            Text("${infos[index]}"),
                          ],
                        ),
                        IconButton(onPressed: () {

                        }, icon:Icon(Icons.location_on,color:Colors.teal ,size: 40.0,))
                      ],
                    ),
                    ),
                  ),

                ),
              ),
            );
          }
      ),
          ],
        ),
      bottomNavigationBar: CustomBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:CustomFloatingButtomNavigationBar (),
    );
  }
}
