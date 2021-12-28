class Tv {
  late int id;
  late String? backdropPath;
  late String? posterPath;
  late String? originalName;
  late String? overview;
  late num? voteAverage;
  late String? firstAirDate;

  Tv(
      {required this.id,
      required this.backdropPath,
      required this.originalName,
      required this.overview,
      required this.posterPath,
      required this.voteAverage,
      required this.firstAirDate});
}
