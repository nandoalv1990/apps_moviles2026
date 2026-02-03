ProfileImagePicker

Descripción:
Widget simple para seleccionar una imagen de perfil desde la galería. Llama a `onImageSelected(File?)` con
la imagen seleccionada o `null` si el usuario cancela.

Notas de uso:
- Requiere el paquete `image_picker`.
- En Android agrega permisos en `AndroidManifest.xml` si es necesario; en iOS añade descripciones en `Info.plist`.
- Puedes modificar el comportamiento para permitir tomar foto con cámara en lugar de galería.
