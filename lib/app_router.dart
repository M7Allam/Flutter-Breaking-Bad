import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking_bad/business_logic/cubit/cubit.dart';
import 'package:flutter_breaking_bad/data/models/character.dart';
import 'package:flutter_breaking_bad/data/repository/characters_repository.dart';
import 'package:flutter_breaking_bad/data/web_services/characters_web_services.dart';
import 'package:flutter_breaking_bad/shared/values/strings.dart';
import 'package:flutter_breaking_bad/presentation/screens/characters_details_screen.dart';
import 'package:flutter_breaking_bad/presentation/screens/characters_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharacterCubit characterCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    characterCubit = CharacterCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => characterCubit,
                  child: CharactersScreen(),
                ));
      case charactersDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(builder: (_) => CharactersDetailsScreen(character));
    }
  }
}
