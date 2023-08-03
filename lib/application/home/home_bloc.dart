import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/core/failures/main_failure.dart';
import 'package:netflix_clone/domain/hot_&_new/hot_and_new_service.dart';

import '../../domain/hot_&_new/model/hot_and_new_resp.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService _homeService;
  HomeBloc(this._homeService) : super(HomeState.initial()) {
    on<GetHomeScreenData>((event, emit) async {
      // send loading to UI
      emit(state.copyWith(isLoading: true, isError: false));
      // get data
      final movieResult = await _homeService.getHotAndNewMovieData();
      final tvResult = await _homeService.getHotAndNewTvData();
      // transform data
      final _state1=  movieResult.fold(
        (MainFailure f) {
          return  HomeState(
            stateid: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: [],
            pastYearTvList: [],
            tenseDaramasList: [],
            southIndianMovieList: [],
            trendingList: [],
            isLoading: false,
            isError: true,
          );
        },
        (HotAndNewResp resp) {
          final pastYear=resp.results;
          final trending=resp.results;
          final tenseDrama=resp.results;
          final southIndianMovies=resp.results;
          pastYear.shuffle();
          trending.shuffle();
          tenseDrama.shuffle();
          southIndianMovies.shuffle();
           return  HomeState(
            stateid: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: pastYear,
            pastYearTvList: state.pastYearTvList,
            tenseDaramasList: tenseDrama,
            southIndianMovieList:southIndianMovies,
            trendingList: trending,
            isLoading: false,
            isError: false,
          );
        },
      );
      emit(_state1);
      final _state2= tvResult.fold(
        (MainFailure f) {
          return  HomeState(
            stateid: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: [],
            pastYearTvList: [],
            tenseDaramasList: [],
            southIndianMovieList: [],
            trendingList: [],
            isLoading: false,
            isError: true,
          );
        },
        (HotAndNewResp resp) {
          final top10=resp.results;
          return  HomeState(
            stateid: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: state.pastYearMovieList,
            pastYearTvList: top10,
            tenseDaramasList: state.tenseDaramasList,
            southIndianMovieList:state.southIndianMovieList,
            trendingList: state.trendingList,
            isLoading: false,
            isError: false,
          );
        },
      );
      // show to UI
      emit(_state2);
    });
  }
}
