import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpClient extends http.BaseClient {
  factory HttpClient(String? token) {
    final http.Client client = http.Client();
    return HttpClient._createInstance(client, token);
  }
  HttpClient._createInstance(this._inner, this.token);

  final http.Client _inner;
  final String? token;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    return _inner.send(request);
  }
}

class SanityClient {
  factory SanityClient({
    required String projectId,
    required String dataset,
    String? token,
    bool useCdn = true,
  }) {
    final HttpClient client = HttpClient(token);

    return SanityClient._createInstance(
      client,
      projectId: projectId,
      dataset: dataset,
      useCdn: useCdn,
    );
  }

  SanityClient._createInstance(
      this._client, {
        required this.projectId,
        required this.dataset,
        this.token,
        this.useCdn = true,
      });

  final HttpClient _client;
  final String projectId;
  final String dataset;
  final String? token;
  final bool useCdn;

  Uri _buildUri({required String query, Map<String, dynamic>? params}) {
    final Map<String, dynamic> queryParameters = <String, dynamic>{
      'query': query,
      if (params != null) ...params,
    };
    return Uri(
      scheme: 'https',
      host: '$projectId.${useCdn ? 'apicdn' : 'api'}.sanity.io',
      path: '/v1/data/query/$dataset',
      queryParameters: queryParameters,
    );
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        final Map<String, dynamic> responseJson = jsonDecode(response.body);
        return responseJson['result'];
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with server with status code: ${response.statusCode}');
    }
  }

  Future<dynamic> fetch(
      {required String query, Map<String, dynamic>? params}) async {
    final Uri uri = _buildUri(query: query, params: params);
    final http.Response response = await _client.get(uri);
    return _returnResponse(response);
  }
}

class AppException implements Exception {
  AppException([
    this._message,
    this._prefix,
  ]);

  final String? _message;
  final String? _prefix;

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Error During Communication: ');
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid Request: ');
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message]) : super(message, 'Unauthorized: ');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input: ');
}