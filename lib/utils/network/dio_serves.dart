import 'package:dio/dio.dart';
import 'package:news_app/utils/network/end_points.dart';

abstract class DioServes {
  static final dio = Dio();

  static getTimesData({Map<String, dynamic>? query, data, time}) async {
    final response = await dio.get(
      'https://api.aladhan.com${EndPoints.timeEndPoint}$time',
      queryParameters: query,
      data: data,
    );
    return response;
  }

  static getRadioData({Map<String, dynamic>? query, data}) async {
    final response = await dio.get(
      '${EndPoints.radioUrl}',
      queryParameters: query,
      data: data,
    );
    return response;
  }
}
