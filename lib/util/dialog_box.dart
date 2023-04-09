import 'package:flutter/material.dart';
import 'package:todo_list/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  DialogBox({
    Key? key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[200],
      content: SizedBox(
        height: 120,
        child: Column(
          children: [
            // get user Input
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add a new Task',
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            // buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // save btn
                MyButton(
                  onPressed: onSave,
                  text: 'Save',
                ),

                // cancel btn
                MyButton(
                  onPressed: onCancel,
                  text: 'Cancel',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
