class OnboardingClass {
  final String hint;
  final String coloredHint;
  final String hint2;
  final String image;
  final String details;

  OnboardingClass(
      this.hint, this.coloredHint, this.hint2, this.image, this.details);
}

List<OnboardingClass> onboardingItems = [
  OnboardingClass(
      "The first",
      " P2P ",
      "individual exchange platform",
      "assets/images/onboarding1.png",
      "All we do is provide you a safe and secure platform for exchanging money. You are in total control!"),
  OnboardingClass(
      "Initiate a",
      " request ",
      "in a few minutes",
      "assets/images/onboarding2.png",
      "Simply state the amount your rate, currency and the time frame to create a request"),
  OnboardingClass(
      "The first easiest and cheapest way to send money",
      " across borders",
      "",
      "assets/images/onboarding3.png",
      "Easy to use, stress-free with the lowest rates you can find anywhere!"),
];
