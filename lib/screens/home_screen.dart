import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../models/vm_model.dart';
import 'vm_config_screen.dart';
import 'display_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<VirtualMachine> savedVMs = [];

  void _createNewVM() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['iso', 'img', 'qcow2'],
    );

    if (result != null && result.files.single.path != null) {
      String path = result.files.single.path!;
      String name = result.files.single.name.split('.').first;

      VirtualMachine newVm = VirtualMachine(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        isoPath: path,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VmConfigScreen(
            vm: newVm,
            onSave: (configuredVm) {
              setState(() {
                savedVMs.add(configuredVm);
              });
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('محاكي الأنظمة المحمول'),
        actions: [
          IconButton(icon: Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: savedVMs.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.computer, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('لا يوجد أي نظام محاكى حالياً'),
                  ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    label: Text('إضافة نظام جديد (ISO / IMG)'),
                    onPressed: _createNewVM,
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: savedVMs.length,
              itemBuilder: (context, index) {
                final vm = savedVMs[index];
                return ListTile(
                  leading: Icon(Icons.desktop_windows, color: Colors.blue),
                  title: Text(vm.name),
                  subtitle: Text('${vm.architecture} | RAM: ${vm.ramMb} MB'),
                  trailing: IconButton(
                    icon: Icon(Icons.play_arrow, color: Colors.green),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DisplayScreen(vm: vm),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewVM,
        child: Icon(Icons.add),
      ),
    );
  }
}

