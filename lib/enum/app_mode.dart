enum AppMode {
  prod(name: 'prod'),
  dev(name: 'dev');

  final String name;

  const AppMode({required this.name});

  static AppMode fromString(String value) {
    switch (value.toLowerCase()) {
      case 'dev':
        return AppMode.dev;
      case 'prod':
      default:
        return AppMode.prod;
    }
  }
}
