// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:tvseries/data/models/series_model.dart';

class SeriesResponse extends Equatable {
  final List<SeriesModel> seriesList;
  const SeriesResponse({required this.seriesList});

  factory SeriesResponse.fromJson(Map<String, dynamic> json) => SeriesResponse(
        seriesList: List<SeriesModel>.from((json['results'] as List)
            .map((e) => SeriesModel.fromJson(e))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(seriesList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [seriesList];
}
