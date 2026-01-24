import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

String rgbToHex(Color color) {
  return '#${color.red8bit.toRadixString(16).padLeft(2, '0')}${color.green8bit.toRadixString(16).padLeft(2, '0')}${color.blue8bit.toRadixString(16).padLeft(2, '0')}';
}

Color hexToColor(String hex) {
  return Color(int.parse(hex, radix: 16) + 0xFF000000);
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

Future<File?> pickAudio() async {
  try {
    final filePickerRes = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );
    if (filePickerRes != null) {
      final file = filePickerRes.files.first.xFile.path;
      return File(file); // Use the selected audio file
    }
    return null;
  } catch (e) {
    return null;
  }
}

Future<File?> pickImage() async {
  try {
    final filePickerRes = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (filePickerRes != null) {
      final file = filePickerRes.files.first.xFile.path;
      return File(file); // Use the selected image file
    }
    return null;
  } catch (e) {
    return null;
  }
}
