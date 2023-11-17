// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:app/components/main/button/app_button_base_builder.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

import 'stub.dart';

/// Renders a SIGN IN button that calls `handleSignIn` onclick.
Widget buildSignInButton(
    {HandleSignInFn? onPressed, required BuildContext context}) {
  return AppButtonOutlineWidget()
      .setButtonText(R.strings.signInWithGoogle)
      .setPrefixIcon(R.pngs.googleLogo.image(width: 16, height: 16))
      .setTextStyle(TextStyle(color: Theme.of(context).colorScheme.onSurface))
      .setOnPressed(onPressed)
      .build(context);
}
