// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(app) =>
      "Bridge the gap with ${app}. Share moments, send messages, and have face-to-face conversations, regardless of where you are.";

  static String m1(email, expireTime) =>
      "Please check your email \"${email}\" to verify your account. Please confirm your email before ${expireTime}., otherwise your account will not be deleted in the future";

  static String m2(app) => "Welcome to ${app}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addNewContact":
            MessageLookupByLibrary.simpleMessage("Add new contact"),
        "back": MessageLookupByLibrary.simpleMessage("Back"),
        "backToWelcome":
            MessageLookupByLibrary.simpleMessage("Back to Welcome"),
        "bridgeTheGap": m0,
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "confirmPasswordNotMatch": MessageLookupByLibrary.simpleMessage(
            "Password confirmation and Password must match."),
        "connectingPeopleAnytimeAnywhere": MessageLookupByLibrary.simpleMessage(
            "Connecting People, Anytime, Anywhere"),
        "createAccountSuccess": MessageLookupByLibrary.simpleMessage(
            "Create account success! Please login to continue."),
        "createNewGroup":
            MessageLookupByLibrary.simpleMessage("Create new group"),
        "dataConflict": MessageLookupByLibrary.simpleMessage(
            "Input data has already existed!"),
        "discoverSeamlessMessaging": MessageLookupByLibrary.simpleMessage(
            "Discover seamless messaging and high-quality video calls. Stay connected with friends and loved ones like never before."),
        "doYouWantToLogOut":
            MessageLookupByLibrary.simpleMessage("Do you want to log out?"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailValidate": MessageLookupByLibrary.simpleMessage(
            "The email address is badly formatted."),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "errorOccurred": MessageLookupByLibrary.simpleMessage(
            "An error occurred, please try again later"),
        "experienceThePower": MessageLookupByLibrary.simpleMessage(
            "Experience the power of instant messaging and crystal-clear video calls. Connect with people across the globe with ease."),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot password"),
        "friends": MessageLookupByLibrary.simpleMessage("Friends"),
        "getConnectWithYourFriends": MessageLookupByLibrary.simpleMessage(
            "Get connect with your friends"),
        "gotIt": MessageLookupByLibrary.simpleMessage("Got it"),
        "groups": MessageLookupByLibrary.simpleMessage("Groups"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "invalidInput": MessageLookupByLibrary.simpleMessage("Invalid Input"),
        "language": MessageLookupByLibrary.simpleMessage("English"),
        "listFriend": MessageLookupByLibrary.simpleMessage("List Friends"),
        "logOut": MessageLookupByLibrary.simpleMessage("Log out"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "noData": MessageLookupByLibrary.simpleMessage("No Data!"),
        "openEmailApp": MessageLookupByLibrary.simpleMessage("Open Email app"),
        "or": MessageLookupByLibrary.simpleMessage("Or"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordValidate": MessageLookupByLibrary.simpleMessage(
            "Password must be at least 8 characters long, and contain at least 1 letter, 1 number, and 1 special character (e.g @,#,\$,...)."),
        "pleaseCheckYourEmail": m1,
        "pleaseCheckYourEmailToRecovery": MessageLookupByLibrary.simpleMessage(
            "Please check your email to recovery your password"),
        "pleaseLoginAgain":
            MessageLookupByLibrary.simpleMessage("Please login again"),
        "recentCall": MessageLookupByLibrary.simpleMessage("Recent calls"),
        "register": MessageLookupByLibrary.simpleMessage("Register"),
        "registerEmailToReceivePasswordReset": MessageLookupByLibrary.simpleMessage(
            "Enter you registered email below to receive password reset instruction"),
        "requestFriend": MessageLookupByLibrary.simpleMessage("Request friend"),
        "requestGroup": MessageLookupByLibrary.simpleMessage("Request Group"),
        "resendEmailAfter":
            MessageLookupByLibrary.simpleMessage("Resend email after"),
        "retry": MessageLookupByLibrary.simpleMessage("Retry"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searchFriend": MessageLookupByLibrary.simpleMessage("Search friend"),
        "sendEmail": MessageLookupByLibrary.simpleMessage("Send email"),
        "sendEmailSuccess":
            MessageLookupByLibrary.simpleMessage("Send email success"),
        "serverError": MessageLookupByLibrary.simpleMessage("Server error"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "signInWithEmail":
            MessageLookupByLibrary.simpleMessage("Sign in with email"),
        "signInWithGoogle":
            MessageLookupByLibrary.simpleMessage("Sign in with Google"),
        "signInYourAccountToSeeYourChatting":
            MessageLookupByLibrary.simpleMessage(
                "Sign in your account to see your chatting"),
        "signUpWithEmail":
            MessageLookupByLibrary.simpleMessage("Sign up with email"),
        "skip": MessageLookupByLibrary.simpleMessage("Skip"),
        "startChattingWithANewAccount": MessageLookupByLibrary.simpleMessage(
            "Start chatting with a new account"),
        "stayCloseNoMatterDistance": MessageLookupByLibrary.simpleMessage(
            "Stay Close, No Matter the Distance"),
        "systemIsCurrentlyErrorPleaseTryAgainLater":
            MessageLookupByLibrary.simpleMessage(
                "System is currently error, please try again later"),
        "verifyYourEmail":
            MessageLookupByLibrary.simpleMessage("Verify your email"),
        "welcome": MessageLookupByLibrary.simpleMessage("Welcome"),
        "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome back!"),
        "welcomeToApp": m2
      };
}
