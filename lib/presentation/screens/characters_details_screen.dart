import 'package:flutter/material.dart';
import 'package:flutter_breaking_bad/data/models/character.dart';
import 'package:flutter_breaking_bad/shared/values/colors.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final Character character;

  CharactersDetailsScreen(this.character);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildCharacterInfo('Jobs :  ', character.jobs.join(' / ')),
                      const SizedBox(height: 20.0),
                      buildCharacterInfo('Appeared in :  ', character.categoryTwoSeries),
                      const SizedBox(height: 20.0),
                      buildCharacterInfo('Seasons :  ', character.breakingBadAppearance.join(' / ')),
                      const SizedBox(height: 20.0),
                      buildCharacterInfo('Status :  ', character.status),
                      const SizedBox(height: 20.0),
                      character.betterCallSaulAppearance.isEmpty? Container() :
                      buildCharacterInfo('Better Call Saul Seasons :  ', character.betterCallSaulAppearance.join(' / ')),
                      SizedBox(height: character.betterCallSaulAppearance.isEmpty? 0.0 : 20.0),
                      buildCharacterInfo('Actor/Actress :  ', character.actorName),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      expandedHeight: 600.0,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.grey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.nickname,
          style: const TextStyle(
            color: MyColors.white,
          ),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildCharacterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,

      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
                color: Colors.white38,
                fontSize: 16.0
            ),
          ),
        ]
      ),
    );
  }

  Widget buildDivider(double endIndent){
    return Divider(
      color: MyColors.yellow,
      height: 30.0,
      endIndent: endIndent,
      thickness: 2,
    );
  }
}
