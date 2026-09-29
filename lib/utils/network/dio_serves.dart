import 'package:dio/dio.dart';
import 'package:news_app/utils/network/end_points.dart';
import 'package:news_app/utils/utils.dart';

abstract class DioServes {
  static final dio = Dio();

  static getNewsData({Map<String, dynamic>? query, data}) async {
    query?['apiKey']=Utils.apiToken;
    print('${EndPoints.baseUrl}${EndPoints.getNewsByCategory}');
    print(query);
    final response = await dio.get(
      '${EndPoints.baseUrl}${EndPoints.getNewsByCategory}',
      queryParameters: query,
      data: data,
    );

    print(response.headers);
    print(response.data);
    return response;
  }

}
