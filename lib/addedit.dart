import 'package:flutter/material.dart';

import 'Flashcard.dart';

class AddEditScreen extends StatefulWidget {
  final Flashcard? flashcard;
  final Function(Flashcard) onSave;

  AddEditScreen({this.flashcard, required this.onSave});

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController questionController;
  late TextEditingController answerController;

  @override
  void initState() {
    super.initState();
    questionController = TextEditingController(text: widget.flashcard?.question ?? '');
    answerController = TextEditingController(text: widget.flashcard?.answer ?? '');
  }

  @override
  void dispose() {
    questionController.dispose();
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flashcards App',
          style: TextStyle(
            color: Colors.white, // White text color
            fontWeight: FontWeight.bold, // Bold font weight
            fontSize: 24, // Font size
          ),
        ),
        backgroundColor: Colors.black, // Background color
        elevation: 5, // Shadow effect
        centerTitle: true, // Center the title
        iconTheme: IconThemeData(
          color: Colors.white, // Change the back button color to white
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: questionController,
                decoration: InputDecoration(
                  labelText: 'Question',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  prefixIcon: Icon(Icons.question_answer, color: Colors.blueAccent),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Question cannot be empty' : null,
              ),
              SizedBox(height: 16),  // Add spacing between fields
              TextFormField(
                controller: answerController,
                decoration: InputDecoration(
                  labelText: 'Answer',
                  labelStyle: TextStyle(color: Colors.greenAccent),
                  prefixIcon: Icon(Icons.question_answer_outlined, color: Colors.greenAccent),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.greenAccent, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.greenAccent, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.greenAccent, width: 2),
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Answer cannot be empty' : null,
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final flashcard = Flashcard(
                      question: questionController.text,
                      answer: answerController.text,
                    );
                    widget.onSave(flashcard);
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.flashcard == null ? 'Add' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
