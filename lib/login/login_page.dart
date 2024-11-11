import 'package:flutter/material.dart';
import 'package:smartcity1/dashboard_page.dart';
import 'package:smartcity1/login/simple_otp_demo.dart';
import 'package:smartcity1/color/app_colors.dart';
import 'package:smartcity1/color/app_styles.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.backgroundGradientStart, AppColors.backgroundGradientEnd],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(
                    Icons.location_city,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 32),
                // ช่องกรอกข้อมูลอีเมล/เบอร์โทร
                Container(
                  decoration: AppStyles.inputDecoration,
                  child: TextField(
                    decoration: AppStyles.textFieldInputDecoration.copyWith(
                      hintText: 'อีเมล/เบอร์โทร',
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // ช่องกรอกข้อมูลรหัสผ่าน
                Container(
                  decoration: AppStyles.inputDecoration,
                  child: TextField(
                    decoration: AppStyles.textFieldInputDecoration.copyWith(
                      hintText: 'รหัสผ่าน',
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 16),
                // ปุ่มเข้าสู่ระบบ
                Container(
                  width: double.infinity,
                  decoration: AppStyles.buttonDecoration,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DashboardPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text('เข้าสู่ระบบ', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 16),
                // ลิงก์ลืมรหัสผ่านและสมัครสมาชิก
                TextButton(
                  onPressed: () {},
                  child: Text('ลืมรหัสผ่าน', style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SimpleOTPDemo()),
                    );
                  },
                  child: Text('สมัครสมาชิก', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}
