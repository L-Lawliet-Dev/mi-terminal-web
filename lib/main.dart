import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

// [DR-SYSTEM] Interface Handler - Signature: L
void main() {
  runApp(MaterialApp(home: DRTerminal()));
}

class DRTerminal extends StatefulWidget {
  @override
  _DRTerminalState createState() => _DRTerminalState();
}

class _DRTerminalState extends State<DRTerminal> {
  final TextEditingController _controller = TextEditingController();
  String _output = "[DR-SYSTEM] L-Terminal Active. Ready for commands...\n";

  // Función para extraer el motor de Go de los assets
  Future<String> setupEngine() async {
    final directory = await getApplicationDocumentsDirectory();
    final exePath = '${directory.path}/dr-terminal';
    final file = File(exePath);

    if (!await file.exists()) {
      final data = await rootBundle.load('assets/bin/dr-terminal');
      final bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      await Process.run('chmod', ['755', exePath]); // Permisos de ejecución
    }
    return exePath;
  }

  // Ejecutar el motor de Go (Core Engine)
  Future<void> executeGoEngine(String command, String arg) async {
    String path = await setupEngine();
    final directory = await getApplicationDocumentsDirectory();
    
    // Configuración del PATH para encontrar busy
    
