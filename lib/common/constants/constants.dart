import 'package:flutter/material.dart';
import 'package:lite_jobs/utils/colors/colors.dart';

final BoxDecoration initialPageButtonBackground = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.black.withAlpha(200),
      Colors.deepPurple[500]!,
      Colors.deepPurple[200]!,
      // Colors.pinkAccent[100]!
    ],
  ),
);

const Color screenBackgroundColor = Color(0xFFD8EAFF);
const BoxDecoration scaffoldBoxDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFD8EAFF), Color(0xFFD8EAFF)],
  ),
);

class AppPallete {
  static const Color backgroundColor = Color.fromRGBO(24, 24, 32, 1);
  static const Color gradient1 = Color.fromRGBO(187, 63, 221, 1);
  static const Color gradient2 = Color.fromRGBO(251, 109, 169, 1);
  static const Color gradient3 = Color.fromRGBO(255, 159, 124, 1);
  static const Color borderColor = Color.fromRGBO(52, 51, 67, 1);
  static const Color whiteColor = Colors.white;
  static const Color greyColor = Colors.grey;
  static const Color errorColor = Colors.redAccent;
  static const Color transparentColor = Colors.transparent;
}

class AppTheme {
  static authBorder([Color color = AppPallete.borderColor]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
      );

  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: authBorder(),
      focusedBorder: authBorder(AppPallete.gradient2),
    ),
  );
}

enum IconType { email, password, phone, name, address }

Icon getIconForType(IconType type) {
  switch (type) {
    case IconType.address:
      return Icon(
        Icons.maps_home_work_outlined,
        color: Colors.grey[500],
        size: 21,
      );
    case IconType.name:
      return Icon(
        Icons.person,
        color: Colors.grey[500],
        size: 21,
      );
    case IconType.email:
      return Icon(
        Icons.mail_outline_rounded,
        color: Colors.grey[500],
        size: 21,
      );
    case IconType.password:
      return Icon(
        Icons.lock_rounded,
        color: Colors.grey[500],
        size: 21,
      );
    case IconType.phone:
      return const Icon(Icons.phone);
    default:
      return const Icon(Icons.error);
  }
}

String? validateInput(String? inputval, IconType iconType) {
  if (inputval == null || inputval.isEmpty) {
    return 'Fill all fields';
  }

  if (iconType == IconType.email) {
    if (!inputval.contains('@gmail.com')) {
      return 'Please enter a valid email address';
    }
  } else if (iconType == IconType.password) {
    if (inputval.length < 6) {
      return "Password must be at least 6 characters long";
    }
  } else if (iconType == IconType.name) {
    if (inputval.length < 3) {
      return "Username must be at least 3 characters long";
    }
  } else if (iconType == IconType.phone) {
    if (inputval.length < 10 || inputval.length > 10) {
      return "mobile number should be 10 numbers";
    }
  }

  return null;
}

submitForm(GlobalKey<FormState> formKey) {
  if (formKey.currentState!.validate() == true) {
    // Form is valid, continue with form submission or other actions
    return true;
  } else {
    return false;
  }
}

OutlineInputBorder authFieldOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(
    color: primaryColor,
    width: 4,
  ),
);

OutlineInputBorder authFieldErrorOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: BorderSide(
    color: errorColor,
    width: 4,
  ),
);
