// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OrderHistoryState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CartOrderEntity> orders) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CartOrderEntity> orders)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CartOrderEntity> orders)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OrderHistoryInitial value) initial,
    required TResult Function(OrderHistoryLoading value) loading,
    required TResult Function(OrderHistoryLoaded value) loaded,
    required TResult Function(OrderHistoryError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderHistoryInitial value)? initial,
    TResult? Function(OrderHistoryLoading value)? loading,
    TResult? Function(OrderHistoryLoaded value)? loaded,
    TResult? Function(OrderHistoryError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderHistoryInitial value)? initial,
    TResult Function(OrderHistoryLoading value)? loading,
    TResult Function(OrderHistoryLoaded value)? loaded,
    TResult Function(OrderHistoryError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderHistoryStateCopyWith<$Res> {
  factory $OrderHistoryStateCopyWith(
          OrderHistoryState value, $Res Function(OrderHistoryState) then) =
      _$OrderHistoryStateCopyWithImpl<$Res, OrderHistoryState>;
}

/// @nodoc
class _$OrderHistoryStateCopyWithImpl<$Res, $Val extends OrderHistoryState>
    implements $OrderHistoryStateCopyWith<$Res> {
  _$OrderHistoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$OrderHistoryInitialImplCopyWith<$Res> {
  factory _$$OrderHistoryInitialImplCopyWith(_$OrderHistoryInitialImpl value,
          $Res Function(_$OrderHistoryInitialImpl) then) =
      __$$OrderHistoryInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OrderHistoryInitialImplCopyWithImpl<$Res>
    extends _$OrderHistoryStateCopyWithImpl<$Res, _$OrderHistoryInitialImpl>
    implements _$$OrderHistoryInitialImplCopyWith<$Res> {
  __$$OrderHistoryInitialImplCopyWithImpl(_$OrderHistoryInitialImpl _value,
      $Res Function(_$OrderHistoryInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OrderHistoryInitialImpl implements OrderHistoryInitial {
  const _$OrderHistoryInitialImpl();

  @override
  String toString() {
    return 'OrderHistoryState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderHistoryInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CartOrderEntity> orders) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CartOrderEntity> orders)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CartOrderEntity> orders)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OrderHistoryInitial value) initial,
    required TResult Function(OrderHistoryLoading value) loading,
    required TResult Function(OrderHistoryLoaded value) loaded,
    required TResult Function(OrderHistoryError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderHistoryInitial value)? initial,
    TResult? Function(OrderHistoryLoading value)? loading,
    TResult? Function(OrderHistoryLoaded value)? loaded,
    TResult? Function(OrderHistoryError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderHistoryInitial value)? initial,
    TResult Function(OrderHistoryLoading value)? loading,
    TResult Function(OrderHistoryLoaded value)? loaded,
    TResult Function(OrderHistoryError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class OrderHistoryInitial implements OrderHistoryState {
  const factory OrderHistoryInitial() = _$OrderHistoryInitialImpl;
}

/// @nodoc
abstract class _$$OrderHistoryLoadingImplCopyWith<$Res> {
  factory _$$OrderHistoryLoadingImplCopyWith(_$OrderHistoryLoadingImpl value,
          $Res Function(_$OrderHistoryLoadingImpl) then) =
      __$$OrderHistoryLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OrderHistoryLoadingImplCopyWithImpl<$Res>
    extends _$OrderHistoryStateCopyWithImpl<$Res, _$OrderHistoryLoadingImpl>
    implements _$$OrderHistoryLoadingImplCopyWith<$Res> {
  __$$OrderHistoryLoadingImplCopyWithImpl(_$OrderHistoryLoadingImpl _value,
      $Res Function(_$OrderHistoryLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$OrderHistoryLoadingImpl implements OrderHistoryLoading {
  const _$OrderHistoryLoadingImpl();

  @override
  String toString() {
    return 'OrderHistoryState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderHistoryLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CartOrderEntity> orders) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CartOrderEntity> orders)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CartOrderEntity> orders)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OrderHistoryInitial value) initial,
    required TResult Function(OrderHistoryLoading value) loading,
    required TResult Function(OrderHistoryLoaded value) loaded,
    required TResult Function(OrderHistoryError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderHistoryInitial value)? initial,
    TResult? Function(OrderHistoryLoading value)? loading,
    TResult? Function(OrderHistoryLoaded value)? loaded,
    TResult? Function(OrderHistoryError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderHistoryInitial value)? initial,
    TResult Function(OrderHistoryLoading value)? loading,
    TResult Function(OrderHistoryLoaded value)? loaded,
    TResult Function(OrderHistoryError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class OrderHistoryLoading implements OrderHistoryState {
  const factory OrderHistoryLoading() = _$OrderHistoryLoadingImpl;
}

/// @nodoc
abstract class _$$OrderHistoryLoadedImplCopyWith<$Res> {
  factory _$$OrderHistoryLoadedImplCopyWith(_$OrderHistoryLoadedImpl value,
          $Res Function(_$OrderHistoryLoadedImpl) then) =
      __$$OrderHistoryLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CartOrderEntity> orders});
}

/// @nodoc
class __$$OrderHistoryLoadedImplCopyWithImpl<$Res>
    extends _$OrderHistoryStateCopyWithImpl<$Res, _$OrderHistoryLoadedImpl>
    implements _$$OrderHistoryLoadedImplCopyWith<$Res> {
  __$$OrderHistoryLoadedImplCopyWithImpl(_$OrderHistoryLoadedImpl _value,
      $Res Function(_$OrderHistoryLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orders = null,
  }) {
    return _then(_$OrderHistoryLoadedImpl(
      null == orders
          ? _value._orders
          : orders // ignore: cast_nullable_to_non_nullable
              as List<CartOrderEntity>,
    ));
  }
}

/// @nodoc

class _$OrderHistoryLoadedImpl implements OrderHistoryLoaded {
  const _$OrderHistoryLoadedImpl(final List<CartOrderEntity> orders)
      : _orders = orders;

  final List<CartOrderEntity> _orders;
  @override
  List<CartOrderEntity> get orders {
    if (_orders is EqualUnmodifiableListView) return _orders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orders);
  }

  @override
  String toString() {
    return 'OrderHistoryState.loaded(orders: $orders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderHistoryLoadedImpl &&
            const DeepCollectionEquality().equals(other._orders, _orders));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_orders));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderHistoryLoadedImplCopyWith<_$OrderHistoryLoadedImpl> get copyWith =>
      __$$OrderHistoryLoadedImplCopyWithImpl<_$OrderHistoryLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CartOrderEntity> orders) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(orders);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CartOrderEntity> orders)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(orders);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CartOrderEntity> orders)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(orders);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OrderHistoryInitial value) initial,
    required TResult Function(OrderHistoryLoading value) loading,
    required TResult Function(OrderHistoryLoaded value) loaded,
    required TResult Function(OrderHistoryError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderHistoryInitial value)? initial,
    TResult? Function(OrderHistoryLoading value)? loading,
    TResult? Function(OrderHistoryLoaded value)? loaded,
    TResult? Function(OrderHistoryError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderHistoryInitial value)? initial,
    TResult Function(OrderHistoryLoading value)? loading,
    TResult Function(OrderHistoryLoaded value)? loaded,
    TResult Function(OrderHistoryError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class OrderHistoryLoaded implements OrderHistoryState {
  const factory OrderHistoryLoaded(final List<CartOrderEntity> orders) =
      _$OrderHistoryLoadedImpl;

  List<CartOrderEntity> get orders;
  @JsonKey(ignore: true)
  _$$OrderHistoryLoadedImplCopyWith<_$OrderHistoryLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OrderHistoryErrorImplCopyWith<$Res> {
  factory _$$OrderHistoryErrorImplCopyWith(_$OrderHistoryErrorImpl value,
          $Res Function(_$OrderHistoryErrorImpl) then) =
      __$$OrderHistoryErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$OrderHistoryErrorImplCopyWithImpl<$Res>
    extends _$OrderHistoryStateCopyWithImpl<$Res, _$OrderHistoryErrorImpl>
    implements _$$OrderHistoryErrorImplCopyWith<$Res> {
  __$$OrderHistoryErrorImplCopyWithImpl(_$OrderHistoryErrorImpl _value,
      $Res Function(_$OrderHistoryErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$OrderHistoryErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$OrderHistoryErrorImpl implements OrderHistoryError {
  const _$OrderHistoryErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'OrderHistoryState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderHistoryErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderHistoryErrorImplCopyWith<_$OrderHistoryErrorImpl> get copyWith =>
      __$$OrderHistoryErrorImplCopyWithImpl<_$OrderHistoryErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<CartOrderEntity> orders) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<CartOrderEntity> orders)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<CartOrderEntity> orders)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OrderHistoryInitial value) initial,
    required TResult Function(OrderHistoryLoading value) loading,
    required TResult Function(OrderHistoryLoaded value) loaded,
    required TResult Function(OrderHistoryError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OrderHistoryInitial value)? initial,
    TResult? Function(OrderHistoryLoading value)? loading,
    TResult? Function(OrderHistoryLoaded value)? loaded,
    TResult? Function(OrderHistoryError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OrderHistoryInitial value)? initial,
    TResult Function(OrderHistoryLoading value)? loading,
    TResult Function(OrderHistoryLoaded value)? loaded,
    TResult Function(OrderHistoryError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class OrderHistoryError implements OrderHistoryState {
  const factory OrderHistoryError(final String message) =
      _$OrderHistoryErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$OrderHistoryErrorImplCopyWith<_$OrderHistoryErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
