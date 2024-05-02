import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class EditControlPage extends StatefulWidget {
  const EditControlPage({super.key});

  @override
  State<EditControlPage> createState() => _EditControlPageState();
}

class _EditControlPageState extends State<EditControlPage> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Controls'),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
      ),
      body: Column(
        children: [
          const Text('Enter your username:'),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: TextField(
                      controller: textController,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      minLines: 1,
                      maxLines: 3,
                      style: const TextStyle(fontSize: 15),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(5),
                        suffixIcon: Icon(Icons.delete),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        hintText: 'type your message',
                        hintStyle: TextStyle(color: Colors.grey),
                        // labelText: 'Enter your username',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                child: FilledButton(
                  onPressed: () {
                    debugPrint('About to send: ${textController.text}');
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
          CheckboxListTile(
            title: const Text('Check me'),
            value: false,
            onChanged: (value) {
              debugPrint('Checkbox value: $value');
            },
          ),
        ],
      ),
    );
  }
}
