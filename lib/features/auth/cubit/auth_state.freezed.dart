// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthState {
  AuthData? get data => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            AuthData? data, bool loading, String? errorMessage)
        initial,
    required TResult Function(
            AuthData? data, bool loading, String? errorMessage)
        loading,
    required TResult Function(AuthData data, bool loading, String? errorMessage)
        authenticated,
    required TResult Function(AuthData? data, bool loading, String errorMessage)
        error,
    required TResult Function(
            AuthData? data, bool loading, String? errorMessage)
        unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthData? data, bool loading, String? errorMessage)?
        initial,
    TResult? Function(AuthData? data, bool loading, String? errorMessage)?
        loading,
    TResult? Function(AuthData data, bool loading, String? errorMessage)?
        authenticated,
    TResult? Function(AuthData? data, bool loading, String errorMessage)? error,
    TResult? Function(AuthData? data, bool loading, String? errorMessage)?
        unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthData? data, bool loading, String? errorMessage)?
        initial,
    TResult Function(AuthData? data, bool loading, String? errorMessage)?
        loading,
    TResult Function(AuthData data, bool loading, String? errorMessage)?
        authenticated,
    TResult Function(AuthData? data, bool loading, String errorMessage)? error,
    TResult Function(AuthData? data, bool loading, String? errorMessage)?
        unauthenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthError value)? error,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call({AuthData data, bool loading, String errorMessage});
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? loading = null,
    Object? errorMessage = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data!
          : data // ignore: cast_nullable_to_non_nullable
              as AuthData,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage!
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthInitialImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthInitialImplCopyWith(
          _$AuthInitialImpl value, $Res Function(_$AuthInitialImpl) then) =
      __$$AuthInitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthData? data, bool loading, String? errorMessage});
}

/// @nodoc
class __$$AuthInitialImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthInitialImpl>
    implements _$$AuthInitialImplCopyWith<$Res> {
  __$$AuthInitialImplCopyWithImpl(
      _$AuthInitialImpl _value, $Res Function(_$AuthInitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? loading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$AuthInitialImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AuthData?,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthInitialImpl implements AuthInitial {
  const _$AuthInitialImpl({this.data, this.loading = false, this.errorMessage});

  @override
  final AuthData? data;
  @override
  @JsonKey()
  final bool loading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AuthState.initial(data: $data, loading: $loading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthInitialImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, loading, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthInitialImplCopyWith<_$AuthInitialImpl> get copyWith =>
      __$$AuthInitialImplCopyWithImpl<_$AuthInitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            AuthData? data, bool loading, String? errorMessage)
        initial,
    required TResult Function(
            AuthData? data, bool loading, String? errorMessage)
        loading,
    required TResult Function(AuthData data, bool loading, String? errorMessage)
        authenticated,
    required TResult Function(AuthData? data, bool loading, String errorMessage)
        error,
    required TResult Function(
            AuthData? data, bool loading, String? errorMessage)
        unauthenticated,
  }) {
    return initial(data, this.loading, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthData? data, bool loading, String? errorMessage)?
        initial,
    TResult? Function(AuthData? data, bool loading, String? errorMessage)?
        loading,
    TResult? Function(AuthData data, bool loading, String? errorMessage)?
        authenticated,
    TResult? Function(AuthData? data, bool loading, String errorMessage)? error,
    TResult? Function(AuthData? data, bool loading, String? errorMessage)?
        unauthenticated,
  }) {
    return initial?.call(data, this.loading, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthData? data, bool loading, String? errorMessage)?
        initial,
    TResult Function(AuthData? data, bool loading, String? errorMessage)?
        loading,
    TResult Function(AuthData data, bool loading, String? errorMessage)?
        authenticated,
    TResult Function(AuthData? data, bool loading, String errorMessage)? error,
    TResult Function(AuthData? data, bool loading, String? errorMessage)?
        unauthenticated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(data, this.loading, errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthError value)? error,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AuthInitial implements AuthState {
  const factory AuthInitial(
      {final AuthData? data,
      final bool loading,
      final String? errorMessage}) = _$AuthInitialImpl;

  @override
  AuthData? get data;
  @override
  bool get loading;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$AuthInitialImplCopyWith<_$AuthInitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthLoadingImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthLoadingImplCopyWith(
          _$AuthLoadingImpl value, $Res Function(_$AuthLoadingImpl) then) =
      __$$AuthLoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthData? data, bool loading, String? errorMessage});
}

