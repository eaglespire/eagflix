class Movie {
  late int id;
  late String? backdropPath;
  late String? posterPath;
  late String? originalTitle;
  late String? overview;
  late num? voteAverage;
  late String? releaseDate;

  Movie(
      {required this.id,
      required this.backdropPath,
      required this.originalTitle,
      required this.overview,
      required this.posterPath,
      required this.voteAverage,
      required this.releaseDate});
}
