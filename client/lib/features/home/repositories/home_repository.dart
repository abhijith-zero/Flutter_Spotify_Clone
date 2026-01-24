import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:client/core/failure/failure.dart';
part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(Ref ref) {
  return HomeRepository();
}

class HomeRepository {
  // Repository methods and properties go here
  Future<Either<AppFailure, String>> uploadSong({
    required File selectedImage,
    required File selectedAudio,
    required String song_name,
    required String artist_name,
    required String hex_code,
    required String token,
  }) async {
    // Implementation for uploading a song
    try {
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
          'song_name': song_name,
          'artist_name': artist_name,
          'hex_code': hex_code,
        })
        ..headers.addAll({'x-auth-token': token});
      final response = await request.send();
      if (response.statusCode != 201) {
        return Left(
          AppFailure(
            'Failed to upload song: ${await response.stream.bytesToString()}',
          ),
        );
      }
      return Right(await response.stream.bytesToString());
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}
