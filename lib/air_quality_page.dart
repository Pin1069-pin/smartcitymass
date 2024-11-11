import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'custom_bottom_navbar.dart';

class AirQualityPage extends StatefulWidget {
  @override
  _AirQualityPageState createState() => _AirQualityPageState();
}

class _AirQualityPageState extends State<AirQualityPage> {
  GoogleMapController? mapController;
  final LatLng _initialPosition = LatLng(13.7563, 100.5018);
  final Map<MarkerId, Marker> _markers = {};
  String? selectedLocation;
  String airQualityStatus = "สถานะอากาศดี";
  String pm25 = "pm2.5";
  String uvIndex = "UV Index";
  int _selectedIndex = 0;

  TextEditingController _searchController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  void _addMarkers() {
    final marker1 = Marker(
      markerId: MarkerId("1"),
      position: LatLng(13.7563, 100.5018),
      infoWindow: InfoWindow(title: "ตำแหน่ง 1"),
      onTap: () {
        setState(() {
          selectedLocation = "ตำแหน่ง 1";
          airQualityStatus = "สถานะอากาศดี";
        });
      },
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );

    final marker2 = Marker(
      markerId: MarkerId("2"),
      position: LatLng(13.7594, 100.5236),
      infoWindow: InfoWindow(title: "ตำแหน่ง 2"),
      onTap: () {
        setState(() {
          selectedLocation = "ตำแหน่ง 2";
          airQualityStatus = "สถานะอากาศดี";
        });
      },
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );

    _markers[MarkerId("1")] = marker1;
    _markers[MarkerId("2")] = marker2;
  }

  void _searchLocation(String query) {
    setState(() {
      selectedLocation = null;
      for (var marker in _markers.values) {
        if (marker.infoWindow.title != null &&
            marker.infoWindow.title!.toLowerCase().contains(query.toLowerCase())) {
          selectedLocation = marker.infoWindow.title;
          mapController?.animateCamera(
            CameraUpdate.newLatLng(marker.position),
          );
          break;
        }
      }
      if (selectedLocation == null) {
        airQualityStatus = "ไม่พบสถานที่";
      } else {
        airQualityStatus = "สถานะอากาศดี";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF223546),
      appBar: AppBar(
        backgroundColor: Color(0xFF223546),
        title: Text("ค้นหาสถานที่"),
        elevation: 0,
      ),
      body: Column(
        children: [
          // ช่องค้นหาสถานที่
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'ค้นหาสถานที่',
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: _searchLocation,
            ),
          ),
          // แสดง Google Map
          Expanded(
            flex: 2,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 12.0,
              ),
              markers: Set<Marker>.of(_markers.values),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
          ),
          // แสดงข้อมูลสถานที่ที่เลือก
          Container(
            color: Color(0xFF37474F),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.green, size: 24),
                    SizedBox(width: 8),
                    Text(
                      selectedLocation ?? "ชื่อสถานที่",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.circle, color: Colors.green, size: 12),
                    SizedBox(width: 8),
                    Text(
                      airQualityStatus,
                      style: TextStyle(color: Colors.greenAccent),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(pm25, style: TextStyle(color: Colors.white)),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(uvIndex, style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      // ใช้ CustomBottomNavBar
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
