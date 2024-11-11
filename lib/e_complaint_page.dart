import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';

class EComplaintPage extends StatefulWidget {
  @override
  _EComplaintPageState createState() => _EComplaintPageState();
}

class _EComplaintPageState extends State<EComplaintPage> {
  String complaintType = 'เลือกประเภทเรื่องร้องเรียน';
  TextEditingController complaintDetailsController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  List<dynamic> searchResults = [];
  String apiKey = "YOUR_API_KEY_HERE"; // ใส่ Google API Key ที่นี่
  final ImagePicker _picker = ImagePicker();
  List<File?> _selectedImages = []; // เก็บไฟล์รูปภาพทั้งหมดที่เลือก

  // ฟังก์ชันสำหรับเลือกหรือถ่ายรูปสูงสุด 10 รูป
  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('เลือกรูปจากแกลเลอรี่'),
                onTap: () async {
                  Navigator.of(context).pop();
                  if (_selectedImages.length < 10) {
                    final pickedFiles = await _picker.pickMultiImage();
                    if (pickedFiles != null) {
                      setState(() {
                        // เพิ่มรูปภาพใหม่โดยจำกัดไม่ให้เกิน 10 รูป
                        _selectedImages.addAll(
                          pickedFiles
                              .map((pickedFile) => File(pickedFile.path))
                              .take(10 - _selectedImages.length),
                        );
                      });
                    }
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('ถ่ายรูปใหม่'),
                onTap: () async {
                  Navigator.of(context).pop();
                  if (_selectedImages.length < 10) {
                    final pickedFile = await _picker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (pickedFile != null) {
                      setState(() {
                        // เพิ่มรูปใหม่โดยไม่ให้เกิน 10 รูป
                        _selectedImages.add(File(pickedFile.path));
                      });
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ฟังก์ชันแสดง popup แผนที่สำหรับเลือกตำแหน่ง
  Future<void> _selectLocationFromMap() async {
    LatLng selectedLocation = LatLng(13.7563, 100.5018); // พิกัดเริ่มต้น (กรุงเทพฯ)

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: Container(
                width: double.maxFinite,
                height: 400,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: selectedLocation,
                    zoom: 12,
                  ),
                  onMapCreated: (GoogleMapController controller) {},
                  onCameraMove: (CameraPosition position) {
                    setState(() {
                      selectedLocation = position.target;
                    });
                  },
                  markers: {
                    Marker(
                      markerId: MarkerId("selected-location"),
                      position: selectedLocation,
                    )
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("ยกเลิก"),
                ),
                TextButton(
                  onPressed: () {
                    locationController.text =
                        "Lat: ${selectedLocation.latitude}, Lng: ${selectedLocation.longitude}";
                    Navigator.of(context).pop();
                  },
                  child: Text("ยืนยันตำแหน่ง"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แจ้งเรื่องร้องเรียน'),
        backgroundColor: Color(0xFF00B7FF),
      ),
      backgroundColor: Color(0xFFFBFBFB),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ประเภทเรื่องร้องเรียน',
              style: TextStyle(color: Color(0xFF00B7FF), fontSize: 16),
            ),
            DropdownButton<String>(
              value: complaintType,
              onChanged: (String? newValue) {
                setState(() {
                  complaintType = newValue!;
                });
              },
              items: <String>[
                'เลือกประเภทเรื่องร้องเรียน',
                'ถนนไม่ดี',
                'น้ำท่วม',
                'ไฟฟ้าดับ'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              isExpanded: true,
              iconEnabledColor: Color(0xFF00B7FF),
            ),
            SizedBox(height: 20),
            Text(
              'รายละเอียดเรื่องร้องเรียน',
              style: TextStyle(color: Color(0xFF0F303D), fontSize: 16),
            ),
            SizedBox(height: 10),
            TextField(
              controller: complaintDetailsController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'พิมพ์รายละเอียดเรื่องร้องเรียน...',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'สถานที่แจ้งเรื่องร้องเรียน',
              style: TextStyle(color: Color(0xFF0F303D), fontSize: 16),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'ค้นหาหรือระบุตำแหน่ง',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.location_on),
                  color: Color(0xFF00B7FF),
                  onPressed: _selectLocationFromMap, // เปิดแผนที่เลือกตำแหน่ง
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'รูปภาพ (สูงสุด 10 รูป)',
                  style: TextStyle(color: Color(0xFF0F303D), fontSize: 16),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.camera_alt),
                  color: Color(0xFF00B7FF),
                  onPressed: _pickImage, // ฟังก์ชันเลือกหรือถ่ายรูป
                ),
              ],
            ),
            SizedBox(height: 10),
            // แสดงภาพที่เลือกในรูปแบบ Grid
            if (_selectedImages.isNotEmpty)
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: _selectedImages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Image.file(
                            _selectedImages[index]!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedImages.removeAt(index); // ลบรูปออก
                              });
                            },
                            child: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFBEA01),
                ),
                onPressed: () {
                  // Add complaint submission logic here
                },
                child: Text(
                  'ยืนยันการแจ้งเรื่องร้องเรียน',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
