import 'package:flutter_breaking_bad/data/models/character.dart';

abstract class CharacterStates {  }

class CharacterInitialState extends CharacterStates {}

class CharacterLoadedState extends CharacterStates {

  final List<Character> characters;
  CharacterLoadedState(this.characters);
}

