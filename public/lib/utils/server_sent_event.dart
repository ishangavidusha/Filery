import 'dart:async';
import 'package:universal_html/html.dart' as html;
import 'dart:convert';

class ServerSentEvent {

  // Future<dynamic> streamFiles() async {
  //   Stream<Map<String, dynamic>> stream = ServerSentEvent.connect(
  //     uri: Uri.parse('http://localhost:5000/stream'),
  //     closeOnError: true,
  //     withCredentials: false,
  //   ).stream;

  //   stream.listen((event) {
  //     setState(() {
  //       eventText = event.toString();
  //     });
  //   });
  // }

  final html.EventSource eventSource;
  final StreamController<Map<String, dynamic>> streamController;

  ServerSentEvent._internal(this.eventSource, this.streamController);

  factory ServerSentEvent.connect({
    required Uri uri,
    required String type,
    bool withCredentials = false,
    bool closeOnError = true,
  }) {
    final streamController = StreamController<Map<String, dynamic>>();
    final eventSource = html.EventSource(uri.toString(), withCredentials: withCredentials);

    eventSource.addEventListener(type, (html.Event message) {
      streamController.add(json.decode((message as html.MessageEvent).data) as Map<String, dynamic>);
    });

    ///close if the endpoint is not working
    if (closeOnError) {
      eventSource.onError.listen((event) {
        eventSource.close();
        streamController.close();
      });
    }
    return ServerSentEvent._internal(eventSource, streamController);
  }

  Stream<Map<String, dynamic>> get stream => streamController.stream;

  bool isClosed() => this.streamController.isClosed;

  void close() {
    this.eventSource.close();
    this.streamController.close();
  }
}