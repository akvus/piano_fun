import 'package:flutter_riverpod/flutter_riverpod.dart';

final chordsTestPageViewModelProvder = StateNotifierProvider(
  (ref) => ChordsTestPageViewModel(),
);

class ChordsTestPageViewModel extends StateNotifier<Object?> {
  ChordsTestPageViewModel() : super(null);
}
