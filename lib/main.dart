import 'package:flutter/material.dart';
import 'login/login_page.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ซ่อนแบนเนอร์ Debug
      title: 'Splash Screen',
      theme: ThemeData(
        /*primarySwatch: Colors.white,*/ // คอมเมนต์ออกตามที่คุณระบุ
      ),
      home: Splash(), // เริ่มต้นที่หน้า Splash
    );
  }
}

// สร้างหน้า Splash Screen ที่แสดงโลโก้ก่อนเข้าสู่หน้า LoginPage
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // ตั้งเวลาให้หน้า Splash แสดงเป็นเวลา 3 วินาที
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()), // ไปยังหน้า LoginPage
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF223546),
      body: Center(
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.blueAccent,
          child: Icon(
            Icons.location_city,
            size: 50,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}