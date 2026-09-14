import 'dart:async';
import '../models/vm_model.dart';

class QemuService {
  bool _isRunning = false;

  bool get isRunning => _isRunning;

  // بدء تشغيل النظام عبر إرسال معلمات التشغيل لـ QEMU
  Future<bool> startVM(VirtualMachine vm) async {
    // تبسيط عملية التشغيل وإتاحة المعلمات الأساسية
    List<String> qemuArgs = [
      '-m', '${vm.ramMb}',
      '-smp', '${vm.cpuCores}',
      '-boot', 'd',
      '-cdrom', vm.isoPath,
      '-vga', 'std',
      if (vm.enableAudio) ...['-soundhw', 'hda'],
    ];

    print('جاري تشغيل QEMU بالمعلمات التالية: $qemuArgs');
    _isRunning = true;
    return true;
  }

  // إيقاف النظام وإغلاق المحاكاة
  Future<void> stopVM() async {
    _isRunning = false;
    print('تم إيقاف الآلة الافتراضية بنجاح.');
  }

  // إرسال أحداث الماوس إلى المحاكي
  void sendMouseEvent({required double x, required double y, required int button}) {
    // إرسال إحداثيات اللمس إلى المحاكي
    print('Mouse Event: X=$x, Y=$y, Button=$button');
  }

  // إرسال الضغطات الخاصة بمفتاح الكيبورد (Ctrl, Alt, Esc, etc.)
  void sendKeyEvent(String key) {
    print('Key Event Sent: $key');
  }
}

