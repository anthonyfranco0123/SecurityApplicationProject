import 'package:flutter/material.dart';
import 'package:flutter_security_application/admin/admin_state.dart';

class AdminMode {
  final TextEditingController _textFieldController = TextEditingController();

  void _verifyAdminPassword(String adminPassword) {
    if(adminPassword == 'admin') {
      print(AdminState.adminState);
      AdminState.adminState = !AdminState.adminState;
      print(AdminState.adminState);
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
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Text Field in Dialog",
              hintStyle: const TextStyle(color: Colors.black26),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(3)
              ),
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
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
