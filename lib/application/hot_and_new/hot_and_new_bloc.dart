import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/core/failures/main_failure.dart';
import 'package:netflix_clone/domain/hot_&_new/hot_and_new_service.dart';

import '../../domain/hot_&_new/model/hot_and_new_resp.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewService _hotAndNewService;
  HotAndNewBloc(this._hotAndNewService) : super(HotAndNewState.initial()) {
    on<LoadDataInComingSoon>((event, emit) async {
      // send loading to UI
      emit(const HotAndNewState(
        comingSoonList: [],
        everyOnesWatchingList: [],
        isLoading: true,
        isError: false,
      ));
      // get data from remote
      final result = await _hotAndNewService.getHotAndNewMovieData();
      // data to state
      final _newState=  result.fold(
        (MainFailure f) {
          return const HotAndNewState(
            comingSoonList: [],
            everyOnesWatchingList: [],
            isLoading: false,
            isError: true,
          );
        },
        (HotAndNewResp resp) {
          return  HotAndNewState(
            comingSoonList: resp.results,
            everyOnesWatchingList: state.everyOnesWatchingList,
            isLoading: false,
            isError: false,
          );
        },
      );
      emit(_newState);
    });

    on<LoadDataInEveryOnesWatching>((event, emit) async {
       // send loading to UI
      emit(const HotAndNewState(
        comingSoonList: [],
        everyOnesWatchingList: [],
        isLoading: true,
        isError: false,
      ));
      // get data from remote
      final result = await _hotAndNewService.getHotAndNewTvData();
      // data to state
      final _newState=  result.fold(
        (MainFailure f) {
          return const HotAndNewState(
            comingSoonList: [],
            everyOnesWatchingList: [],
            isLoading: false,
            isError: true,
          );
        },
        (HotAndNewResp resp) {
          return  HotAndNewState(
            comingSoonList:  state.comingSoonList,
            everyOnesWatchingList:resp.results,
            isLoading: false,
            isError: false,
          );
        },
      );
      emit(_newState);
    });
  }
}
