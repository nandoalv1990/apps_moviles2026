import 'package:flutter/material.dart';
import 'package:labnube1/firebase/email_auth.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:form_field_validator/form_field_validator.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final EmailAuth _auth = EmailAuth();

  @override
  Widget build(BuildContext context) {
    TextEditingController txtConEmail = TextEditingController();
    TextEditingController txtConPass = TextEditingController();
    // ignore: non_constant_identifier_names
    final FormState = GlobalKey<FormFieldState>();

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

    final txtPass = TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      controller: txtConPass,
      validator: passwordValidator,
      decoration: const InputDecoration(
        icon: Icon(
          Icons.lock,
        ),
        hintText: 'Escribe tu contraseña',
        labelText: 'contraseña',
        border: OutlineInputBorder(),
      ),
    );

    Widget continueBtn = ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.greenAccent),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        )),
      ),
      child: const Text('Aceptar'),
      onPressed: () {
        // ignore: unrelated_type_equality_checks
        if (FormState.currentState != false) {
          // ignore: non_constant_identifier_names
          String Mensaje;
          _auth.VerifyEmail(txtConEmail.text, txtConPass.text).then((value) {
            Mensaje = value ? 'Exito!' : 'Err_02';
            final snackBar = SnackBar(content: Text(Mensaje));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        }
        Navigator.of(context).pop();
      },
    );

    Widget cancelBtn = ElevatedButton(
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(Colors.redAccent),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          )),
      child: const Text('Cancelar'),
      onPressed: () {
        Navigator.of(context).pop();
        //Navigator.popAndPushNamed(context, '/main');
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Verificación de E-mail'),
      content: const Text('Reenviar la liga de verificación a mi correo'),
      actions: [continueBtn, cancelBtn],
    );

    final btnLogin = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin,
      onPressed: () {
        // ignore: prefer_typing_uninitialized_variables
        var mensaje;
        // ignore: unrelated_type_equality_checks
        if (FormState.currentState != false) {
          _auth.ValidateUser(txtConEmail.text, txtConPass.text).then(
            (value) {
              switch (value) {
                case 0:
                  Navigator.pushNamed(context, '/dash');
                  break;
                case 1:
                  mensaje = 'Por favor verifique su dirección de e-mail';
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return alert;
                      }));
                  break;
                case 2:
                  mensaje = 'Cuenta no encontrada';
                  break;
                case 3:
                  mensaje = 'Escribe una cuenta válida';
                  break;
              }
              var snackBar = SnackBar(
                content: Text(mensaje), /*Text('Credenciales no encontradas'),*/
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          );
        }
      },
    );

    final btnGmail = SocialLoginButton(
      buttonType: SocialLoginButtonType.google,
      onPressed: () {},
    );

    const space = SizedBox(
      height: 15,
    );

    const txtor = Text(
      'O utiliza una cuenta',
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );

    final btnRegister = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'No tienes cuenta?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 1,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            child: const Text(
              'Crear cuenta',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );

    final btnGetpassword = Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, '/getpass');
        },
        icon: const Icon(
          Icons.password_rounded,
          color: Colors.black,
        ),
        label: const Text(
          'Olvidé mi contraseña',
          style: TextStyle(color: Colors.black87),
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: 0.2,
              fit: BoxFit.cover,
              image: AssetImage('assets/images/image1.jpg'),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: FormState,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SafeArea(
                    child: SizedBox(
                      height: 350,
                    ),
                  ),
                  txtEmail,
                  space,
                  txtPass,
                  space,
                  btnLogin,
                  space,
                  btnRegister,
                  space,
                  txtor,
                  space,
                  btnGmail,
                  space,
                  btnGetpassword,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
