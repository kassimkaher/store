import 'package:freezed_annotation/freezed_annotation.dart';

import 'bookmark_item.dart';

part 'bookmark_state.freezed.dart';

@freezed
class BookmarkState with _$BookmarkState {
  const factory BookmarkState({
    @Default([]) List<BookmarkItem> items,
    @Default(false) bool isLoading,
  }) = _BookmarkState;
}
