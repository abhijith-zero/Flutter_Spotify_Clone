import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  // Repository methods and properties go here
  Future<void> uploadSong(File selectedImage, File selectedAudio) async {
    // Implementation for uploading a song
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.0.2.2:8000/song/upload'),
    );
    request
      ..files.addAll([
        await http.MultipartFile.fromPath('thumbnail', selectedImage.path),
        await http.MultipartFile.fromPath('song', selectedAudio.path),
      ])
      ..fields.addAll({
        'song_name': 'song_name',
        'artist_name': 'artist',
        'hex_code': 'FFFFFF',
      })
      ..headers.addAll({
        'x-auth-token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE2NjVmYjRlLTEyZTgtNDM4Mi05ZjI3LWQ1ODFmNzJjMGNmZSJ9.uw2KPZ7gtnNxf-VYvbvcenH9h3HiIDcmUVhL7ohTIcI',
      });
    final response = await request.send();
    print(response);
  }
}
