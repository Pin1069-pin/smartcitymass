import 'package:flutter/material.dart';
import 'package:smartcity1/air_quality_page.dart';
import 'package:smartcity1/cctv_request_page.dart';
import 'package:smartcity1/e_complaint_page.dart';
import 'package:smartcity1/dashboard_page.dart';
import 'package:smartcity1/e_tourism_page.dart';
import 'package:smartcity1/sos_emergency_page.dart';
import 'custom_bottom_navbar.dart'; // Import custom_bottom_navbar.dart

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // เพิ่มการนำทางไปยังหน้าอื่นตาม index ที่เลือกได้ที่นี่
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF223546),
      appBar: AppBar(
        backgroundColor: Color(0xFF223546),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ส่วนโปรไฟล์
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey[300],
                  child: Text('รูป', style: TextStyle(color: Colors.black)),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ชื่อ วันดี มาดีนะ',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      'อีเมล kewew',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            
            // ข่าวสารประชาชน
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[300],
                    child: Text('รูป', style: TextStyle(color: Colors.black)),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'ข่าวสารประชาชน',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            
            // สถานะอากาศปัจจุบัน
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ค่าอากาศปัจจุบัน จากจุดที่ใกล้ที่สุด',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Row(
                    children: [
                      Icon(Icons.circle, color: Colors.green, size: 12),
                      SizedBox(width: 8),
                      Text(
                        'สถานะอากาศดี',
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
                        child: Text('pm2.5', style: TextStyle(color: Colors.white)),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('UV Index', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // ปุ่มแผนที่และขอภาพกล้อง
                  Column(
                    children: [
                      SizedBox(height: 10),
                 ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AirQualityPage()),
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Color(0xFF80DEEA),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  child: Center(
    child: Text(
      'สถานะอากาศอื่นบนแผนที่',
      style: TextStyle(color: Colors.black),
    ),
  ),
),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CctvRequestPage()),
    );
  },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF00ACC1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Center(
                          child: Text('ขอภาพจากกล้องวงจรปิด',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            
            // ปุ่มเหตุฉุกเฉินและร้องเรียน
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                   onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SosEmergencyPage()),
    );
  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00796B),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('แจ้งเหตุฉุกเฉิน', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EComplaintPage()),
    );
  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF004D40),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('ร้องเรียน', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
                       ElevatedButton(
                        onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ETourismApp()),
    );
  },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF00ACC1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Center(
                          child: Text('ท่องเที่ยว',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
          ],
          
        ),
        
      ),
      // ใช้ CustomBottomNavBar
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
