import 'package:flutter/material.dart';
import 'package:flutter_security_application/admin/admin_state.dart';
import 'package:flutter_security_application/admin/hidePasswordField/passwordfield.dart';

class AdminMode {
  final TextEditingController _textFieldController = TextEditingController();
  late bool passwordVisible = false;

  void _verifyAdminPassword(String adminPassword) {
    if(adminPassword == 'admin') {
      AdminState.adminState = !AdminState.adminState;
    }
  }

  Future<void> displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Admin Mode Login",
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          content: PasswordField(
            passwordConstraint: r'[a-zA-Z]',
            autoFocus: true,
            color: const Color(0xFF5e48ab),
            inputDecoration: PasswordDecoration(
                inputStyle: const TextStyle(
                  color: Colors.white,
                ),
            ),
            border: PasswordBorder(
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.lime,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF5e48ab),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            errorMessage:
            'Must contain a letter!',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('ENTER'),
              onPressed: () {
                _verifyAdminPassword(_textFieldController.text);
                Navigator.pop(context);
              },
            ),
          ],
          backgroundColor: Colors.black,
        );
      },
    );
  }
}
