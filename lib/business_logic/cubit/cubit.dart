import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking_bad/business_logic/cubit/states.dart';
import 'package:flutter_breaking_bad/data/models/character.dart';
import 'package:flutter_breaking_bad/data/repository/characters_repository.dart';

class CharacterCubit extends Cubit<CharacterStates>{

  final CharactersRepository charactersRepository;
  List<Character> characters = [];

  CharacterCubit(this.charactersRepository) : super(CharacterInitialState());

  List<Character> getAllCharacters(){
    charactersRepository.getAllCharacters().then((value) {
      characters = value;
      print('API @GET(Characters) SUCCESS: ${characters.toString()}');
      emit(CharacterLoadedState(characters));
    }).catchError((error) {
      print('API @GET(Characters) ERROR: ${error.toString()}');
    });

    return characters;
  }


}