class Candidate {
  String name;
  String deputy;
  String image;
  int position; // 1-presidential, 2-parliamentary, 3-county
  bool isChecked;

  Candidate({
    this.name,
    this.deputy,
    this.image,
    this.position,
    this.isChecked,
  });
}
