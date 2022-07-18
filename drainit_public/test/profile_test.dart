import 'package:drainit_flutter/app/modules/profile/providers/profile_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'get profile data with bearer should success',
    () async {
      final profile = await ProfileProvider().geProfile(
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjQyMDQwNTgzLWE3NDMtNDVhNi05ZDg2LTI5MWZhMmI5MGQwZSIsImVtYWlsIjoicmluYUBnbWFpbC5jb20iLCJyb2xlIjoiTWFzeWFyYWthdCIsImV4cCI6MTY1ODE1ODUyMn0.yvQPGN2F0Yp6KXR8tNfwL45kmGYbNzyZv34KAXVdmfM",
      );
      expect(profile?.data?.email, "rina@gmail.com");
    },
  );
  test(
    'get profile data without bearer should unsuccessful',
    () async {
      try {
        final profile = await ProfileProvider().geProfile("");
        expect(profile, greaterThan(0));
      } catch (e) {
        expect(e.toString(), "400");
      }
    },
  );

  //create test for edit profile
  test("edit profile test with valid data should success", () async {
    //final editProfile = EditProfileProvider();
    final editData = {
      "email": "[USER_EMAIL]",
      "password": "[PASSWORD_USER]",
      "password_confirmation": "[PASSWORD_USER]",
      "nama": "[nama_user]",
      "no_hp": "[no_hp]",
      "foto": "[foto_user]",
      "alamat": "[alamat_user]",
    };
    //final response = await editProfile.editProfile(editData);
    // expect(response.statusCode, 200);
  });
  test("edit profile test with null data should unsuccess", () async {
    // final editProfile = EditProfileProvider();
    final editData = {
      "email": "[USER_EMAIL]",
      "password": "[PASSWORD_USER]",
      "password_confirmation": "[PASSWORD_USER]",
      "nama": "[nama_user]",
      "no_hp": "[no_hp]",
      "foto": "[foto_user]",
      "alamat": "[alamat_user]",
    };
    // final response = await editProfile.editProfile(editData);
    //expect(response.statusCode, 200);
  });
}
