import 'package:flutter/material.dart';
import 'package:flutter_security_application/admin/admin_state.dart';
import 'package:flutter_security_application/admin/hidePasswordField/password_field.dart';

class PrivilegeLevelChanger {
  final TextEditingController _textFieldController = TextEditingController();
  bool passwordVisible = false;

  void _verifyAdminPassword(String adminPassword) {
    if (adminPassword == 'admin') {
      AdminState.adminState = !AdminState.adminState;
    }
  }

  Future<void> displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              insetPadding: const EdgeInsets.all(10),
              title: const Text(
                "Admin Mode Login",
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              content: PasswordField(
                controller: _textFieldController,
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
                      color: Color(0xFF5e48ab),
                    ),
                    borderRadius: BorderRadius.circular(2.75),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF5e48ab),
                    ),
                    borderRadius: BorderRadius.circular(2.75),
                  ),
                ),
                errorMessage: 'Must contain a letter!',
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('CANCEL',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: const Text('ENTER',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    _verifyAdminPassword(_textFieldController.text);
                    Navigator.pop(context);
                  },
                ),
              ],
              backgroundColor: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
