import 'package:drainit_flutter/app/modules/register/controllers/register_controller.dart';
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
        final loginButton = find.byKey(const Key("loginButton")).first;

        await tester.pumpAndSettle();
        //enter email
        await tester.enterText(emailFormField, "aziz@gmail.com");
        //enter password
        await tester.enterText(passwirdFormField, "aziz1234");
        await tester.tap(loginButton, warnIfMissed: false);
        //wait for the login button to be enabled
        await tester.pumpAndSettle();
      });

      //test the login page if incorrect
      testWidgets(
        'login incorrect',
        (WidgetTester tester) async {
          app.main();
          try {
            await tester.pumpAndSettle();

            final emailFormField = find.byKey(const Key('emailFormField'));
            final passwirdFormField =
                find.byKey(const Key('passwordFormField'));
            final loginButton = find.byKey(const Key("loginButton"));
            await tester.pumpAndSettle();

            await tester.enterText(emailFormField, "aziz@gmail.com");
            await tester.enterText(passwirdFormField, "1121234");
            await tester.pumpAndSettle();
            await tester.tap(loginButton, warnIfMissed: false);
          } catch (e) {
            //important to wait for the animation to finish
            await tester.runAsync(() async {
              await tester.pumpAndSettle();
              Future.delayed(const Duration(seconds: 5), () {
                expect(find.byKey(const Key("error")), findsOneWidget);
              });
            });
          }
        },
      );
    },
  );
  group(
    'register test',
    () {
      testWidgets('register correct', (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        final registerButton = find.byKey(const Key("register"));
        await tester.tap(registerButton, warnIfMissed: false);
        await tester.pumpAndSettle();
        final nameFormField = find.byKey(RegisterController().nameKey);
        final emailFormField = find.byKey(RegisterController().emailKey);
        final passwordFormField = find.byKey(RegisterController().passwordKey);
        final confirmPasswordFormField =
            find.byKey(RegisterController().confirmPasswordKey);
        final phoneFormField = find.byKey(RegisterController().phoneKey);
        final addressFormField = find.byKey(RegisterController().addressKey);
        final isCheked = find.byKey(RegisterController().isCheckedKey);
        final nextButton = find.byKey(RegisterController().nextKey);

        await tester.pumpAndSettle();
        await tester.enterText(nameFormField, "aziz");
        await tester.enterText(emailFormField, "aziz@gmail.com");
        await tester.enterText(passwordFormField, "aziz1234");
        await tester.enterText(confirmPasswordFormField, "aziz1234");
        await tester.enterText(phoneFormField, "0123456789");
        await tester.enterText(addressFormField, "address");
        await tester.tap(isCheked, warnIfMissed: false);
        await tester.pumpAndSettle();
        await tester.tap(nextButton, warnIfMissed: false);
      });
    },
  );
}
