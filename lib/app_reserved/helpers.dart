import 'package:intl/intl.dart';

String getExceptionMessage(String code){
  String errorMessage = code;
  if(code=="account-exists-with-different-credential"){
    errorMessage = "This account exists with different credentials, try signing in with other method";
  } else if(code=="invalid-credential"){
    errorMessage = "Invalid credentials, try Again";
  } else if(code=="user-not-found"){
    errorMessage = "No User found with this email, try Again";
  } else if(code=="wrong-password"){
    errorMessage = "Wrong password for this email, try Again";
  } else if(code=="invalid-verification-code"){
    errorMessage = "Invalid verfication code, try Again";
  } else if(code=="network_error" || code=="network-request-failed"){
    errorMessage = "Check your connection and try again";
  }else if(code=="email-already-in-user"){
    errorMessage = "Already in user account! Try other login method";
  }else if(code=="popup-closed-by-user"){
    errorMessage = "Google Sign in cancelled";
  }
  return errorMessage;
}

String convertNumber(String number){
  return NumberFormat.compact().format(int.tryParse(number) ?? 0);
}