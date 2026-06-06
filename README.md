# Taller 1 - Flutter
Módulo de Gestión de Universidades (Firebase Firestore).

## Módulo de Universidades
Este módulo permite gestionar una base de datos de universidades en tiempo real utilizando Firestore.
- **Campos:** NIT, Nombre, Dirección, Teléfono y Página Web (URL).
- **Funcionalidades:**
  - Listado en tiempo real con `StreamBuilder`.
  - Formulario de creación y edición con validaciones.
  - Eliminación de registros.

### Configuración requerida:
- Archivo `google-services.json` en `android/app/`.
- Habilitar Firestore en la Firebase Console con una colección llamada `universidades`.

## Otros Módulos
- [Distribución] `Generar APK -> App Distribution`.
- [Auth JWT] Login con API VisionTIC y persistencia local.
