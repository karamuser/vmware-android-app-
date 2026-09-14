class VirtualMachine {
  String id;
  String name;
  String isoPath;
  int ramMb;
  int cpuCores;
  String architecture; // x86_64, arm64, i386
  int diskSizeGb;
  bool enableAudio;
  bool enableVirtualKeyboard;
  bool enableTouchMouse;

  VirtualMachine({
    required this.id,
    required this.name,
    required this.isoPath,
    this.ramMb = 2048,
    this.cpuCores = 2,
    this.architecture = 'x86_64',
    this.diskSizeGb = 20,
    this.enableAudio = true,
    this.enableVirtualKeyboard = true,
    this.enableTouchMouse = true,
  });
}

