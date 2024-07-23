library debuggable_http_client;

import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

typedef BeforeRequest = Future<void> Function(
    RequestType type, Uri url, Map<String, String>? headers);

enum RequestType {
  delete,
  get,
  head,
  patch,
  post,
  put,
  read,
  readBytes,
  send,
}

class DebuggableHttpClient implements http.Client {
  BeforeRequest? beforeRequest;

  DebuggableHttpClient({this.beforeRequest});

  final _client = http.Client();

  @override
  void close() => _client.close();

  @override
  Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    await beforeRequest?.call(RequestType.delete, url, headers);
    return _client.delete(url,
        body: body, encoding: encoding, headers: headers);
  }

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    await beforeRequest?.call(RequestType.get, url, headers);
    return _client.get(url, headers: headers);
  }

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) async {
    await beforeRequest?.call(RequestType.head, url, headers);
    return _client.head(url, headers: headers);
  }

  @override
  Future<http.Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    await beforeRequest?.call(RequestType.patch, url, headers);
    return _client.patch(url, body: body, encoding: encoding, headers: headers);
  }

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    await beforeRequest?.call(RequestType.post, url, headers);
    return _client.post(url, body: body, encoding: encoding, headers: headers);
  }

  @override
  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    await beforeRequest?.call(RequestType.put, url, headers);
    return _client.put(url, body: body, encoding: encoding, headers: headers);
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) async {
    await beforeRequest?.call(RequestType.read, url, headers);
    return _client.read(url, headers: headers);
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) async {
    await beforeRequest?.call(RequestType.readBytes, url, headers);
    return _client.readBytes(url, headers: headers);
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    await beforeRequest?.call(RequestType.send, request.url, request.headers);
    return _client.send(request);
  }
}
