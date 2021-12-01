import 'dart:io';

import 'package:drainit_flutter/app/components/rounded_button.dart';
import 'package:drainit_flutter/app/modules/login/views/login_view.dart';
import "package:drainit_flutter/main.dart" as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  //initialize the integration test
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'login_test',
    () {
      //test the login page correctly
      testWidgets('login correct', (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        //find email text field
        final emailFormField = find.byKey(const Key('emailFormField'));
        //find password text field
        final passwirdFormField = find.byKey(const Key('passwordFormField'));
        //find login button
        final loginButton = find.byType(RoundedButton).first;

        //enter email
        await tester.enterText(emailFormField, "aziz@gmail.com");
        //enter password
        await tester.enterText(passwirdFormField, "12345678");
        //wait for the login button to be enabled
        await tester.pumpAndSettle();
        //tap on the login button
        await tester.tap(loginButton, warnIfMissed: false);
        await tester.pumpAndSettle();
      });

      //test the login page if incorrect
      testWidgets(
        'login incorrect',
        (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle();

          final emailFormField = find.byKey(const Key('emailFormField'));
          final passwirdFormField = find.byKey(const Key('passwordFormField'));
          final loginButton = find.byType(RoundedButton).first;

          await tester.enterText(emailFormField, "aziz@gmail.com");
          await tester.enterText(passwirdFormField, "1234567");
          await tester.pumpAndSettle();
          await tester.tap(loginButton, warnIfMissed: false);
          //important to wait for the animation to finish
          await tester.runAsync(() async {
            await tester.pumpAndSettle();
            Future.delayed(const Duration(seconds: 5), () {
              expect(find.byKey(const Key("error")), findsOneWidget);
            });
          });
        },
      );
    },
  );
}
