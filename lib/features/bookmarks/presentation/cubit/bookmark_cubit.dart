import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../products/domain/entities/product_entity.dart';
import 'bookmark_item.dart';
import 'bookmark_state.dart';

@singleton
class BookmarkCubit extends Cubit<BookmarkState> {
  static const String _bookmarkKey = 'bookmark_items';

  BookmarkCubit() : super(const BookmarkState()) {
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    emit(state.copyWith(isLoading: true));
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarkJson = prefs.getString(_bookmarkKey);

      if (bookmarkJson != null) {
        final List<dynamic> bookmarkList = json.decode(bookmarkJson);
        final items = bookmarkList
            .map((item) => BookmarkItem.fromJson(item))
            .toList();
        emit(state.copyWith(items: items, isLoading: false));
      } else {
        emit(state.copyWith(isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _saveBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bookmarkJson = json.encode(
        state.items.map((item) => item.toJson()).toList(),
      );
      await prefs.setString(_bookmarkKey, bookmarkJson);
    } catch (e) {
      // Handle error
    }
  }

  void toggleBookmark(ProductEntity product) {
    final existingIndex = state.items.indexWhere(
      (item) => item.product.id == product.id,
    );

    List<BookmarkItem> updatedItems;
    if (existingIndex != -1) {
      // Remove bookmark
      updatedItems = List.from(state.items)..removeAt(existingIndex);
    } else {
      // Add bookmark
      updatedItems = [
        BookmarkItem(product: product, addedAt: DateTime.now()),
        ...state.items,
      ];
    }

    emit(state.copyWith(items: updatedItems));
    _saveBookmarks();
  }

  bool isBookmarked(String productId) {
    return state.items.any((item) => item.product.id == productId);
  }

  void removeBookmark(String productId) {
    final updatedItems = state.items
        .where((item) => item.product.id != productId)
        .toList();
    emit(state.copyWith(items: updatedItems));
    _saveBookmarks();
  }

  void clearBookmarks() {
    emit(state.copyWith(items: []));
    _saveBookmarks();
  }

  int get bookmarkCount => state.items.length;
}
