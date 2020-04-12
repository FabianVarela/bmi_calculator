class Gender {
  Gender(this.name, this.asset);

  String name;
  String asset;

  bool get isOther => name == 'Other';
}
