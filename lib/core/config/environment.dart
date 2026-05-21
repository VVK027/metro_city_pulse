enum Env {
  // Configure the base urls/ domains added for prod, dev, & stage environment
  prod(""),
  stage(""),
  dev(""),
  test("");

  const Env(this.restBaseUrl);

  final String restBaseUrl;

  // String verifyReceiptUrl() => this == Env.prod
  //     ? "https://buy.itunes.apple.com/verifyReceipt"
  //     : "https://sandbox.itunes.apple.com/verifyReceipt";

  static Env getEnvFromName(String name) {
    return name == prod.name ? prod :
          name == stage.name ? stage :
          name == dev.name ? dev : test;
  }

  static List<Env> getAllEnv() => [Env.prod, Env.stage, Env.dev, Env.test];

  static Env defaultEnv() => Env.stage;
}
