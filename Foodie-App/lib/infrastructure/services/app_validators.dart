class AppValidators {
  static bool isValidEmail(String email) => RegExp(
        "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$",
      ).hasMatch(email);

  static bool isValidPassword(String password) => password.length > 5;

  static bool isValidConfirmPassword(String password,String confirmPassword) => password == confirmPassword;

  static bool arePasswordsTheSame(String password, String confirmPassword) =>
      password == confirmPassword;
}
