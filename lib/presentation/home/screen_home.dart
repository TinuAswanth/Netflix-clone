import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/home/home_bloc.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/home/widgets/background_card.dart';
import 'package:netflix_clone/presentation/home/widgets/number_title_card.dart';
import 'package:netflix_clone/presentation/widgets/main_title_card.dart';

import '../../core/strings.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(
        const GetHomeScreenData(),
      );
    });
    return Scaffold(
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            final ScrollDirection direction = notification.direction;
            log(direction.toString());
            if (direction == ScrollDirection.forward) {
              scrollNotifier.value = true;
            } else if (direction == ScrollDirection.reverse) {
              scrollNotifier.value = false;
            }
            return true;
          },
          child: Stack(
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  } else if (state.isError) {
                    return const Center(
                      child: Text('Error Occured'),
                    );
                  }
                  // released past year
                  final releasedPastYear = state.pastYearMovieList.map((m) {
                    return m.posterPath == null
                        ? nullImage
                        : '$imageAppendURL${m.posterPath}';
                  }).toList();
                  releasedPastYear.shuffle();
                  // trending
                  final trending = state.trendingList.map((m) {
                    return m.posterPath == null
                        ? nullImage
                        : '$imageAppendURL${m.posterPath}';
                  }).toList();
                  trending.shuffle();
                  // tenseDrama
                  final tenseDrama = state.tenseDaramasList.map((m) {
                    return m.posterPath == null
                        ? nullImage
                        : '$imageAppendURL${m.posterPath}';
                  }).toList();
                  tenseDrama.shuffle();
                  // southIndian
                  final southIndian = state.southIndianMovieList.map((m) {
                    return m.posterPath == null
                        ? nullImage
                        : '$imageAppendURL${m.posterPath}';
                  }).toList();
                  southIndian.shuffle();
                  // top10
                  final top10 = state.pastYearTvList.map((m) {
                    return m.posterPath == null
                        ? nullImage
                        : '$imageAppendURL${m.posterPath}';
                  }).toList().sublist(0,10);
                  
                  return ListView(
                    children: [
                     BackgroundCard(url: trending[0]),
                      MainTitleCard(
                        title: 'Released in the past year',
                        posterList: releasedPastYear,
                      ),
                      MainTitleCard(
                        title: 'Trending Now',
                        posterList: trending,
                      ),
                      NumberTitleCard(
                        posterList: top10,
                      ),
                      MainTitleCard(
                        title: 'Tense Dramas',
                        posterList: tenseDrama,
                      ),
                      MainTitleCard(
                        title: 'South Indian Cinema',
                        posterList: southIndian,
                      ),
                    ],
                  );
                },
              ),
              ValueListenableBuilder(
                  valueListenable: scrollNotifier,
                  builder: (BuildContext context, bool value, Widget? _) {
                    return scrollNotifier.value == true
                        ? AnimatedContainer(
                            duration: const Duration(milliseconds: 1000),
                            width: double.infinity,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.network(
                                      'https://cdn-images-1.medium.com/max/1200/1*ty4NvNrGg4ReETxqU2N3Og.png',
                                      width: 70,
                                      height: 70,
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.cast,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    kWidth10,
                                    Image.network(
                                      avatarImageUrl,
                                      width: 30,
                                      height: 30,
                                    ),
                                    kWidth10,
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Text(
                                      'TV Shows',
                                      style: kHomeTitleText,
                                    ),
                                    Text(
                                      'Movies',
                                      style: kHomeTitleText,
                                    ),
                                    Text(
                                      'Categories',
                                      style: kHomeTitleText,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        : kHeight10;
                  },)
            ],
          ),
        ),
      ),
    );
  }
}
