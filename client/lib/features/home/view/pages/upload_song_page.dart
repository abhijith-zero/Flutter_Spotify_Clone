import 'package:client/core/theme/app_pallete.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Song'),
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          DottedBorder(
            options: RoundedRectDottedBorderOptions(
              color: Pallete.borderColor,
              radius: Radius.circular(10),
              dashPattern: const [10, 5],
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
        ],
      ),
    );
  }
}
