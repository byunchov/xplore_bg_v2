import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:xplore_bg_v2/models/gallery/gallery.model.dart';

part 'gallery_loading.freezed.dart';

@freezed
class GalleryLoadingModel with _$GalleryLoadingModel {
  const factory GalleryLoadingModel.data(GalleryModel gallery) = _GalleryLoadingData;
  const factory GalleryLoadingModel.loading() = _GalleryLoadingLoading;
  const factory GalleryLoadingModel.error(Object? e, [StackTrace? stk]) = _GalleryLoadingError;
}
