import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/book.dart';
import 'package:uuid/uuid.dart';

class Storage extends ChangeNotifier {
  static const _kKey = 'biblioteca_books_v1';
  final SharedPreferences _prefs;
  List<Book> books = [];

  Storage._(this._prefs);

  static Future<Storage> create() async {
    final p = await SharedPreferences.getInstance();
    final s = Storage._(p);
    s._load();
    return s;
  }

  void _load() {
    final raw = _prefs.getStringList(_kKey) ?? [];
    books = raw.map((e) => Book.fromJson(e)).toList();
    notifyListeners();
  }

  Future<void> _save() async {
    final raw = books.map((b) => b.toJson()).toList();
    await _prefs.setStringList(_kKey, raw);
  }

  Future<void> addBook(String title, String author, String description) async {
    final book = Book(id: const Uuid().v4(), title: title, author: author, description: description);
    books.insert(0, book);
    await _save();
    notifyListeners();
  }

  Future<void> updateBook(Book book) async {
    final idx = books.indexWhere((b) => b.id == book.id);
    if (idx >= 0) books[idx] = book;
    await _save();
    notifyListeners();
  }

  Future<void> removeBook(String id) async {
    books.removeWhere((b) => b.id == id);
    await _save();
    notifyListeners();
  }

  Future<void> toggleBorrow(String id) async {
    final idx = books.indexWhere((b) => b.id == id);
    if (idx < 0) return;
    books[idx].borrowed = !books[idx].borrowed;
    books[idx].borrowedAt = books[idx].borrowed ? DateTime.now() : null;
    await _save();
    notifyListeners();
  }
}