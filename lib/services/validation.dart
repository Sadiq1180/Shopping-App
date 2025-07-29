import '../shared/shared.dart';

String? validateEmail(String email) {
  if (email.isEmpty) {
    return "Email is required";
  } else if (!email.isMail) {
    return "Invalid email";
  }
  return null;
}

String? validateNames(String? firstName, String? lastName, String email) {
  if (firstName == null || firstName.isEmpty) {
    return "First name is required";
  } else if (lastName == null || lastName.isEmpty) {
    return "Last name is required";
  } else if (email.isEmpty) {
    return "Email is required";
  } else if (!email.isMail) {
    return "Invalid email";
  }
  return null;
}