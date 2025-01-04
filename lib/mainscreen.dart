import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Flashcard.dart';
import 'FlashcardProvider.dart';
import 'addedit.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {



  void deleteFlashcard(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Flashcard?'),
        content: Text('Are you sure you want to delete this flashcard?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<FlashcardProvider>(context, listen: false)
                  .removeFlashcard(index);
              Navigator.pop(context);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
  Map<int, bool> _showAnswerMap = {}; // Map to track visibility state for each flashcard

  void toggleAnswerVisibility(int index) {
    setState(() {
      // Initialize the value if it doesn't exist in the map (default to false)
      if (_showAnswerMap[index] == null) {
        _showAnswerMap[index] = false;
      } else {
        _showAnswerMap[index] = !_showAnswerMap[index]!;
      }
    });
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

      ),

      body: Consumer<FlashcardProvider>(
        builder: (context, provider, child){
          return Padding(
            
            padding: EdgeInsets.only(left: 10,right: 10),
            child: ListView.builder(
              itemCount: provider.flashcards.length,
              itemBuilder: (context, index) {
                final flashcard = provider.flashcards[index];
                final bool showAnswer = _showAnswerMap[index] ?? false;
                return InkWell(
                  onTap: () {
                    toggleAnswerVisibility(index); // Toggle answer visibility for the tapped card
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    child: Container(
                        width: 200, // Card width
                        height: 300,
            
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFFAEB0AE), // Container color
                          borderRadius: BorderRadius.circular(12), // Set the radius here
                        ),
                        child: showAnswer ?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Answer",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddEditScreen(
                                              flashcard: flashcard,
                                              onSave: (updatedFlashcard) {
                                                setState(() {
                                                  provider.updateFlashcard(index, updatedFlashcard);
                                                });
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () => deleteFlashcard(context, index),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Flexible(
            
                              child: Center(
                                child: Text(
                                  flashcard.answer,
                                  style: TextStyle(fontSize: 16),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                          ],
                        )
                            :
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Question",
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddEditScreen(
                                              flashcard: flashcard,
                                              onSave: (updatedFlashcard) {
                                                setState(() {
                                                  provider.updateFlashcard(index, updatedFlashcard);
                                                });
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () => deleteFlashcard(context, index),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Flexible(
                              child: Text(
                                flashcard.question,
                                style: TextStyle(fontSize: 16),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        )
            
                    ),
                  ),
                );
              },
            ),
          );
        }

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditScreen(
                onSave: (newFlashcard) {
                  Provider.of<FlashcardProvider>(context, listen: false)
                      .addFlashcard(newFlashcard);
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
