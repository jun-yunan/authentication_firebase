// import 'dart:html';

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatelessWidget {
  const UploadImage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Image"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    controller.pickImage();
                  },
                  child: const Text("Pick your image"))),
          Obx(() => Container(
                child: controller.fileImage.value.path == ''
                    ? const Icon(
                        Icons.camera,
                        size: 50,
                      )
                    : Image.file(
                        File(controller.fileImage.value.path),
                        height: 150,
                        width: 150,
                      ),
              )),
          ElevatedButton(
              onPressed: () {
                controller.uploadImageToFirebase();
              },
              child: const Text("Upload to Firebase")),
          Obx(
            () => Image.network(
              controller.networkImage.value.toString(),
              width: 150,
              height: 150,
            ),
          )
        ],
      )),
    );
  }
}

class ImageController extends GetxController {
  Rx<File> fileImage = File('').obs;
  Future pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }

      final imageTemp = File(image.path);
      fileImage.value = imageTemp;
    } on PlatformException catch (e) {
      return e;
    }
  }

  Rx<String> networkImage = ''.obs;

  Future<String> uploadImageToFirebase() async {
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();

    try {
      Reference reference =
          FirebaseStorage.instance.ref().child("images/$fileName.jpg");
      await reference.putFile(fileImage.value);

      String downloadURL = await reference.getDownloadURL();
      print(downloadURL);
      networkImage.value = downloadURL;
      return downloadURL;
    } on FirebaseException catch (e) {
      print(e);
      return '';
    }
  }
}
