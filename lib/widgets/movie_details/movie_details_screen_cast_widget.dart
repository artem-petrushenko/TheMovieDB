import 'package:flutter/material.dart';

class MovieDetailsScreenCastWidget extends StatelessWidget {
  const MovieDetailsScreenCastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 19.0, bottom: 22.0),
          child: Text('Cast', style: Theme.of(context).textTheme.headline3,),
        ),
        SizedBox(
          height: 123,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    clipBehavior: Clip.hardEdge,
                    child: Image(
                      width: 79,
                      height: 79,
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/actor.jpg'),
                    ),
                  ),
                  SizedBox(
                    width: 79,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Name Name Name Name',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.headline5),
                    ),
                  )
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 19);
            },
          ),
        )
      ],
    );
  }
}
