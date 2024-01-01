import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_registration/db/model/data_model.dart';
import 'package:student_registration/screens/widgets/list_student_widget.dart';
import 'package:student_registration/db/functions/db_functions.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable, camel_case_types
class Edit_Student extends StatefulWidget {
  var name;
  var age;
  var place;
  var phone;
  int index;
  dynamic imagePath;

  Edit_Student({
    required this.index,
    required this.name,
    required this.age,
    required this.place,
    required this.phone,
    required this.imagePath,
  });

  @override
  State<Edit_Student> createState() => _Edit_StudentState();
}

class _Edit_StudentState extends State<Edit_Student> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _placeController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _ageController = TextEditingController(text: widget.age);
    _placeController = TextEditingController(text: widget.place);
    _phoneController = TextEditingController(text: widget.phone);
    _selectedImage = widget.imagePath != '' ? File(widget.imagePath) : null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(255, 12, 12, 52),
      appBar: AppBar(
        title: Center(child: Text("E D I T")),
        backgroundColor: const Color.fromARGB(255, 165, 78, 224),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.list)),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 50,
                ),
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.blueGrey,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : const AssetImage("assets/pngegg.png") as ImageProvider,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 4, 32, 79)),
                    onPressed: () {
                      _pickImageFromGallery();
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY")),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 4, 47, 79)),
                    onPressed: () {
                      _pickImageFromCam();
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("CAMERA")),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: "Name",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _ageController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'Age',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: _placeController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'Class',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        maxLength: 10,
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(),
                          hintText: 'Address',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 79, 4, 54)),
                          onPressed: () {
                            updateall();
                          },
                          icon: const Icon(Icons.done),
                          label: const Text("Update")),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }

  Future<void> updateall() async {
    final name0 = _nameController.text.trim();
    final age0 = _ageController.text.trim();
    final place0 = _placeController.text.trim();
    final phone0 = _phoneController.text.trim();
    final image0 = _selectedImage!.path;

    if (name0.isEmpty ||
        age0.isEmpty ||
        place0.isEmpty ||
        phone0.isEmpty ||
        image0.isEmpty) {
      return;
    } else {
      final update = StudentModel(
          name: name0, age: age0, place: place0, phone: phone0, image: image0);

      editstudent(widget.index, update);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ListStudentWidget()));
    }
  }

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(returnImage.path);
    });
  }

  _pickImageFromCam() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnImage == null) {
      return;
    }

    setState(() {
      _selectedImage = File(returnImage.path);
    });
  }
}
