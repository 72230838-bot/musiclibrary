import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:music_library/main.dart';

void main() {
  testWidgets('App shows Music Library title', (WidgetTester tester) async {
    await tester.pumpWidget(const MusicApp());
    expect(find.text('Music Library'), findsOneWidget);
  });
}
