import 'dart:math';
import 'package:flutter/material.dart';

class SimpleOTPDemo extends StatefulWidget {
  @override
  _SimpleOTPDemoState createState() => _SimpleOTPDemoState();
}

class _SimpleOTPDemoState extends State<SimpleOTPDemo> {
  final TextEditingController _otpController = TextEditingController();
  String _generatedOTP = "";

  // ฟังก์ชันสร้าง OTP
  void _generateOTP() {
    setState(() {
      _generatedOTP = (Random().nextInt(900000) + 100000).toString();
    });
    // แสดง OTP ที่สร้างไว้ (จำลองการส่ง)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Generated OTP: $_generatedOTP")),
    );
  }

  // ฟังก์ชันตรวจสอบ OTP
  void _verifyOTP() {
    if (_otpController.text == _generatedOTP) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP ถูกต้อง!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP ไม่ถูกต้อง")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simple OTP Demo")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "กดปุ่มเพื่อสร้างรหัส OTP",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _generateOTP,
              child: Text("Generate OTP"),
            ),
            SizedBox(height: 32),
            TextField(
              controller: _otpController,
              decoration: InputDecoration(
                labelText: "Enter OTP",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _verifyOTP,
              child: Text("Verify OTP"),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SimpleOTPDemo(),
  ));
}
