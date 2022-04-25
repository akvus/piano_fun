import 'package:flutter/material.dart';
import 'package:piano/piano.dart';

class ChordsTestPage extends StatelessWidget {
  const ChordsTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  width: 220,
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
                  width: 220,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: DropdownButton<String>(
                          items: ['a', 'b']
                              .map((device) => DropdownMenuItem<String>(
                                  value: device, child: Text(device)))
                              .toList(),
                          onChanged: (device) {},
                        ),
                      ),
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
      ),
    );
  }
}
