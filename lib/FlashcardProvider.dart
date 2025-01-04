import 'package:flutter/material.dart';
import 'Flashcard.dart';

class FlashcardProvider with ChangeNotifier {
  List<Flashcard> _flashcards = [
    Flashcard(
        question: "What is Flutter?",
        answer: "A UI toolkit for building natively compiled apps."),
    Flashcard(
        question: "What is Dart?",
        answer: "A programming language optimized for building apps."),
    Flashcard(
        question: "What is the difference between a StatefulWidget and a StatelessWidget?",
        answer: "A StatefulWidget can change its state during runtime, while a StatelessWidget cannot."),
    Flashcard(
        question: "What is Firebase?",
        answer: "A platform for building and managing apps, providing features like authentication, databases, and hosting."),
    Flashcard(
        question: "What is the purpose of the 'pubspec.yaml' file in Flutter?",
        answer: "It defines the dependencies and other configuration settings for a Flutter project."),
    Flashcard(
        question: "What is the hot reload feature in Flutter?",
        answer: "A feature that allows developers to instantly see changes in the app without rebuilding from scratch."),
    Flashcard(
        question: "What is a Future in Dart?",
        answer: "A Future represents a value that might not be available yet, used for asynchronous programming."),
    Flashcard(
        question: "What is the difference between 'const' and 'final' in Dart?",
        answer: "Both are used to declare constants, but 'const' is a compile-time constant, while 'final' can be set at runtime."),
    Flashcard(
        question: "What is an Overlay in Flutter?",
        answer: "An Overlay allows you to place widgets on top of other widgets, useful for things like dialogs or tooltips."),
    Flashcard(
        question: "What is the use of the 'setState()' method in Flutter?",
        answer: "It triggers a rebuild of the widget tree when the state of the widget changes."),
  ];

  List<Flashcard> get flashcards => _flashcards;

  void addFlashcard(Flashcard flashcard) {
    _flashcards.add(flashcard);
    notifyListeners();
  }

  void removeFlashcard(int index) {
    _flashcards.removeAt(index);
    notifyListeners();
  }

  void updateFlashcard(int index, Flashcard updatedFlashcard) {
    _flashcards[index] = updatedFlashcard;
    notifyListeners();
  }
}
