//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'test_controller_api.g.dart';

@RestApi()
abstract class TestControllerApi {
  factory TestControllerApi(Dio dio, {String? baseUrl}) = _TestControllerApi;

  /// home
  ///
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/')
  Future<String> home({CancelToken? cancelToken});
}
