import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  const PickImage({super.key});

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  Uint8List? _image;
  File? selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Center(
        child: Stack(
          children: [
            _image != null
                ? CircleAvatar(
                    radius: 100,
                    backgroundImage: MemoryImage(_image!),
                  )
                : const CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/placeholder_image.jpg'),
                  ),
            Positioned(
                bottom: -0,
                left: 140,
                child: IconButton(
                    onPressed: () {
                      showImagePickerOption(context);
                    },
                    icon: Icon(Icons.add_a_photo))),
          ],
        ),
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.blue[100],
        context: context,
        builder: (builder) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickimageFromGallery();
                    },
                    child: const SizedBox(
                        child: Column(
                      children: [
                        Icon(
                          Icons.image,
                          size: 70,
                        ),
                        Text('Gallery'),
                      ],
                    )),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickimageFromCamera();
                    },
                    child: const SizedBox(
                        child: Column(
                      children: [
                        Icon(
                          Icons.camera,
                          size: 70,
                        ),
                        Text('Camera'),
                      ],
                    )),
                  ),
                )
              ],
            ),
          );
        });
  }

  Future _pickimageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }

  Future _pickimageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }
}
