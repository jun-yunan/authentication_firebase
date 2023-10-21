import 'dart:io';
import 'package:authentication_firebase/controllers/upload_image_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            () => Container(
                child: controller.networkImage.value != ""
                    ? Image.network(
                        controller.networkImage.value.toString(),
                        width: 150,
                        height: 150,
                      )
                    : const Text("no image")),
          )
          // : const Text("not image")
        ],
      )),
    );
  }
}
