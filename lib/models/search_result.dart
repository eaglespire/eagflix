class SearchResult {
  late int id;
  late String? posterPath;
  late String? originalTitle;
  late String? releaseDate;
  late String? backdropPath;
  late String? overview;
  late num? voteAverage;

  SearchResult(
      {required this.id,
      required this.releaseDate,
      required this.posterPath,
      required this.originalTitle,
      required this.voteAverage,
      required this.overview,
      required this.backdropPath});
}
