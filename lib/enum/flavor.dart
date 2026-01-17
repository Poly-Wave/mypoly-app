enum Flavor {
  prod,
  dev;

  static Flavor fromString(String value) {
    switch (value.toLowerCase()) {
      case 'dev':
        return Flavor.dev;
      case 'prod':
      default:
        return Flavor.prod;
    }
  }
}
