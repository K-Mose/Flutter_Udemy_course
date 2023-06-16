import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key, required this.onPickImage}) : super(key: key);

  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    // source: 이미지(또는 파일)를 가져올 위치
    // ImageSource.camera: 카메라에서 촬영, ImageSource.gallery: 갤러리에서 가져오기
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600, // Image Scale Down
    );

    // 사진 선택(촬영) 없이 닫쳤을 때, pickedImage == null
    if (pickedImage == null ) {
      return;
    }
    // 경로를 통해 File 객체 생성, 같은 경로로 연결
    setState(() {
      _selectedImage = File(pickedImage.path);
      widget.onPickImage(_selectedImage!);
    });


  }

  @override
  Widget build(BuildContext context) {
    if (_selectedImage != null) {
      Image.file(_selectedImage!);
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: (_selectedImage != null)
          ? GestureDetector(
            onTap: _takePicture,
            child: Image.file(
                _selectedImage!,
                // fit to Container
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
          )
          : TextButton.icon(
              onPressed: _takePicture,
              icon: const Icon(Icons.camera),
              label: const Text("Take Picture")
            ),
    );
  }
}
