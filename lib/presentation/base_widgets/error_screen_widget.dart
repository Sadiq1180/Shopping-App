import 'package:flutter/material.dart';
import '../../shared/shared.dart';

class ErrorScreenWidget extends StatelessWidget {
  const ErrorScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Oops!',
              style: AppTextstyle.bodyTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: context.theme.textTheme.bodySmall!.color!),
            ),
            Text('Some Error Occured',
                style: AppTextstyle.bodyTextStyle(
                    fontWeight: FontWeight.w300,
                    color: context.theme.textTheme.displaySmall!.color!)),
          ],
        ),
      ),
    );
  }
}
