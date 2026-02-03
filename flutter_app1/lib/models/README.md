AppUser

Modelo que representa los datos de un usuario en la app.

Campos:
- name, phone, email, password, imagePath

Notas:
- La clase incluye `toJson` y `fromJson` para facilitar serialización en tests o al enviar/recibir datos del backend.
- En una app real, no almacenes contraseñas en texto plano; usa mecanismos seguros de autenticación.
