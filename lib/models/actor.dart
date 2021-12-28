class Actor {
  late int id;
  late String originalName;
  late String profilePath;
  late String knownForDepartment;

  Actor(
      {required this.id,
      required this.knownForDepartment,
      required this.originalName,
      required this.profilePath});
}
