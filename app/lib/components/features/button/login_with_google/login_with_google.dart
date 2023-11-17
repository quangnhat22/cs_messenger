// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

export 'stub.dart'
    if (dart.library.js_util) 'login_with_google_web.dart'
    if (dart.library.io) 'login_with_google_mobile.dart';
