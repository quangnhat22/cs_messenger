import 'package:app/components/main/text/app_text_base_builder.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class TextThemeWidget extends StatelessWidget {
  const TextThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Display large ${R.strings.language}',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        AppTextDisplayLargeWidget()
            .setText('Display large ${R.strings.language}')
            .build(context),
        Text(
          'Display medium',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        Text(
          'Display small',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Body large',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          'Body medium',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          'Body small',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
