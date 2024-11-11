import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSelectPage extends StatefulWidget {
  @override
  _MapSelectPageState createState() => _MapSelectPageState();
}

class _MapSelectPageState extends State<MapSelectPage> {
  GoogleMapController? mapController;
  final LatLng _initialPosition = LatLng(13.7563, 100.5018);
  final Map<MarkerId, Marker> _markers = {};
  String selectedCamera = '';

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  void _addMarkers() {
    final marker1 = Marker(
      markerId: MarkerId("1"),
      position: LatLng(13.7563, 100.5018),
      infoWindow: InfoWindow(title: "กล้องตัวที่ 1"),
      onTap: () {
        setState(() {
          selectedCamera = "กล้องตัวที่ 1 - รายละเอียดที่อยู่";
        });
      },
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );

    final marker2 = Marker(
      markerId: MarkerId("2"),
      position: LatLng(13.7594, 100.5236),
      infoWindow: InfoWindow(title: "กล้องตัวที่ 2"),
      onTap: () {
        setState(() {
          selectedCamera = "กล้องตัวที่ 2 - รายละเอียดที่อยู่";
        });
      },
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );

    _markers[MarkerId("1")] = marker1;
    _markers[MarkerId("2")] = marker2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF223546),
      appBar: AppBar(
        backgroundColor: Color(0xFF223546),
        title: Text("เลือกกล้องที่ต้องการร้องขอ"),
        elevation: 0,
      ),
      body: Column(
        children: [
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
          Container(
            color: Color(0xFF37474F),
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.green, size: 24),
                    SizedBox(width: 8),
                    Text(
                      selectedCamera.isNotEmpty ? selectedCamera : "กรุณาเลือกกล้องที่ต้องการ",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (selectedCamera.isNotEmpty) {
                      Navigator.pop(context, selectedCamera);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF80DEEA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'ยืนยันกล้องที่ต้องการร้องขอ',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
