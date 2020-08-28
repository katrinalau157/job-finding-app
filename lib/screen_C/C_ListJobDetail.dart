import 'package:flutter/material.dart';
import 'package:appnewv1/helpers/Constants.dart';
import 'package:appnewv1/helpers/helperfunctions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class buildJobDetail extends StatefulWidget {
  @override
  final String job_title;
  final String job_salary_type;
  final String job_salary;
  final String job_location;
  final String company_name;
  final String job_detail;
  final int time;
  final double lat;
  final double lng;
  final String email;
  final String username_db;
  final String timerange;
  buildJobDetail({
    this.job_title,
    this.job_salary_type,
    this.job_salary,
    this.job_location,
    this.company_name,
    this.job_detail,
    this.time,
    this.lat,
    this.lng,
    this.email,
    this.username_db,
    this.timerange,
  });

  _buildJobDetailState createState() => _buildJobDetailState();
}

class _buildJobDetailState extends State<buildJobDetail> {
  GoogleMapController mapController;
  // Initial location of the Map view
  CameraPosition _initialLocation =
  CameraPosition(target: LatLng(22.27, 114.16), zoom: 18.0);
  final Geolocator _geolocator = Geolocator();

// For storing the current position
  Position _currentPosition;

  void initState() {
    super.initState();
    //_getCurrentLocation();
  }

  _getCurrentLocation() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
        LatLng(widget.lat, widget.lng),
        zoom: 60.0)));

    /* await _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        // Store the position in the variable
        _currentPosition = position;

        print('CURRENT POS: $_currentPosition');

        // For moving the camera to current location
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
    }).catchError((e) {
      print(e);
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.job_title),
        backgroundColor: appBlueColor,
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                //contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                //contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                title: Text(widget.job_title, style: TextStyle(fontSize: 17)),
                trailing: Text(HelperFunctions.TimeBetween(
                  DateTime.now(),
                  DateTime.fromMillisecondsSinceEpoch(widget.time),
                )),
                dense: true,
              ),
              Divider(
                height: 1.0,
                thickness: 1,
              ),
              list("打工待遇", widget.job_salary_type + " \$" + widget.job_salary),
              list_location("打工地點", widget.job_location),
              SizedBox(
                  width: MediaQuery.of(context)
                      .size
                      .width, // or use fixed size like 200
                  height: 200,
                  child:
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(target: LatLng(widget.lat, widget.lng), zoom: 18),
                  )
                // Replace the "TODO" with this widget
/*                    GoogleMap(
                  initialCameraPosition: _initialLocation,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                ),*/
              ),

              list("公司名稱", widget.company_name),
              list("打工內容", widget.job_detail),
              grey_list("打工資訊"),
              list_detail("打工時間", widget.timerange),
              grey_list("應徵方式"),
              list_detail2("聯絡人", widget.username_db, Icons.sentiment_satisfied),
              list_detail2("電話", " ", Icons.phone),
              list_detail2("E-mail", widget.email, Icons.mail_outline),
            ]),
      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Positioned(
      left: 50,
      right: 30,
      top: 100,
      bottom: 300,
      child: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target: LatLng(36.0953103, -115.1992098), zoom: 10),
        ),
      ),
    );
  }

  Widget space() {
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
    );
  }

  Widget list(
      String title,
      String subtitle,
      ) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
      title: Text(title, style: TextStyle(color: appGreyColor, fontSize: 15)),
      subtitle:
      Text(subtitle, style: TextStyle(color: appBlackColor, fontSize: 16)),
      dense: true,
    );
  }

  Widget list_location(
      String title,
      String subtitle,
      ) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
      title: Text(title, style: TextStyle(color: appGreyColor, fontSize: 15)),
      subtitle: Text(subtitle,
          style: TextStyle(
            color: job_location_color,
            fontSize: 16,
            decoration: TextDecoration.underline,
          )),
      dense: true,
    );
  }

  Widget grey_list(String title) {
    return Card(
      color: Colors.grey[200],
      elevation: 0,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        title: Text(title, style: TextStyle(fontSize: 15)),
        dense: true,
      ),
    );
  }

  Widget list_detail(String title, String subttitle, ) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
      leading: Icon(
        Icons.access_time,
        color: appBlackColor,
        size: 25,
      ),
      title:
      Text(title, style: TextStyle(color: appGreyColor, fontSize: 15)),
      subtitle: Text(subttitle,
          style: TextStyle(color: appDeepBlueColor, fontSize: 15)),

      dense: true,
    );
  }

  Widget list_detail2(String title, String subttitle, IconData icon) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
      leading: Icon(
        icon,
        color: appBlackColor,
        size: 25,
      ),
      title: Text(title, style: TextStyle(color: appGreyColor, fontSize: 15)),
      subtitle: Text(subttitle,
          style: TextStyle(color: appDeepBlueColor, fontSize: 15)),
      dense: true,
    );
  }
}
