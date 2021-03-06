import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/model/best_series/best_series_model.dart';
import '../../../../core/model/latest_update/latest_update_model.dart';
import '../../../../core/model/manga/manga_model.dart';
import '../../../../core/repository/remote/api_repository.dart';
import '../../../../core/util/connectivity_check.dart';
import '../../../../injection_container.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial());

  // Variables
  final apiRepo = sl.get<APIRepository>();
  final connectivity = sl.get<ConnectivityCheck>();

  @override
  Stream<HomeScreenState> mapEventToState(
    HomeScreenEvent event,
  ) async* {
    yield HomeScreenLoading();

    if (event is GetHomeScreenData) yield* getHomeScreeenDataToState(event);
  }

  Stream<HomeScreenState> getHomeScreeenDataToState(
      GetHomeScreenData event) async* {
    try {
      bool isConnected = await connectivity.checkConnectivity();
      if (isConnected == false) yield HomeScreenError();

      final listBestSeries = await apiRepo.getBestSeries();
      final listHotMangaUpdate = await apiRepo.getHotMangaUpdate();
      final listLatestUpdate = await apiRepo.getLatestUpdate(1);

      yield HomeScreenLoaded(
          listBestSeries: listBestSeries,
          listHotMangaUpdate: listHotMangaUpdate,
          listLatestUpdate: listLatestUpdate);
    } on Exception {
      yield HomeScreenError();
    }
  }
}
