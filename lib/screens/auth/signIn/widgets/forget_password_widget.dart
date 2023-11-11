import 'package:flutter/material.dart';
import 'package:lite_jobs/utils/utils.dart';

import '../../forget_password_page.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              Utils().navigateMe(
                  context: context, page: const ForgetPasswordPage());
            },
            child: const Text("Forget password")),
        const Icon(
          Icons.info,
          color: Colors.blue,
          size: 15,
        ),
        const SizedBox(
          width: 39,
        )
      ],
    );
  }
}
