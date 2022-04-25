import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano/piano.dart';
import 'package:piano_chords_test/feature/chords/view/chords_test_page_view_model.dart';

class ChordsTestPage extends StatelessWidget {
  const ChordsTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        final viewModel = ref.watch(chordsTestPageViewModelProvder.notifier);
        final model = ref.watch(chordsTestPageViewModelProvder);

        if (model == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Center(
          child: Column(
            children: [
              Expanded(
                child: InteractivePiano(
                  highlightedNotes: [NotePosition(note: Note.C, octave: 3)],
                  naturalColor: Colors.white,
                  accidentalColor: Colors.black,
                  keyWidth: 50,
                  noteRange: NoteRange.forClefs([
                    Clef.Treble,
                  ]),
                  onNotePositionTapped: (position) {
                    // Use an audio library like flutter_midi to play the sound
                  },
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 250,
                    child: Row(
                      children: const [
                        SizedBox(width: 16),
                        Icon(Icons.circle, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Not connected'),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Cmaj7',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 250,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Expanded(child: _DeviceSelectorWidget()),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          child: const Text('Start'),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }),
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
