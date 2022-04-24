import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
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
                final midiPacket = snapshopt.data as MidiPacket?;

                if (midiPacket == null) {
                  return Text('No midi packet');
                }

                return Text(midiPacket.data.toString());
              }),
        ],
      ),
    );
  }
}
