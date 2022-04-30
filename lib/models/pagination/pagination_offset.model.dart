import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_offset.model.freezed.dart';

@freezed
class PaginationOffset<T> with _$PaginationOffset<T> {
  factory PaginationOffset({
    required int offset,
    required T item,
  }) = _PaginationOffset;
}
