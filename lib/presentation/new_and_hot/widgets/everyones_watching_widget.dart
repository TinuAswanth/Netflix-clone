import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/presentation/home/widgets/custom_button_widget.dart';
import 'package:netflix_clone/presentation/widgets/video_widget.dart';

class EveryOnesWatchingWidget extends StatelessWidget {
  final String posterPath;
  final String movieName;
  final String description;
  const EveryOnesWatchingWidget({
    Key? key,
    required this.posterPath,
    required this.movieName,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kHeight10,
         VideoWidget(image: posterPath,),
        kHeight20,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            CustomButtonWidget(
              icon: Icons.share,
              iconSize: 16,
              title: 'Share',
              textSize: 13,
            ),
            kWidth10,
            CustomButtonWidget(
              icon: Icons.add,
              iconSize: 16,
              title: 'My List',
              textSize: 13,
            ),
            kWidth10,
            CustomButtonWidget(
              icon: Icons.play_arrow,
              iconSize: 16,
              title: 'Play',
              textSize: 13,
            ),
            kWidth10,
          ],
        ),
        Row(
          children: [
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvqzzaddvtgMnkygige0xD04ts4LMBbBLcPQ&usqp=CAU',
              width: 20,
              height: 30,
            ),
            const Text(
              'SERIES',
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
         Text(
          movieName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        kHeight10,
         Text(
         description,
         maxLines: 4,
         overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: kGreyColor,
          ),
        ),
        kHeight50,
      ],
    );
  }
}
