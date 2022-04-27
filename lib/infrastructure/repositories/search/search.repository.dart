import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/failure.dart';
import 'package:xplore_bg_v2/models/models.dart';

final clientProvider = Provider((ref) {
  final token = dotenv.env['MS_API_KEY'];
  return Dio(
    BaseOptions(
      baseUrl: 'https://xplorebg.ddns.net',
      headers: {
        "Authorization": "Bearer $token",
      },
    ),
  );
});

final searcRepositoryProvider = Provider<SearchRepository>((ref) {
  return SearchRepository(ref.read);
});

abstract class ISearchRepository {
  Future<Map<String, dynamic>?> getDocument(
    String indexUid,
    String id, {
    CancelToken? cancelToken,
  });

  Future<SearchResultModel> search(
    String indexUid, {
    String? query,
    int? offset,
    int? limit,
    filter,
    List<String>? sort,
    List<String>? facetsDistribution,
    List<String>? attributesToRetrieve,
    List<String>? attributesToCrop,
    int? cropLength,
    List<String>? attributesToHighlight,
    bool? matches,
    CancelToken? cancelToken,
  });
}

class SearchRepository implements ISearchRepository {
  final Reader _read;

  const SearchRepository(this._read);

  final List<String> previewAttributes = const [
    "loc_id",
    "name",
    "thumbnail",
    "category",
    "subcategory",
    "rating",
    "bookmark_count",
    "like_count",
    "review_count",
    "rating",
    "residence",
    "region",
    "_geo",
  ];

  @override
  Future<Map<String, dynamic>?> getDocument(
    String indexUid,
    String id, {
    CancelToken? cancelToken,
  }) async {
    final client = _read(clientProvider);

    try {
      final response = await client.get<Map<String, dynamic>?>(
        "/indexes/$indexUid/documents/$id",
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioError catch (e) {
      throw Failure.fromDioError(e);
    }
  }

  @override
  Future<SearchResultModel> search(
    String indexUid, {
    String? query,
    int? offset,
    int? limit,
    filter,
    List<String>? sort,
    List<String>? facetsDistribution,
    List<String>? attributesToRetrieve,
    List<String>? attributesToCrop,
    int? cropLength,
    List<String>? attributesToHighlight,
    bool? matches,
    CancelToken? cancelToken,
  }) async {
    final client = _read(clientProvider);
    final data = <String, dynamic>{
      'q': query,
      'offset': offset,
      'limit': limit,
      'filter': filter,
      'sort': sort,
      'facetsDistribution': facetsDistribution,
      'attributesToRetrieve': attributesToRetrieve,
      'attributesToCrop': attributesToCrop,
      'cropLength': cropLength,
      'attributesToHighlight': attributesToHighlight,
      'matches': matches,
    };
    data.removeWhere((k, v) => v == null);
    try {
      final response = await client.post(
        '/indexes/$indexUid/search',
        data: data,
        cancelToken: cancelToken,
      );
      return SearchResultModel.fromMap(response.data);
    } on DioError catch (e) {
      throw Failure.fromDioError(e);
    }
  }
}
