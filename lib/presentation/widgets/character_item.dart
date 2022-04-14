import 'package:flutter/material.dart';
import 'package:flutter_breaking_bad/data/models/character.dart';
import 'package:flutter_breaking_bad/shared/values/colors.dart';
import 'package:flutter_breaking_bad/shared/values/strings.dart';
import 'package:lottie/lottie.dart';

class CharacterItem extends StatelessWidget {

  final Character character;

  CharacterItem(this.character);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
      padding: const EdgeInsetsDirectional.all(4.0),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          charactersDetailsScreen,
          arguments: character,
        ),
        child: GridTile(
          child: Hero(
            tag: character.charId,
            child: Container(
              color: MyColors.grey,
              child: character.image.isNotEmpty ?
              FadeInImage.assetNetwork(
                width: double.infinity,
                height: double.infinity, //loading_dots_lottie.json //'assets/images/loading_dots.gif'
                placeholder: 'assets/images/loading_dots.gif',
                image: character.image,
                fit: BoxFit.cover,
              ) :
                Image.asset(
                  'assets/images/placeholder_image.jpg',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0
            ),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              character.name,
              style: const TextStyle(
                height: 1.3,
                fontSize: 16.0,
                color: MyColors.white,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
