import 'package:flutter/material.dart';
import 'package:smartcity1/MapSelectPage.dart';
import 'custom_bottom_navbar.dart';


class CctvRequestPage extends StatefulWidget {
  @override
  _CctvRequestPageState createState() => _CctvRequestPageState();
}

class _CctvRequestPageState extends State<CctvRequestPage> {
  String? selectedCamera;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController idCardController = TextEditingController();
  final TextEditingController documentNumberController = TextEditingController();
  final TextEditingController requestDateController = TextEditingController();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _selectCamera() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapSelectPage()),
    );
    if (result != null) {
      setState(() {
        selectedCamera = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF223546),
      appBar: AppBar(
        backgroundColor: Color(0xFF223546),
        title: Text("การร้องขอภาพจากกล้องวงจรปิด"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ชื่อ
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'ชื่อ',
                      filled: true,
                      fillColor: Colors.lightBlue[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: surnameController,
                    decoration: InputDecoration(
                      hintText: 'นามสกุล',
                      filled: true,
                      fillColor: Colors.lightBlue[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // กล้องที่ต้องการขอ (Button สำหรับเปิดหน้า MapSelectPage)
            GestureDetector(
              onTap: _selectCamera,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  selectedCamera ?? 'กล้องที่ต้องการขอ',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 16),

            // เบอร์โทรศัพท์
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                hintText: 'เบอร์โทรศัพท์',
                filled: true,
                fillColor: Colors.lightBlue[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),

            // เลขที่บัตรประชาชน
            TextField(
              controller: idCardController,
              decoration: InputDecoration(
                hintText: 'เลขที่บัตรประชาชน',
                filled: true,
                fillColor: Colors.lightBlue[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),

               // เลขหนังสือขอภาพจาก สน./สภ.
            TextField(
              controller: documentNumberController,
              decoration: InputDecoration(
                hintText: 'เลขหนังสือขอภาพจาก สน./สภ.',
                filled: true,
                fillColor: Colors.lightBlue[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            
             TextField(
              controller: requestDateController,
              decoration: InputDecoration(
                hintText: 'วันที่ ที่ต้องการขอ',
                filled: true,
                fillColor: Colors.lightBlue[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(() {
                    requestDateController.text = "${pickedDate.toLocal()}".split(' ')[0];
                  });
                }
              },
            ),
            SizedBox(height: 20),

            // ปุ่มตกลง
            ElevatedButton(
              onPressed: () {
                // เพิ่มโค้ดสำหรับการดำเนินการเมื่อกดปุ่มตกลง
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF80DEEA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  'ตกลง',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
