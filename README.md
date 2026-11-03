# mi-terminal-web

Un emulador de terminal interactivo de alto rendimiento diseñado con una arquitectura híbrida que combina una interfaz de usuario fluida en **Flutter (Dart)** y un motor lógico nativo de bajo nivel en **Go (Golang)** optimizado para entornos móviles.

## 🏗️ Arquitectura del Proyecto

El sistema opera dividiendo las tareas en dos capas de ejecución aisladas:
1. **Frontend (Flutter):** Se encarga de la captura de eventos del teclado, la renderización visual de los caracteres y la administración de los flujos asíncronos de datos (*Streams*).
2. **Backend (Go Engine):** Funciona como un subproceso nativo compilado de forma cruzada para procesadores ARM64. Instancia intérpretes de comandos POSIX (`/system/bin/sh`) y maneja de forma eficiente los buffers de comunicación bidireccional mediante gorutinas.

```mermaid
graph LR
    A[Interfaz Flutter] -->|STDIN: Comandos| B(Motor en Go)
    B -->|STDOUT / STDERR: Respuestas| A
    B -->|Llamadas de Sistema| C[/system/bin/sh Nátivo]
```

## 📂 Estructura de Directorios

Para que el pipeline de automatización y el empaquetador de recursos reconozcan los componentes, el repositorio debe mantener el siguiente orden:

```text
mi-terminal-web/
├── core-engine/
│   └── main.go           # Código fuente del motor nativo en Go
├── terminal_app/
│   ├── assets/
│   │   └── bin/          # Destino automatizado del binario compilado (dr-terminal)
│   ├── lib/
│   │   └── main.dart     # Controlador lógico y extractor de binarios en Dart
│   ├── pubspec.yaml      # Declaración de dependencias y recursos de Flutter
│   └── android/          # Configuraciones nativas de la plataforma Android
└── codemagic.yaml        # Pipeline de integración y compilación continua (CI/CD)
```

## 🛠️ Flujo de Operación y Permisos (Ciclo de Vida)

Android ejecuta las aplicaciones dentro de un entorno aislado (*Sandbox*). Al iniciar la aplicación, se ejecutan las siguientes fases lógicas para garantizar un entorno funcional:

1. **Extracción de Recursos:** Flutter localiza el binario embebido `dr-terminal` dentro de los recursos del APK y copia los bytes crudos a la ruta interna segura asignada por el sistema operativo (`getApplicationSupportDirectory`).
2. **Asignación de Flags POSIX:** Utilizando el subproceso nativo de Android, se ejecuta un comando `chmod 755` sobre el archivo extraído para otorgarle explícitamente permisos de ejecución.
3. **Aislamiento de Entorno (PATH Local):** Se inicializa el proceso modificando el mapa de variables de entorno, priorizando el directorio local de la aplicación en el `PATH` para asegurar que el motor localice correctamente las utilidades adicionales.

## 🚀 Instrucciones de Compilación Automatizada (CI/CD)

El archivo `codemagic.yaml` incluido en la raíz está configurado para realizar una compilación limpia en la nube utilizando instancias virtuales Mac Mini M1. El proceso ejecuta los siguientes pasos de manera automatizada ante cada actualización en la rama principal (`main`):

```bash
# 1. Limpieza y preparación de directorios en el servidor de compilación
flutter clean
mkdir -p terminal_app/assets/bin

# 2. Compilación cruzada optimizada para procesadores móviles de 64 bits
# El flag -s remueve las tablas de símbolos y -w elimina la información de depuración DWARF
GOOS=android GOARCH=arm64 go build -ldflags="-s -w" -o terminal_app/assets/bin/dr-terminal core-engine/main.go

# 3. Ensamblado final de la aplicación móvil segmentando arquitecturas
cd terminal_app && flutter pub get
flutter build apk --release --split-per-abi
```

Los artefactos resultantes (`.apk`) optimizados para arquitecturas `arm64-v8a` se generarán automáticamente en el panel de control de Codemagic listos para su descarga e instalación en dispositivos de prueba.

## 📄 Licencia

Este proyecto es de código abierto y está diseñado con fines educativos, de investigación y desarrollo de herramientas de administración de sistemas.
