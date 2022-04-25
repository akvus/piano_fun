import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piano_chords_test/feature/chords/view/chords_test_page.dart';

/*
Example: https://github.com/InvisibleWrench/FlutterMidiCommand/tree/master/example/lib

TODO
- lock to landscape
- implement with love xD
*/

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const ChordsTestPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final MidiCommand midiCommand = MidiCommand();

    return Scaffold(
      appBar: AppBar(title: const Text('Chords test')),
      body: Column(
        children: [
          FutureBuilder(
            future: midiCommand.devices,
            builder: (context, snapshot) {
              final devices = snapshot.data as List<MidiDevice>;
              return Column(
                children: devices
                    .map((e) => Row(
                          children: [
                            Text(e.name),
                            ElevatedButton(
                              onPressed: () {
                                midiCommand.connectToDevice(e);
                              },
                              child: const Text('Connect'),
                            ),
                          ],
                        ))
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 16),
          StreamBuilder(
              stream: midiCommand.onMidiDataReceived,
              builder: (context, snapshopt) {
                final packet = snapshopt.data as MidiPacket?;

                if (packet == null) {
                  return const Text('No midi packet');
                }
                final data = packet.data;

                final status = data[0];
                final key = data[0];
                final strength = data[0]; // what is it really called?

                return Text(data.toString());
              }),
        ],
      ),
    );
  }
}
