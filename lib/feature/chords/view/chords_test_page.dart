import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano/piano.dart';
import 'package:fun_with_piano/feature/chords/view/chords_test_page_model.dart';
import 'package:fun_with_piano/feature/chords/view/chords_test_page_view_model.dart';

class ChordsTestPage extends StatelessWidget {
  const ChordsTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: const [
            Expanded(child: _PianoWidget()),
            _ControlRowWidget(),
          ],
        ),
      );
}

class _ControlRowWidget extends StatelessWidget {
  const _ControlRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 16;
    // An ambiguous number, will cause problems on small devices
    const double sidePanelWidth = 250;

    return Row(
      children: [
        const SizedBox(width: horizontalPadding),
        const SizedBox(width: sidePanelWidth, child: _GameStatusWidget()),
        const Spacer(),
        const _RequestedChordWidget(),
        const Spacer(),
        SizedBox(
          width: sidePanelWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Expanded(child: _DeviceSelectorWidget()),
              SizedBox(width: horizontalPadding),
              _TheButtonWidget(),
            ],
          ),
        ),
        const SizedBox(width: horizontalPadding),
      ],
    );
  }
}

class _RequestedChordWidget extends ConsumerWidget {
  const _RequestedChordWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(chordsTestPageViewModelProvder);

    return Text(
      model.expectedChord?.name ?? 'Ready?',
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }
}

class _PianoWidget extends ConsumerWidget {
  const _PianoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(chordsTestPageViewModelProvder);
    final viewModel = ref.watch(chordsTestPageViewModelProvder.notifier);

    return InteractivePiano(
      highlightedNotes: model.playedNotes,
      naturalColor: Colors.white,
      accidentalColor: Colors.black,
      keyWidth: 50,
      noteRange: NoteRange.forClefs([Clef.Treble]),
      onNotePositionTapped: (position) => viewModel.onNoteReceived(position),
    );
  }
}

class _GameStatusWidget extends ConsumerWidget {
  const _GameStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(chordsTestPageViewModelProvder);

    String text;
    Color color;
    switch (model.connectionStatus) {
      case ConnectionStatus.connected:
        final gameState = model.gameState!;
        final successRate = gameState.successRate.toStringAsFixed(2);

        text =
            '${gameState.successCount} / ${gameState.gamesCount} ($successRate%)';
        color = Colors.green;
        break;
      case ConnectionStatus.disconnected:
        text = 'Select device and start';
        color = Colors.red;
        break;
      case ConnectionStatus.loading:
        text = 'Connecting...';
        color = Colors.grey;
        break;
      case ConnectionStatus.noDevices:
        text = 'No devices';
        color = Colors.grey;
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
    final model = ref.watch(chordsTestPageViewModelProvder);

    String text;
    switch (model.connectionStatus) {
      case ConnectionStatus.connected:
        text = 'Stop';
        break;
      case ConnectionStatus.disconnected:
        text = 'Start';
        break;
      case ConnectionStatus.loading:
        text = '...';
        break;
      case ConnectionStatus.noDevices:
        text = 'Ups';
        break;
    }

    return ElevatedButton(
      child: Text(text),
      onPressed: () => viewModel.onActionButtonPressed(),
    );
  }
}

class _DeviceSelectorWidget extends ConsumerWidget {
  const _DeviceSelectorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(chordsTestPageViewModelProvder.notifier);
    final model = ref.watch(chordsTestPageViewModelProvder);

    return DropdownButton<MidiDevice?>(
      value: model.selectedDevice,
      isExpanded: true,
      items: model.devices.map(
        (device) {
          // The MidiConmmand library does not return the named assigned to
          // a virtual device. Ideally fix the package instead.
          final name = device.name == 'FlutterMidiCommand'
              ? 'Virtual piano'
              : device.name;

          return DropdownMenuItem<MidiDevice?>(
            value: device,
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ).toList(),
      onChanged: model.connectionStatus != ConnectionStatus.connected ||
              model.connectionStatus != ConnectionStatus.loading
          ? (device) => viewModel.onDeviceSelected(device)
          : null,
    );
  }
}
