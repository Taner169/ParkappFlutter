class AuthService {
  static String? loggedInUser;

  static bool login(String name) {
    // Simulera inloggning
    loggedInUser = name;
    return true;
  }

  static void logout() {
    loggedInUser = null;
  }

  static bool isLoggedIn() => loggedInUser != null;
}
