part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required String stateid,
    required List<HotAndNewData> pastYearMovieList,
    required List<HotAndNewData> pastYearTvList,
    required List<HotAndNewData> tenseDaramasList,
    required List<HotAndNewData> southIndianMovieList,
    required List<HotAndNewData> trendingList,
    required bool isLoading,
    required bool isError,
  }) = _Initial;

  factory HomeState.initial() =>const HomeState(
        stateid: '0',
        pastYearMovieList: [],
        pastYearTvList: [],
        tenseDaramasList: [],
        southIndianMovieList: [],
        trendingList: [],
        isLoading: true,
        isError: false,
      );
}
