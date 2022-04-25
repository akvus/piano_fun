import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';

/*
MidiPacket -> 3 ints
Example: https://github.com/InvisibleWrench/FlutterMidiCommand/tree/master/example/lib


TODO basic
- Architect the app a little xD
- Map codes to notes C1->C6 etc.
- Define chords
- Try the piano package for UI, or develop own UI to display chords
- Logic to randomly ask for a chord, match input, display result with clef and virtual keyboard 

TODO if having too much time (like that ever is a case lol)
- Each test has X chords, need to hit correct the 1st time, display % of correct per test
- Record tries and draw some simple stats, charts etc. make it fancy
*/

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
