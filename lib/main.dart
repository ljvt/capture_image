import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capture Images'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              if (imageFile != null)
                Container(
                  width: 600,
                  height: 480,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: FileImage(imageFile!)),
                    color: Colors.grey,
                    border: Border.all(width: 8, color: Colors.black12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                )
              else
                Container(
                  width: 600,
                  height: 480,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(width: 8, color: Colors.black12),
                      borderRadius: BorderRadius.circular(12)),
                  child: const Text(
                    'Image shold appear here',
                    style: TextStyle(fontSize: 26),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => getImage(source: ImageSource.camera),
                      child: const Text(
                        'Capture Image',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => getImage(source: ImageSource.gallery),
                      child: const Text(
                        'Select Image',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
      });
    }
  }
}
