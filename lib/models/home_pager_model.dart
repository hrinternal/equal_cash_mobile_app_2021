class HomePagerModel {
  final String image;
  final String description;

  HomePagerModel(this.image, this.description);
}

List<HomePagerModel> pagers = [
  HomePagerModel("assets/images/hpageimg.png",
      "Send money in minutes without documentation"),
  HomePagerModel("assets/images/hpageimg1.png",
      "Transfer money beyond borders with no limit"),
  HomePagerModel(
      "assets/images/hpageimg2.png", "Low fees, favorable exchange rate"),
];
