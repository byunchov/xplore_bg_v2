// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'pagination_offset.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PaginationOffset<T> {
  int get offset => throw _privateConstructorUsedError;
  T get item => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PaginationOffsetCopyWith<T, PaginationOffset<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationOffsetCopyWith<T, $Res> {
  factory $PaginationOffsetCopyWith(
          PaginationOffset<T> value, $Res Function(PaginationOffset<T>) then) =
      _$PaginationOffsetCopyWithImpl<T, $Res>;
  $Res call({int offset, T item});
}

/// @nodoc
class _$PaginationOffsetCopyWithImpl<T, $Res>
    implements $PaginationOffsetCopyWith<T, $Res> {
  _$PaginationOffsetCopyWithImpl(this._value, this._then);

  final PaginationOffset<T> _value;
  // ignore: unused_field
  final $Res Function(PaginationOffset<T>) _then;

  @override
  $Res call({
    Object? offset = freezed,
    Object? item = freezed,
  }) {
    return _then(_value.copyWith(
      offset: offset == freezed
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      item: item == freezed
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
abstract class _$PaginationOffsetCopyWith<T, $Res>
    implements $PaginationOffsetCopyWith<T, $Res> {
  factory _$PaginationOffsetCopyWith(_PaginationOffset<T> value,
          $Res Function(_PaginationOffset<T>) then) =
      __$PaginationOffsetCopyWithImpl<T, $Res>;
  @override
  $Res call({int offset, T item});
}

/// @nodoc
class __$PaginationOffsetCopyWithImpl<T, $Res>
    extends _$PaginationOffsetCopyWithImpl<T, $Res>
    implements _$PaginationOffsetCopyWith<T, $Res> {
  __$PaginationOffsetCopyWithImpl(
      _PaginationOffset<T> _value, $Res Function(_PaginationOffset<T>) _then)
      : super(_value, (v) => _then(v as _PaginationOffset<T>));

  @override
  _PaginationOffset<T> get _value => super._value as _PaginationOffset<T>;

  @override
  $Res call({
    Object? offset = freezed,
    Object? item = freezed,
  }) {
    return _then(_PaginationOffset<T>(
      offset: offset == freezed
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      item: item == freezed
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_PaginationOffset<T> implements _PaginationOffset<T> {
  _$_PaginationOffset({required this.offset, required this.item});

  @override
  final int offset;
  @override
  final T item;

  @override
  String toString() {
    return 'PaginationOffset<$T>(offset: $offset, item: $item)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PaginationOffset<T> &&
            const DeepCollectionEquality().equals(other.offset, offset) &&
            const DeepCollectionEquality().equals(other.item, item));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(offset),
      const DeepCollectionEquality().hash(item));

  @JsonKey(ignore: true)
  @override
  _$PaginationOffsetCopyWith<T, _PaginationOffset<T>> get copyWith =>
      __$PaginationOffsetCopyWithImpl<T, _PaginationOffset<T>>(
          this, _$identity);
}

abstract class _PaginationOffset<T> implements PaginationOffset<T> {
  factory _PaginationOffset(
      {required final int offset,
      required final T item}) = _$_PaginationOffset<T>;

  @override
  int get offset => throw _privateConstructorUsedError;
  @override
  T get item => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PaginationOffsetCopyWith<T, _PaginationOffset<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
