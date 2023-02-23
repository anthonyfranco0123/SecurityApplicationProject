import 'package:flutter/material.dart';
import 'package:flutter_security_application/hover_builder.dart';
import 'package:flutter_security_application/admin/privilege_level_changer.dart';
import 'package:flutter_security_application/admin/admin_state.dart';

class PrivilegeLevelButton extends StatefulWidget {
  const PrivilegeLevelButton({super.key});

  @override
  State<PrivilegeLevelButton> createState() => _PrivilegeLevelButtonWidget();
}

class _PrivilegeLevelButtonWidget extends State<PrivilegeLevelButton> {
  @override
  Widget build(BuildContext context) {
    return HoverBuilder(builder: (isHovering) {
      return InkWell(
        onTap: () {
          PrivilegeLevelChanger().displayTextInputDialog(context);
        },
        child: AdminState.adminState
            ? Container(
                decoration: BoxDecoration(
                  color: isHovering ? Colors.black12 : null,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding:
                    const EdgeInsets.only(left: 8, top: 2, right: 8, bottom: 2),
                child: const Text(
                  "Admin Mode",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  color: isHovering ? Colors.black12 : null,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.only(left: 8, top: 2, right: 8, bottom: 2),
                child: const Text(
                  "User Mode",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
      );
    });
  }
}
