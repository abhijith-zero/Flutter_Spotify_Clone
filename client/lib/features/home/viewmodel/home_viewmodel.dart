import 'dart:io';

import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/widgets/utils.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:client/features/home/repositories/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

@riverpod
class HomeViewmodel extends _$HomeViewmodel {
  late HomeRepository _homeRepository;
  @override
  AsyncValue? build() {
    // Initialization code can go here
    _homeRepository = ref.watch(homeRepositoryProvider);
    return null;
  }

  Future<void> uploadSong({
    required File selectedImage,
    required File selectedAudio,
    required String song_name,
    required String artist_name,
    required Color selectedcolor,
  }) async {
    // Method to handle song upload
    state = const AsyncValue.loading();
    final res = await _homeRepository.uploadSong(
      selectedImage: selectedImage,
      selectedAudio: selectedAudio,
      song_name: song_name,
      artist_name: artist_name,
      hex_code: rgbToHex(selectedcolor),
      token: ref.read(currentUserProvider)!.token,
    );
    final val = switch (res) {
      Left(value: final l) => state = AsyncValue.error(
        l.message,
        StackTrace.current,
      ),
      Right(value: final r) => state = AsyncValue.data(r),
    };
    print(val);
  }
}