/// @nodoc
class __$$AuthLoadingImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthLoadingImpl>
    implements _$$AuthLoadingImplCopyWith<$Res> {
  __$$AuthLoadingImplCopyWithImpl(
      _$AuthLoadingImpl _value, $Res Function(_$AuthLoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? loading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$AuthLoadingImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AuthData?,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthLoadingImpl implements AuthLoading {
  const _$AuthLoadingImpl({this.data, this.loading = true, this.errorMessage});

  @override
  final AuthData? data;
  @override
  @JsonKey()
  final bool loading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AuthState.loading(data: $data, loading: $loading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthLoadingImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, loading, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthLoadingImplCopyWith<_$AuthLoadingImpl> get copyWith =>
      __$$AuthLoadingImplCopyWithImpl<_$AuthLoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            AuthData? data, bool loading, String? errorMessage)
        initial,
    required TResult Function(
            AuthData? data, bool loading, String? errorMessage)
        loading,
    required TResult Function(AuthData data, bool loading, String? errorMessage)
        authenticated,
    required TResult Function(AuthData? data, bool loading, String errorMessage)
        error,
    required TResult Function(
            AuthData? data, bool loading, String? errorMessage)
        unauthenticated,
  }) {
    return loading(data, this.loading, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthData? data, bool loading, String? errorMessage)?
        initial,
    TResult? Function(AuthData? data, bool loading, String? errorMessage)?
        loading,
    TResult? Function(AuthData data, bool loading, String? errorMessage)?
        authenticated,
    TResult? Function(AuthData? data, bool loading, String errorMessage)? error,
    TResult? Function(AuthData? data, bool loading, String? errorMessage)?
        unauthenticated,
  }) {
    return loading?.call(data, this.loading, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthData? data, bool loading, String? errorMessage)?
        initial,
    TResult Function(AuthData? data, bool loading, String? errorMessage)?
        loading,
    TResult Function(AuthData data, bool loading, String? errorMessage)?
        authenticated,
    TResult Function(AuthData? data, bool loading, String errorMessage)? error,
    TResult Function(AuthData? data, bool loading, String? errorMessage)?
        unauthenticated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(data, this.loading, errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthError value)? error,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AuthLoading implements AuthState {
  const factory AuthLoading(
      {final AuthData? data,
      final bool loading,
      final String? errorMessage}) = _$AuthLoadingImpl;

  @override
  AuthData? get data;
  @override
  bool get loading;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$AuthLoadingImplCopyWith<_$AuthLoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthAuthenticatedImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthAuthenticatedImplCopyWith(_$AuthAuthenticatedImpl value,
          $Res Function(_$AuthAuthenticatedImpl) then) =
      __$$AuthAuthenticatedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthData data, bool loading, String? errorMessage});
}

