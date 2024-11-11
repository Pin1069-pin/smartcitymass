import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(ETourismApp());

class ETourismApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'e-Tourism System',
      theme: ThemeData(
        primaryColor: Color(0xFF00B7FF),
        scaffoldBackgroundColor: Color(0xFFFBFBFB),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF0F303D)),
          bodyMedium: TextStyle(color: Color(0xFF0F303D)),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

// หน้าหลัก Home Screen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('e-Tourism System'),
        backgroundColor: Color(0xFF00B7FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'ค้นหาสถานที่...',
                prefixIcon: Icon(Icons.search, color: Color(0xFF00B7FF)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Color(0xFF00B7FF)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'สถานที่ยอดนิยม',
              style: TextStyle(fontSize: 20, color: Color(0xFF0F303D)),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xFFFFFFFF),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Icon(Icons.place, color: Color(0xFF00B7FF)),
                      title: Text('สถานที่ ${index + 1}'),
                      subtitle: Text('รายละเอียดของสถานที่ ${index + 1}'),
                      trailing: IconButton(
                        icon: Icon(Icons.directions, color: Color(0xFF00B7FF)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => PlaceDetailScreen()),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF00B7FF),
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => RegisterPlaceScreen()),
          );
        },
      ),
    );
  }
}

// หน้ารายละเอียดสถานที่ Place Detail Screen
class PlaceDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดสถานที่'),
        backgroundColor: Color(0xFF00B7FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              color: Colors.grey[300],
              child: Center(child: Text('รูปภาพสถานที่')),
            ),
            SizedBox(height: 20),
            Text('ชื่อสถานที่', style: TextStyle(fontSize: 24, color: Color(0xFF0F303D))),
            SizedBox(height: 10),
            Text('ที่อยู่ของสถานที่', style: TextStyle(color: Color(0xFF0F303D))),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.directions, color: Colors.white),
              label: Text('นำทาง', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00B7FF)),
            ),
            SizedBox(height: 20),
            Text('รีวิวและคะแนน', style: TextStyle(fontSize: 20, color: Color(0xFF0F303D))),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.person, color: Color(0xFF0F303D)),
                    title: Text('ผู้ใช้ ${index + 1}'),
                    subtitle: Text('ความคิดเห็นของผู้ใช้ ${index + 1}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// หน้าลงทะเบียนสถานที่ Register Place Screen
class RegisterPlaceScreen extends StatefulWidget {
  @override
  _RegisterPlaceScreenState createState() => _RegisterPlaceScreenState();
}

class _RegisterPlaceScreenState extends State<RegisterPlaceScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ลงทะเบียนสถานที่'),
        backgroundColor: Color(0xFF00B7FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'ชื่อสถานที่',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'ที่อยู่',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'เบอร์โทรศัพท์',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                // ฟังก์ชันบันทึกข้อมูล
              },
              icon: Icon(Icons.save, color: Colors.white),
              label: Text('บันทึกข้อมูล', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00B7FF)),
            ),
          ],
        ),
      ),
    );
  }
}
