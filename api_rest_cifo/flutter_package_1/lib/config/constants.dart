class ApiConfig {
  static const reqresBaseUrl = String.fromEnvironment(
    'REQRES_BASE_URL',
    defaultValue: 'https://reqres.in/api', // <- ha de ser aquesta
  );
}

class ReqresPaths {
  static const users = '/users';
  static const resources = '/resources';
}
