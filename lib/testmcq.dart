import 'package:flutter/material.dart';

class FillInTheBlanksWidget extends StatefulWidget {
  @override
  _FillInTheBlanksWidgetState createState() => _FillInTheBlanksWidgetState();
}

class _FillInTheBlanksWidgetState extends State<FillInTheBlanksWidget> {
  List<String> options = ["Flutter", "Android", "iOS", "Web"];
  Map<String, String?> answers = {
    "Blank 1": null,
    "Blank 2": null,
    "Blank 3": null,
    "Blank 4": null,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // The question with blanks
            Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 10,top: 20),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text('Fill the blanks: '),
                  _buildBlank("Blank 1"),
                  Text(' is for mobile development, '),
                  _buildBlank("Blank 2"),
                  Text(' is for iOS, '),
                  _buildBlank("Blank 3"),
                  Text(' is for Android, and '),
                  _buildBlank("Blank 4"),
                  Text(' is for web development.'),
                ],
              ),
            ),
            // Options to drag
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: options.map((option) => _buildDraggableOption(option)).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Check if all blanks are filled and show the result
                if (answers.values.any((value) => value == null)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all blanks!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('You filled all blanks!')),
                  );
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  // DragTarget for the blank spaces
  Widget _buildBlank(String blankKey) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            answers[blankKey] ?? '___',
            style: TextStyle(fontSize: 18, color: answers[blankKey] != null ? Colors.black : Colors.grey),
          ),
        );
      },
      onAccept: (data) {
        setState(() {
          answers[blankKey] = data;
        });
      },
    );
  }

  // Draggable widget for the options
  Widget _buildDraggableOption(String option) {
    return Draggable<String>(
      data: option,
      feedback: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            option,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.4,
        child: _buildOptionBox(option),
      ),
      child: _buildOptionBox(option),
    );
  }

  // Widget to show the options in a box
  Widget _buildOptionBox(String option) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        option,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}