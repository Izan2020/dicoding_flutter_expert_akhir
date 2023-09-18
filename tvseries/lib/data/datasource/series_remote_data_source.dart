// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:core/utils/exception.dart';
import 'package:core/utils/ssl_pinning.dart';
import 'package:tvseries/data/models/series_detail_model.dart';
import 'package:tvseries/data/models/series_model.dart';
import 'package:tvseries/data/models/series_response.dart';

abstract class SeriesRemoteDataSource {
  Future<List<SeriesModel>> getNowPlayingTvs();
  Future<List<SeriesModel>> getPopularTvs();
  Future<List<SeriesModel>> getTopRatedTvs();
  Future<SeriesDetailResponse> getTvDetail(int id);
  Future<List<SeriesModel>> getTvRecommendations(int id);
  Future<List<SeriesModel>> searchTvs(String query);
}

class SeriesRemoteDataSourceImpl extends SeriesRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';
  final SSLCertifiedClient client;
  SeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<SeriesModel>> getNowPlayingTvs() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY'));
    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getPopularTvs() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));
    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getTopRatedTvs() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY'));
    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SeriesDetailResponse> getTvDetail(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));
    if (response.statusCode == 200) {
      return SeriesDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> getTvRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));
    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeriesModel>> searchTvs(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));
    if (response.statusCode == 200) {
      return SeriesResponse.fromJson(json.decode(response.body)).seriesList;
    } else {
      throw ServerException();
    }
  }
}
