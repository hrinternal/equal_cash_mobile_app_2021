class HomePagerModel {
  final String image;
  final String description;

  HomePagerModel(this.image, this.description);
}

List<HomePagerModel> pagers = [
  // HomePagerModel("assets/images/hpageimg.png",
  //     "Send money in minutes without documentation"),
  // HomePagerModel("assets/images/hpageimg1.png",
  //     "Transfer money beyond borders with no limit"),
  // HomePagerModel(
  //     "assets/images/hpageimg2.png", "Low fees, favorable exchange rate"),

  HomePagerModel("assets/images/n1.jpeg",
      "Send money in minutes without documentation"),
  HomePagerModel("assets/images/n4.jpeg",
      "Simple to use"),
  HomePagerModel(
      "assets/images/n3.jpeg", "Create Pin"),
  HomePagerModel(
      "assets/images/n6.jpeg", "Enter your Bank details"),
  HomePagerModel(
      "assets/images/n7.jpeg", "Accept an Offer"),
  HomePagerModel(
      "assets/images/n9.jpeg", "Delete Requests"),
  HomePagerModel(
      "assets/images/n8.jpeg", "Edit Profiles"),
  HomePagerModel(
      "assets/images/n10.jpeg", "Check your Profile"),
];
