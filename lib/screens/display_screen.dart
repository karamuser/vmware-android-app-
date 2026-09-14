import 'package:flutter/material.dart';
import '../models/vm_model.dart';

class DisplayScreen extends StatefulWidget {
  final VirtualMachine vm;
  DisplayScreen({required this.vm});

  @override
  _DisplayScreenState createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  bool isKeyboardVisible = false;

  void _shutdownVM() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('إغلاق النظام'),
        content: Text('هل تريد إيقاف الآلة الافتراضية والعودة للواجهة الرئيسية؟'),
        actions: [
          TextButton(
            child: Text('إلغاء'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text('إطفاء النظام (Force Shut Down)', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.pop(context); // إغلاق الحوار
              Navigator.pop(context); // العودة للشاشة الرئيسية
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // شاشة المحاكاة الرئيسية (سياق العرض الخاص بالنظام)
          Center(
            child: Text(
              'جاري تشغيل ${widget.vm.name}...\n(شاشة الـ VM / VNC Output)',
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          
          // زر العودة والإطفاء العلوي المباشر
          Positioned(
            top: 40,
            right: 20,
            child: FloatingActionButton.small(
              backgroundColor: Colors.red.withOpacity(0.8),
              child: Icon(Icons.power_settings_new, color: Colors.white),
              onPressed: _shutdownVM,
            ),
          ),

          // شريط أدوات التحكم المباشر (كيبورد / ماوس)
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.keyboard),
                  label: Text('كيبورد الجهاز'),
                  onPressed: () {
                    setState(() {
                      isKeyboardVisible = !isKeyboardVisible;
                    });
                  },
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  icon: Icon(Icons.mouse),
                  label: Text('وضع الماوس'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

