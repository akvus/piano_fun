import 'package:flutter_midi/flutter_midi.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final flutterMidiProvider = Provider.autoDispose(
  (ref) => FlutterMidi(),
);
