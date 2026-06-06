# Taller 1 - Flutter
Instalación de la aplicación y flujo de distribución.

## Flujo de Trabajo
El proceso para la distribución de nuevas versiones sigue este flujo:
`Generar APK` -> `App Distribution` -> `Testers` -> `Instalación` -> `Actualización`.

## Publicación
Para replicar el proceso de publicación en el equipo:
1. **Preparación:** Asegurarse de que el archivo `pubspec.yaml` tenga la versión correcta (incrementar para actualizaciones).
2. **Generación del APK:** Ejecutar el comando `flutter build apk --release`.
3. **Firebase App Distribution:**
   - Acceder a [Firebase Console](https://console.firebase.google.com/).
   - Navegar a **Release & Monitor > App Distribution**.
   - Subir el archivo `app-release.apk` ubicado en `build/app/outputs/flutter-apk/`.
   - Asignar el tester: `dduran@uceva.edu.co` al grupo `QA_Clase`.
   - Incluir Release Notes descriptivas.
4. **Distribución:** Hacer clic en "Distribute to 1 tester".
5. **Instalación:** El tester recibirá un correo con el enlace para descargar la app a través de App Tester.

## Notas sobre Versionado
- Se utiliza el formato `version: X.Y.Z+N` en `pubspec.yaml`.
- Ejemplo: `1.0.0+1` para el lanzamiento inicial y `1.0.1+2` para la primera actualización incremental.
- Cada subida a App Distribution debe tener una versión superior para que sea detectada como actualización.

## Bitácora de QA
Los detalles técnicos y resultados de las pruebas se encuentran en el archivo [QA_LOG.md](QA_LOG.md).

