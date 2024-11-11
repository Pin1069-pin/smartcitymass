import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'custom_bottom_navbar.dart';

class SosEmergencyPage extends StatefulWidget {
  @override
  _SosEmergencyPageState createState() => _SosEmergencyPageState();
}

class _SosEmergencyPageState extends State<SosEmergencyPage> {
  int _selectedIndex = 0;
  String videoButtonText = "VDO";
  String audioFileName = "ชื่อไฟล์เสียงที่อัดได้"; // ข้อความเริ่มต้นของไฟล์เสียง
  FlutterSoundRecorder? _audioRecorder;
  FlutterSoundPlayer? _audioPlayer;
  bool _isRecording = false;
  bool _isPlaying = false;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _audioRecorder = FlutterSoundRecorder();
    _audioPlayer = FlutterSoundPlayer();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    await _audioRecorder!.openRecorder();
    await _audioPlayer!.openPlayer();
    await Permission.microphone.request();
    await Permission.storage.request();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _pickVideoFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        videoButtonText = path.basename(result.files.single.path!);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เลือกไฟล์ VDO: $videoButtonText')),
      );
    }
  }

  Future<void> _startRecording() async {
    await Permission.microphone.request();

    if (await Permission.microphone.isGranted) {
      Directory tempDir = await getTemporaryDirectory();
      _filePath = '${tempDir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.mp4';

      await _audioRecorder!.startRecorder(
        toFile: _filePath,
        codec: Codec.aacMP4, // บันทึกเป็น mp4
      );

      setState(() {
        _isRecording = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("ไม่สามารถเข้าถึงไมโครโฟนได้")),
      );
    }
  }

  Future<void> _stopRecording() async {
    await _audioRecorder!.stopRecorder();
    setState(() {
      _isRecording = false;
      audioFileName = path.basename(_filePath!);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('บันทึกเสียงสำเร็จ: $audioFileName')),
    );
  }

  Future<void> _playAudio() async {
    if (_filePath != null) {
      await _audioPlayer!.startPlayer(
        fromURI: _filePath,
        codec: Codec.aacMP4, // กำหนดให้เล่นเป็น mp4
        whenFinished: () {
          setState(() {
            _isPlaying = false;
          });
        },
      );

      setState(() {
        _isPlaying = true;
      });
    }
  }

  Future<void> _stopAudio() async {
    await _audioPlayer!.stopPlayer();
    setState(() {
      _isPlaying = false;
    });
  }

  Future<void> _uploadAudioFile() async {
    if (_filePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("ไม่มีไฟล์เสียงที่ต้องการอัพโหลด")),
      );
      return;
    }

    File audioFile = File(_filePath!);
    String fileName = path.basename(audioFile.path);

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://mass-serv.ddns.net:8888/api/sos/upload-audio-flutter'),
      );

      request.files.add(await http.MultipartFile.fromPath('file', audioFile.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("อัพโหลดไฟล์เสียงสำเร็จ")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("อัพโหลดไฟล์เสียงล้มเหลว: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("เกิดข้อผิดพลาดในการอัพโหลด: $e")),
      );
    }
  }

  @override
  void dispose() {
    _audioRecorder!.closeRecorder();
    _audioPlayer!.closePlayer();
    super.dispose();
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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

            // ปุ่ม VDO ที่จะแสดงชื่อไฟล์เมื่อเลือก
            ElevatedButton(
              onPressed: _pickVideoFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF80DEEA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  videoButtonText,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20),

            // ปุ่มเริ่มและหยุดการอัดเสียง และแสดงชื่อไฟล์เสียงที่บันทึก
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF80DEEA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: _isRecording ? null : _startRecording,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'เริ่มอัด',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _isRecording ? _stopRecording : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'หยุด',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    audioFileName,
                    style: TextStyle(color: Colors.black),
                  ),
                  ElevatedButton(
                    onPressed: _isPlaying ? _stopAudio : (_filePath != null ? _playAudio : null),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00796B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      _isPlaying ? 'หยุดเล่นเสียง' : 'ฟังเสียงที่บันทึก',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: _uploadAudioFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00796B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Center(
                child: Text(
                  'ตกลง',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            // แสดงสถานะและปุ่มติดตามสถานะ
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF37474F),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    'สถานะ : ส่งเรื่องแจ้งแล้ว',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // ฟังก์ชันสำหรับติดตามสถานะ
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00796B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'ติดตามสถานะ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
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
