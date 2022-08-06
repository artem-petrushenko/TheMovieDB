import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:themoviedb/icons.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _MovieNameWidget(),
        _StoryLineWidget(),
      ],
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 21, left: 21, right: 21, bottom: 19),
      child: Column(
        children: [
          Text('Spider Man: No Way Home',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    width: 18,
                    height: 18,
                    AppIcons.star,
                    color: const Color.fromRGBO(250, 255, 0, 1),
                  ),
                  const SizedBox(width: 5),
                  const Text('9.5')
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    width: 18,
                    height: 18,
                    AppIcons.clock,
                    color: const Color.fromRGBO(153, 153, 153, 1),
                  ),
                  const SizedBox(width: 11),
                  const Text('2h 29min'),
                ],
              ),
              const Text('Action')
            ],
          )
        ],
      ),
    );
  }
}

class _StoryLineWidget extends StatelessWidget {
  const _StoryLineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 19.0, bottom: 21.0),
            child: Text(
              'Story line',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, bottom: 23.0, right: 4),
            child: Text(
              'Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
