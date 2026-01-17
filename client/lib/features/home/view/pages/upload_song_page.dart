import 'dart:io';

import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/widgets/custom_field.dart';
import 'package:client/core/widgets/utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final artistController = TextEditingController();
  final songNameController = TextEditingController();
  Color selectedColor = Pallete.cardColor;
  File? selectedImage;
  File? selectedAudio;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void selectAudio() async {
    final pickedAudio = await pickAudio();
    if (pickedAudio != null) {
      setState(() {
        selectedAudio = pickedAudio;
      });
    }
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    artistController.dispose();
    songNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Song'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.check))],
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: selectImage,
                behavior: HitTestBehavior.deferToChild,
                excludeFromSemantics: false,
                child: selectedImage != null
                    ? SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(selectedImage!, fit: BoxFit.cover),
                        ),
                      )
                    : DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          color: Pallete.borderColor,
                          radius: Radius.circular(10),
                          dashPattern: [10, 5],
                          strokeCap: StrokeCap.round,
                        ),
                        child: const SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.folder_open, size: 40),
                              SizedBox(height: 15),
                              Text(
                                'Select the thumbnail for your song',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 40),
              CustomField(
                hintText: 'Pick Song',
                controller: null,
                readOnly: true,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              CustomField(
                hintText: 'Song Name',
                controller: songNameController,
              ),
              const SizedBox(height: 20),
              CustomField(
                hintText: 'Artist Name',
                controller: artistController,
              ),
              const SizedBox(height: 20),
              ColorPicker(
                pickersEnabled: {ColorPickerType.wheel: true},
                onColorChanged: (Color color) {
                  setState(() {
                    selectedColor = color;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