/// @nodoc
class __$$AuthAuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthAuthenticatedImpl>
    implements _$$AuthAuthenticatedImplCopyWith<$Res> {
  __$$AuthAuthenticatedImplCopyWithImpl(_$AuthAuthenticatedImpl _value,
      $Res Function(_$AuthAuthenticatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? loading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$AuthAuthenticatedImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AuthData,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthAuthenticatedImpl implements AuthAuthenticated {
  const _$AuthAuthenticatedImpl(
      {required this.data, this.loading = false, this.errorMessage});

  @override
  final AuthData data;
  @override
  @JsonKey()
  final bool loading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AuthState.authenticated(data: $data, loading: $loading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthAuthenticatedImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, loading, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthAuthenticatedImplCopyWith<_$AuthAuthenticatedImpl> get copyWith =>
      __$$AuthAuthenticatedImplCopyWithImpl<_$AuthAuthenticatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            AuthData? data, bool loading, String? errorMessage)
        initial,
    required TResult Function(
            AuthData? data, bool loading, String? errorMessage)
        loading,
    required TResult Function(AuthData data, bool loading, String? errorMessage)
        authenticated,
    required TResult Function(AuthData? data, bool loading, String errorMessage)
        error,
    required TResult Function(
            AuthData? data, bool loading, String? errorMessage)
        unauthenticated,
  }) {
    return authenticated(data, this.loading, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthData? data, bool loading, String? errorMessage)?
        initial,
    TResult? Function(AuthData? data, bool loading, String? errorMessage)?
        loading,
    TResult? Function(AuthData data, bool loading, String? errorMessage)?
        authenticated,
    TResult? Function(AuthData? data, bool loading, String errorMessage)? error,
    TResult? Function(AuthData? data, bool loading, String? errorMessage)?
        unauthenticated,
  }) {
    return authenticated?.call(data, this.loading, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthData? data, bool loading, String? errorMessage)?
        initial,
    TResult Function(AuthData? data, bool loading, String? errorMessage)?
        loading,
    TResult Function(AuthData data, bool loading, String? errorMessage)?
        authenticated,
    TResult Function(AuthData? data, bool loading, String errorMessage)? error,
    TResult Function(AuthData? data, bool loading, String? errorMessage)?
        unauthenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(data, this.loading, errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthError value)? error,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthAuthenticated implements AuthState {
  const factory AuthAuthenticated(
      {required final AuthData data,
      final bool loading,
      final String? errorMessage}) = _$AuthAuthenticatedImpl;

  @override
  AuthData get data;
  @override
  bool get loading;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$AuthAuthenticatedImplCopyWith<_$AuthAuthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthErrorImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthErrorImplCopyWith(
          _$AuthErrorImpl value, $Res Function(_$AuthErrorImpl) then) =
      __$$AuthErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthData? data, bool loading, String errorMessage});
}

/// @nodoc
class __$$AuthErrorImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthErrorImpl>
    implements _$$AuthErrorImplCopyWith<$Res> {
  __$$AuthErrorImplCopyWithImpl(
      _$AuthErrorImpl _value, $Res Function(_$AuthErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? loading = null,
    Object? errorMessage = null,
  }) {
    return _then(_$AuthErrorImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AuthData?,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthErrorImpl implements AuthError {
  const _$AuthErrorImpl(
      {this.data, this.loading = false, required this.errorMessage});

  @override
  final AuthData? data;
  @override
  @JsonKey()
  final bool loading;
  @override
  final String errorMessage;

  @override
  String toString() {
    return 'AuthState.error(data: $data, loading: $loading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthErrorImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, loading, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthErrorImplCopyWith<_$AuthErrorImpl> get copyWith =>
      __$$AuthErrorImplCopyWithImpl<_$AuthErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            AuthData? data, bool loading, String? errorMessage)
        initial,
    required TResult Function(
            AuthData? data, bool loading, String? errorMessage)
        loading,
    required TResult Function(AuthData data, bool loading, String? errorMessage)
        authenticated,
    required TResult Function(AuthData? data, bool loading, String errorMessage)
        error,
    required TResult Function(
            AuthData? data, bool loading, String? errorMessage)
        unauthenticated,
  }) {
    return error(data, this.loading, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthData? data, bool loading, String? errorMessage)?
        initial,
    TResult? Function(AuthData? data, bool loading, String? errorMessage)?
        loading,
    TResult? Function(AuthData data, bool loading, String? errorMessage)?
        authenticated,
    TResult? Function(AuthData? data, bool loading, String errorMessage)? error,
    TResult? Function(AuthData? data, bool loading, String? errorMessage)?
        unauthenticated,
  }) {
    return error?.call(data, this.loading, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthData? data, bool loading, String? errorMessage)?
        initial,
    TResult Function(AuthData? data, bool loading, String? errorMessage)?
        loading,
    TResult Function(AuthData data, bool loading, String? errorMessage)?
        authenticated,
    TResult Function(AuthData? data, bool loading, String errorMessage)? error,
    TResult Function(AuthData? data, bool loading, String? errorMessage)?
        unauthenticated,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(data, this.loading, errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthError value)? error,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AuthError implements AuthState {
  const factory AuthError(
      {final AuthData? data,
      final bool loading,
      required final String errorMessage}) = _$AuthErrorImpl;

  @override
  AuthData? get data;
  @override
  bool get loading;
  @override
  String get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$AuthErrorImplCopyWith<_$AuthErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthUnauthenticatedImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthUnauthenticatedImplCopyWith(_$AuthUnauthenticatedImpl value,
          $Res Function(_$AuthUnauthenticatedImpl) then) =
      __$$AuthUnauthenticatedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthData? data, bool loading, String? errorMessage});
}

