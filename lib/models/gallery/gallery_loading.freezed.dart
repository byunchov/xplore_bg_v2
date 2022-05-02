// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'gallery_loading.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GalleryLoadingModel {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GalleryModel gallery) data,
    required TResult Function() loading,
    required TResult Function(Object? e, StackTrace? stk) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(GalleryModel gallery)? data,
    TResult Function()? loading,
    TResult Function(Object? e, StackTrace? stk)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GalleryModel gallery)? data,
    TResult Function()? loading,
    TResult Function(Object? e, StackTrace? stk)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GalleryLoadingData value) data,
    required TResult Function(_GalleryLoadingLoading value) loading,
    required TResult Function(_GalleryLoadingError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_GalleryLoadingData value)? data,
    TResult Function(_GalleryLoadingLoading value)? loading,
    TResult Function(_GalleryLoadingError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GalleryLoadingData value)? data,
    TResult Function(_GalleryLoadingLoading value)? loading,
    TResult Function(_GalleryLoadingError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GalleryLoadingModelCopyWith<$Res> {
  factory $GalleryLoadingModelCopyWith(
          GalleryLoadingModel value, $Res Function(GalleryLoadingModel) then) =
      _$GalleryLoadingModelCopyWithImpl<$Res>;
}

/// @nodoc
class _$GalleryLoadingModelCopyWithImpl<$Res>
    implements $GalleryLoadingModelCopyWith<$Res> {
  _$GalleryLoadingModelCopyWithImpl(this._value, this._then);

  final GalleryLoadingModel _value;
  // ignore: unused_field
  final $Res Function(GalleryLoadingModel) _then;
}

/// @nodoc
abstract class _$GalleryLoadingDataCopyWith<$Res> {
  factory _$GalleryLoadingDataCopyWith(
          _GalleryLoadingData value, $Res Function(_GalleryLoadingData) then) =
      __$GalleryLoadingDataCopyWithImpl<$Res>;
  $Res call({GalleryModel gallery});
}

/// @nodoc
class __$GalleryLoadingDataCopyWithImpl<$Res>
    extends _$GalleryLoadingModelCopyWithImpl<$Res>
    implements _$GalleryLoadingDataCopyWith<$Res> {
  __$GalleryLoadingDataCopyWithImpl(
      _GalleryLoadingData _value, $Res Function(_GalleryLoadingData) _then)
      : super(_value, (v) => _then(v as _GalleryLoadingData));

  @override
  _GalleryLoadingData get _value => super._value as _GalleryLoadingData;

  @override
  $Res call({
    Object? gallery = freezed,
  }) {
    return _then(_GalleryLoadingData(
      gallery == freezed
          ? _value.gallery
          : gallery // ignore: cast_nullable_to_non_nullable
              as GalleryModel,
    ));
  }
}

/// @nodoc

class _$_GalleryLoadingData implements _GalleryLoadingData {
  const _$_GalleryLoadingData(this.gallery);

  @override
  final GalleryModel gallery;

  @override
  String toString() {
    return 'GalleryLoadingModel.data(gallery: $gallery)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryLoadingData &&
            const DeepCollectionEquality().equals(other.gallery, gallery));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(gallery));

  @JsonKey(ignore: true)
  @override
  _$GalleryLoadingDataCopyWith<_GalleryLoadingData> get copyWith =>
      __$GalleryLoadingDataCopyWithImpl<_GalleryLoadingData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GalleryModel gallery) data,
    required TResult Function() loading,
    required TResult Function(Object? e, StackTrace? stk) error,
  }) {
    return data(gallery);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(GalleryModel gallery)? data,
    TResult Function()? loading,
    TResult Function(Object? e, StackTrace? stk)? error,
  }) {
    return data?.call(gallery);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GalleryModel gallery)? data,
    TResult Function()? loading,
    TResult Function(Object? e, StackTrace? stk)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(gallery);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GalleryLoadingData value) data,
    required TResult Function(_GalleryLoadingLoading value) loading,
    required TResult Function(_GalleryLoadingError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_GalleryLoadingData value)? data,
    TResult Function(_GalleryLoadingLoading value)? loading,
    TResult Function(_GalleryLoadingError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GalleryLoadingData value)? data,
    TResult Function(_GalleryLoadingLoading value)? loading,
    TResult Function(_GalleryLoadingError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _GalleryLoadingData implements GalleryLoadingModel {
  const factory _GalleryLoadingData(final GalleryModel gallery) =
      _$_GalleryLoadingData;

  GalleryModel get gallery => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$GalleryLoadingDataCopyWith<_GalleryLoadingData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$GalleryLoadingLoadingCopyWith<$Res> {
  factory _$GalleryLoadingLoadingCopyWith(_GalleryLoadingLoading value,
          $Res Function(_GalleryLoadingLoading) then) =
      __$GalleryLoadingLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$GalleryLoadingLoadingCopyWithImpl<$Res>
    extends _$GalleryLoadingModelCopyWithImpl<$Res>
    implements _$GalleryLoadingLoadingCopyWith<$Res> {
  __$GalleryLoadingLoadingCopyWithImpl(_GalleryLoadingLoading _value,
      $Res Function(_GalleryLoadingLoading) _then)
      : super(_value, (v) => _then(v as _GalleryLoadingLoading));

  @override
  _GalleryLoadingLoading get _value => super._value as _GalleryLoadingLoading;
}

/// @nodoc

class _$_GalleryLoadingLoading implements _GalleryLoadingLoading {
  const _$_GalleryLoadingLoading();

  @override
  String toString() {
    return 'GalleryLoadingModel.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _GalleryLoadingLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GalleryModel gallery) data,
    required TResult Function() loading,
    required TResult Function(Object? e, StackTrace? stk) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(GalleryModel gallery)? data,
    TResult Function()? loading,
    TResult Function(Object? e, StackTrace? stk)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GalleryModel gallery)? data,
    TResult Function()? loading,
    TResult Function(Object? e, StackTrace? stk)? error,
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
    required TResult Function(_GalleryLoadingData value) data,
    required TResult Function(_GalleryLoadingLoading value) loading,
    required TResult Function(_GalleryLoadingError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_GalleryLoadingData value)? data,
    TResult Function(_GalleryLoadingLoading value)? loading,
    TResult Function(_GalleryLoadingError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GalleryLoadingData value)? data,
    TResult Function(_GalleryLoadingLoading value)? loading,
    TResult Function(_GalleryLoadingError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _GalleryLoadingLoading implements GalleryLoadingModel {
  const factory _GalleryLoadingLoading() = _$_GalleryLoadingLoading;
}

/// @nodoc
abstract class _$GalleryLoadingErrorCopyWith<$Res> {
  factory _$GalleryLoadingErrorCopyWith(_GalleryLoadingError value,
          $Res Function(_GalleryLoadingError) then) =
      __$GalleryLoadingErrorCopyWithImpl<$Res>;
  $Res call({Object? e, StackTrace? stk});
}

/// @nodoc
class __$GalleryLoadingErrorCopyWithImpl<$Res>
    extends _$GalleryLoadingModelCopyWithImpl<$Res>
    implements _$GalleryLoadingErrorCopyWith<$Res> {
  __$GalleryLoadingErrorCopyWithImpl(
      _GalleryLoadingError _value, $Res Function(_GalleryLoadingError) _then)
      : super(_value, (v) => _then(v as _GalleryLoadingError));

  @override
  _GalleryLoadingError get _value => super._value as _GalleryLoadingError;

  @override
  $Res call({
    Object? e = freezed,
    Object? stk = freezed,
  }) {
    return _then(_GalleryLoadingError(
      e == freezed ? _value.e : e,
      stk == freezed
          ? _value.stk
          : stk // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$_GalleryLoadingError implements _GalleryLoadingError {
  const _$_GalleryLoadingError(this.e, [this.stk]);

  @override
  final Object? e;
  @override
  final StackTrace? stk;

  @override
  String toString() {
    return 'GalleryLoadingModel.error(e: $e, stk: $stk)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GalleryLoadingError &&
            const DeepCollectionEquality().equals(other.e, e) &&
            const DeepCollectionEquality().equals(other.stk, stk));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(e),
      const DeepCollectionEquality().hash(stk));

  @JsonKey(ignore: true)
  @override
  _$GalleryLoadingErrorCopyWith<_GalleryLoadingError> get copyWith =>
      __$GalleryLoadingErrorCopyWithImpl<_GalleryLoadingError>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(GalleryModel gallery) data,
    required TResult Function() loading,
    required TResult Function(Object? e, StackTrace? stk) error,
  }) {
    return error(e, stk);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(GalleryModel gallery)? data,
    TResult Function()? loading,
    TResult Function(Object? e, StackTrace? stk)? error,
  }) {
    return error?.call(e, stk);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(GalleryModel gallery)? data,
    TResult Function()? loading,
    TResult Function(Object? e, StackTrace? stk)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(e, stk);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GalleryLoadingData value) data,
    required TResult Function(_GalleryLoadingLoading value) loading,
    required TResult Function(_GalleryLoadingError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_GalleryLoadingData value)? data,
    TResult Function(_GalleryLoadingLoading value)? loading,
    TResult Function(_GalleryLoadingError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GalleryLoadingData value)? data,
    TResult Function(_GalleryLoadingLoading value)? loading,
    TResult Function(_GalleryLoadingError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _GalleryLoadingError implements GalleryLoadingModel {
  const factory _GalleryLoadingError(final Object? e, [final StackTrace? stk]) =
      _$_GalleryLoadingError;

  Object? get e => throw _privateConstructorUsedError;
  StackTrace? get stk => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$GalleryLoadingErrorCopyWith<_GalleryLoadingError> get copyWith =>
      throw _privateConstructorUsedError;
}
