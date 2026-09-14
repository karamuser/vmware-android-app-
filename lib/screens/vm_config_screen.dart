import 'package:flutter/material.dart';
import '../models/vm_model.dart';

class VmConfigScreen extends StatefulWidget {
  final VirtualMachine vm;
  final Function(VirtualMachine) onSave;

  VmConfigScreen({required this.vm, required this.onSave});

  @override
  _VmConfigScreenState createState() => _VmConfigScreenState();
}

class _VmConfigScreenState extends State<VmConfigScreen> {
  late double _ram;
  late String _arch;
  late bool _audio;
  late bool _keyboard;

  @override
  void initState() {
    super.initState();
    _ram = widget.vm.ramMb.toDouble();
    _arch = widget.vm.architecture;
    _audio = widget.vm.enableAudio;
    _keyboard = widget.vm.enableVirtualKeyboard;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إعدادات المحاكاة - ${widget.vm.name}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('سعة الذاكرة العشوائية (RAM): ${_ram.toInt()} MB'),
            Slider(
              value: _ram,
              min: 512,
              max: 8192,
              divisions: 15,
              onChanged: (val) => setState(() => _ram = val),
            ),
            Divider(),
            DropdownButtonFormField<String>(
              value: _arch,
              decoration: InputDecoration(labelText: 'معمارية النظام (Architecture / Bit)'),
              items: ['x86_64', 'i386', 'arm64'].map((arch) {
                return DropdownMenuItem(value: arch, child: Text(arch));
              }).toList(),
              onChanged: (val) => setState(() => _arch = val!),
            ),
            Divider(),
            SwitchListTile(
              title: Text('دعم الصوت Virtual Audio'),
              value: _audio,
              onChanged: (val) => setState(() => _audio = val),
            ),
            SwitchListTile(
              title: Text('إظهار لوحة المفاتيح المخصصة للتطبيق'),
              value: _keyboard,
              onChanged: (val) => setState(() => _keyboard = val),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('حفظ وبدء التشغيل'),
              onPressed: () {
                widget.vm.ramMb = _ram.toInt();
                widget.vm.architecture = _arch;
                widget.vm.enableAudio = _audio;
                widget.vm.enableVirtualKeyboard = _keyboard;
                widget.onSave(widget.vm);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

