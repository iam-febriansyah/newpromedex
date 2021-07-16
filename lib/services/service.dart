import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'base_url.dart';

part 'service.g.dart';

RestClient getClient({required String header}) {
  final dio = Dio();
  dio.options.connectTimeout = BaseUrl.connectTimeout;
  RestClient client = RestClient(dio);
  return client;
}

@RestApi(baseUrl: BaseUrl.MainUrls)
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  // @POST("Auth")
  // Future<ModelReturnLogin> postLogin(@Body() ModelPostLogin param);
}
