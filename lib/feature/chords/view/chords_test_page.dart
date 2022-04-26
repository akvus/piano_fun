import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano/piano.dart';
import 'package:piano_chords_test/feature/chords/view/chords_test_page_model.dart';
import 'package:piano_chords_test/feature/chords/view/chords_test_page_view_model.dart';

// TODO consider adding a clef too
// TODO consider selectDevices state?
// TODO the actual game of matching chords with MIDI, drawing stuff on keyboard etc.
// TODO ability to play on the keyboard????

class ChordsTestPage extends StatelessWidget {
  const ChordsTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Consumer(builder: (context, ref, child) {
          final model = ref.watch(chordsTestPageViewModelProvder);

          if (model == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              const Expanded(child: _ThePianoWidget()),
              Row(
                children: [
                  const SizedBox(width: 16),
                  const SizedBox(width: 250, child: _GameStatusWidget()),
                  const Spacer(),
                  const _RequestedChordWidget(),
                  const Spacer(),
                  SizedBox(
                    width: 250,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Expanded(child: _DeviceSelectorWidget()),
                        SizedBox(width: 16),
                        _TheButtonWidget(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              )
            ],
          );
        }),
      );
}

class _RequestedChordWidget extends ConsumerWidget {
  const _RequestedChordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Text(
      'Cmaj7',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}

class _ThePianoWidget extends ConsumerWidget {
  const _ThePianoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InteractivePiano(
      highlightedNotes: [NotePosition(note: Note.C, octave: 3)],
      naturalColor: Colors.white,
      accidentalColor: Colors.black,
      keyWidth: 50,
      noteRange: NoteRange.forClefs([Clef.Alto]),
      onNotePositionTapped: (position) {
        // Use an audio library like flutter_midi to play the sound
      },
    );
  }
}

class _GameStatusWidget extends ConsumerWidget {
  const _GameStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(chordsTestPageViewModelProvder)!;

    String text;
    Color color = Colors.red;
    switch (model.status) {
      case ConnectionStatus.connected:
        text = 'Playing';
        color = Colors.green;
        break;
      case ConnectionStatus.disconnected:
        text = 'Select device and start';

        break;
      case ConnectionStatus.noDevices:
        text = 'No devices';
        break;
    }

    return Row(
      children: [
        Icon(Icons.circle, color: color),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}

class _TheButtonWidget extends ConsumerWidget {
  const _TheButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(chordsTestPageViewModelProvder.notifier);
    final model = ref.watch(chordsTestPageViewModelProvder)!;

    String text;
    switch (model.status) {
      case ConnectionStatus.connected:
        text = 'Stop';
        break;
      case ConnectionStatus.disconnected:
        text = 'Start';
        break;
      case ConnectionStatus.noDevices:
        text = 'Ups';
        break;
    }

    return ElevatedButton(
      child: Text(text),
      onPressed: () => viewModel.onStartPressed(),
    );
  }
}

class _DeviceSelectorWidget extends ConsumerWidget {
  const _DeviceSelectorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(chordsTestPageViewModelProvder.notifier);
    final model = ref.watch(chordsTestPageViewModelProvder)!;

    return DropdownButton<MidiDevice?>(
      value: model.selectedDevice,
      isExpanded: true,
      items: model.devices
          .map(
            (device) => DropdownMenuItem<MidiDevice?>(
              value: model.devices.first,
              child: Text(
                device.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      onChanged: (device) => viewModel.onDeviceSelected(device),
    );
  }
}
