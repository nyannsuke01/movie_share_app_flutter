// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:_http';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


import 'package:flutter_academy_graduation/main.dart';
import 'package:http/testing.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.cd
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
  test('my first unit test', (){
    var answer = 4;
    expect(answer, 4);
  });

  // test('API test', () async {
  //   Future<http.Response> _mockRequest(http.Request request) async {
  //     if (request.url
  //         .toString()
  //         .startsWith('https://jsonplaceholder.typicode.com/posts/')) {
  //       return http.Response(
  //           File('test/test_resources/random_movie.json').readAsStringSync(),
  //           200,
  //           headers: {
  //             HttpHeaders.contentTypeHeader: 'application/json',
  //           });
  //     }
  //     return http.Response('Error: Unknown endpoint', 404);
  //   }
  //
  //   final apiProvider = ApiProvider(MockClient(_mockRequest));
  //   final user = await apiProvider.getUser();
  //   expect(user.userId, 1);
  //   expect(user.id, 1);
  //   expect(
  //     user.title,
  //     'sunt aut facere repellat provident occaecati excepturi optio reprehenderit',
  //   );
  //   expect(
  //     user.body,
  //     'quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto',
  //   );
  // });
}
