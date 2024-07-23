import 'package:debuggable_http_client/debuggable_http_client.dart';

void main() async {
  final httpClient = DebuggableHttpClient(
    beforeRequest: (type, url, headers) async {
      if (type == RequestType.get) {
        await Future.delayed(Duration(seconds: 1));
      } else if (url.toString() == 'http://blah.com') {
        throw 'Expected error, on blaha.com call';
      }
    },
  );

  // Use it as any http client
  await httpClient.get(Uri());
  await httpClient.post(Uri());
  await httpClient.delete(Uri());
}
