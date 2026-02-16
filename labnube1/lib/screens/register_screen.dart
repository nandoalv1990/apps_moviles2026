import 'package:flutter/material.dart';
import 'package:labnube1/firebase/email_auth.dart';
//import 'package:labnube1/responsive.dart';
//import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final EmailAuth _auth = EmailAuth();
  @override
  Widget build(BuildContext context) {
    TextEditingController txtConEmail = TextEditingController();
    TextEditingController txtConPass = TextEditingController();
    TextEditingController txtConName = TextEditingController();
    bool passToggle = true;
    // ignore: non_constant_identifier_names
    final FormState = GlobalKey<FormFieldState>();

    final nameValidator = MultiValidator([
      RequiredValidator(errorText: 'Campo obligatorio'),
      MaxLengthValidator(40, errorText: 'Supera el tamaño permitido'),
      MinLengthValidator(3, errorText: 'Nombre muy corto')
    ]);

    final emailValidator = MultiValidator([
      RequiredValidator(errorText: 'Campo obligatorio'),
      EmailValidator(errorText: 'Escribe una dirección válida')
    ]);

    final passwordValidator = MultiValidator([
      RequiredValidator(errorText: 'Campo obligatorio'),
      MinLengthValidator(4, errorText: 'La contraseña es muy corta'),
      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
          errorText: 'Debe contener un caractér especial')
    ]);

    const space = SizedBox(
      height: 20,
    );

    final txtName = TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.name,
      controller: txtConName,
      //onChanged: (value) => txtConName.text,
      validator: nameValidator,
      decoration: const InputDecoration(
        icon: Icon(
          Icons.login,
        ),
        hintText: 'Nombre de usuario',
        labelText: 'Nombre',
        border: OutlineInputBorder(),
      ),
    );

    final txtEmail = TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.emailAddress,
      controller: txtConEmail,
      validator: emailValidator,
      decoration: const InputDecoration(
        icon: Icon(
          Icons.email,
        ),
        hintText: 'escribe@correo.mx',
        labelText: 'email',
        border: OutlineInputBorder(),
      ),
    );

    final txtPassw = TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      obscureText: passToggle,
      validator: passwordValidator,
      controller: txtConPass,
      decoration: const InputDecoration(
        hintText: 'Escribe tu contraseña',
        labelText: 'contraseña',
        border: OutlineInputBorder(),
        icon: Icon(Icons.lock),
      ),
    );

    // ignore: non_constant_identifier_names
    var SingupBtn = ElevatedButton(
      onPressed: () {
        // ignore: unrelated_type_equality_checks
        if (FormState.currentState != false) {
          _auth.CreateUser(txtConEmail.text, txtConPass.text).then((value) {
            // ignore: non_constant_identifier_names
            var Mensaje = value ? 'Usuario creado!' : 'Error al crear usuario';
            final snackBar = SnackBar(
              content: Text(Mensaje),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        }
        txtConName.clear();
        txtConEmail.clear();
        txtConPass.clear();
        Navigator.pushNamed(context, '/register');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: const Text('Registrar'),
      ),
    );

    final btnBack = Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          const Text(
            'Ya tiene una cuenta?',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 1,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/main');
            },
            child: const Text(
              'Iniciar sesión',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );

    const avatar = SizedBox(
      height: 100,
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/img_1.png'),
          radius: 38.0,
          child: Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 12,
              child: Icon(
                Icons.camera_alt,
                size: 15,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: FormState,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SafeArea(child: space),
                avatar,
                space,
                txtName,
                space,
                txtEmail,
                space,
                txtPassw,
                space,
                SingupBtn,
                space,
                btnBack,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