/// @nodoc
class __$$AuthUnauthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthUnauthenticatedImpl>
    implements _$$AuthUnauthenticatedImplCopyWith<$Res> {
  __$$AuthUnauthenticatedImplCopyWithImpl(_$AuthUnauthenticatedImpl _value,
      $Res Function(_$AuthUnauthenticatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? loading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$AuthUnauthenticatedImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as AuthData?,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AuthUnauthenticatedImpl implements AuthUnauthenticated {
  const _$AuthUnauthenticatedImpl(
      {this.data, this.loading = false, this.errorMessage});

  @override
  final AuthData? data;
  @override
  @JsonKey()
  final bool loading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'AuthState.unauthenticated(data: $data, loading: $loading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUnauthenticatedImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data, loading, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUnauthenticatedImplCopyWith<_$AuthUnauthenticatedImpl> get copyWith =>
      __$$AuthUnauthenticatedImplCopyWithImpl<_$AuthUnauthenticatedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            AuthData? data, bool loading, String? errorMessage)
        initial,
    required TResult Function(
            AuthData? data, bool loading, String? errorMessage)
        loading,
    required TResult Function(AuthData data, bool loading, String? errorMessage)
        authenticated,
    required TResult Function(AuthData? data, bool loading, String errorMessage)
        error,
    required TResult Function(
            AuthData? data, bool loading, String? errorMessage)
        unauthenticated,
  }) {
    return unauthenticated(data, this.loading, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthData? data, bool loading, String? errorMessage)?
        initial,
    TResult? Function(AuthData? data, bool loading, String? errorMessage)?
        loading,
    TResult? Function(AuthData data, bool loading, String? errorMessage)?
        authenticated,
    TResult? Function(AuthData? data, bool loading, String errorMessage)? error,
    TResult? Function(AuthData? data, bool loading, String? errorMessage)?
        unauthenticated,
  }) {
    return unauthenticated?.call(data, this.loading, errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthData? data, bool loading, String? errorMessage)?
        initial,
    TResult Function(AuthData? data, bool loading, String? errorMessage)?
        loading,
    TResult Function(AuthData data, bool loading, String? errorMessage)?
        authenticated,
    TResult Function(AuthData? data, bool loading, String errorMessage)? error,
    TResult Function(AuthData? data, bool loading, String? errorMessage)?
        unauthenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(data, this.loading, errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthInitial value) initial,
    required TResult Function(AuthLoading value) loading,
    required TResult Function(AuthAuthenticated value) authenticated,
    required TResult Function(AuthError value) error,
    required TResult Function(AuthUnauthenticated value) unauthenticated,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthInitial value)? initial,
    TResult? Function(AuthLoading value)? loading,
    TResult? Function(AuthAuthenticated value)? authenticated,
    TResult? Function(AuthError value)? error,
    TResult? Function(AuthUnauthenticated value)? unauthenticated,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthInitial value)? initial,
    TResult Function(AuthLoading value)? loading,
    TResult Function(AuthAuthenticated value)? authenticated,
    TResult Function(AuthError value)? error,
    TResult Function(AuthUnauthenticated value)? unauthenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class AuthUnauthenticated implements AuthState {
  const factory AuthUnauthenticated(
      {final AuthData? data,
      final bool loading,
      final String? errorMessage}) = _$AuthUnauthenticatedImpl;

  @override
  AuthData? get data;
  @override
  bool get loading;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$AuthUnauthenticatedImplCopyWith<_$AuthUnauthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
