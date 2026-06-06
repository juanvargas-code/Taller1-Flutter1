# Taller 1 - Flutter
Módulo de Autenticación JWT y Almacenamiento Seguro.

## Módulo de Autenticación JWT
Este proyecto implementa un sistema de autenticación completo integrado con la API pública de VisionTIC.

### Características:
- **Gestión de Estados:** Utiliza el paquete `provider` para manejar estados de carga, éxito y error de forma reactiva.
- **Seguridad:** 
  - Almacenamiento de tokens sensibles en el llavero del sistema mediante `flutter_secure_storage`.
  - Persistencia de datos de perfil (no sensibles) en `shared_preferences`.
- **Arquitectura:** Separación clara entre modelos, servicios de API/almacenamiento y gestión de estados.

### Credenciales de Prueba (VisionTIC):
- **Email:** `admin@alpha.com`
- **Password:** `12345678`

## Flujo de Trabajo (Original)
`Generar APK` -> `App Distribution` -> `Testers` -> `Instalación` -> `Actualización`.

### Publicación en Firebase
1. **Preparación:** Asegurarse de que el archivo `pubspec.yaml` tenga la versión correcta.
2. **Generación del APK:** Ejecutar `flutter build apk --release`.
3. **Distribución:** Subir a Firebase Console > App Distribution e invitar a `dduran@uceva.edu.co`.

## Bitácora de QA
Consulte el archivo `QA_LOG.md` para el historial de versiones y pruebas.
