//import 'dart:async';
import 'package:labnube1/firebase/email_auth.dart';
import 'package:flutter/material.dart';
//import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:form_field_validator/form_field_validator.dart';

// ignore: must_be_immutable
class ResetPass extends StatelessWidget {
  ResetPass({super.key});

  final EmailAuth _auth = EmailAuth();

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final FormState = GlobalKey<FormFieldState>();

    final txtConEmail = TextEditingController();

    final emailValidator = MultiValidator([
      RequiredValidator(errorText: 'Debe introducir un correo e-mail'),
      EmailValidator(errorText: 'Escribe una dirección válida')
    ]);

    final txtEmail = TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.emailAddress,
      controller: txtConEmail,
      decoration: const InputDecoration(
        icon: Icon(
          Icons.email,
        ),
        hintText: 'escribe@correo.mx',
        labelText: 'email',
        border: OutlineInputBorder(),
      ),
      validator: emailValidator,
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
          _auth.ResetPass(txtConEmail.text).then((value) {
            Mensaje = value
                ? 'Se envió una liga a tu bandeja de correo'
                : 'Este correo no pertenece a una cuenta';
            final snackBar = SnackBar(content: Text(Mensaje));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          });
        }
        txtConEmail.clear();
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
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Confirmación'),
      content: const Text('Quiero restablecer mi contraseña'),
      actions: [continueBtn, cancelBtn],
    );

    final sendMail = ElevatedButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: ((context) {
              return alert;
            }));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: const Text('Enviar'),
      ),
    );

    final btnBack = Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, '/main');
          },
          icon: const Icon(Icons.door_front_door),
          label: const Text('Cancelar')),
    );

    const space = SizedBox(height: 20);

    const title = Text('Escribe la dirección de correo de tu cuenta',
        style: TextStyle(fontSize: 18));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: FormState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SafeArea(child: space),
              space,
              title,
              space,
              txtEmail,
              space,
              sendMail,
              space,
              btnBack,
            ],
          ),
        ),
      ),
    );
  }
}
