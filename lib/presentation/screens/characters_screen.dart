import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking_bad/business_logic/cubit/cubit.dart';
import 'package:flutter_breaking_bad/business_logic/cubit/states.dart';
import 'package:flutter_breaking_bad/data/models/character.dart';
import 'package:flutter_breaking_bad/presentation/widgets/character_item.dart';
import 'package:flutter_breaking_bad/shared/values/colors.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  List<Character> searchCharacters = [];
  bool _isSearching = false;
  var searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharacterCubit>(context).getAllCharacters();
  }

  Widget buildSearchTextField() {
    return TextField(
      controller: searchTextController,
      cursorColor: MyColors.grey,
      style: const TextStyle(
        color: MyColors.grey,
        fontSize: 18.0,
      ),
      decoration: const InputDecoration(
        hintText: 'Find a character',
        hintStyle: TextStyle(
          color: MyColors.grey,
          fontSize: 18.0,
        ),
        border: InputBorder.none,
      ),
      onChanged: (String value) {
        addSearchedCharactersToSearchList(value);
        setState(() {});
      },
    );
  }

  List<Widget> buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            setState(() {
              _isSearching = false;
              Navigator.pop(context);
            });
          },
          icon: const Icon(
            Icons.clear,
            color: MyColors.grey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            _startSearch();
            setState(() {
              _isSearching = true;
            });
          },
          icon: const Icon(
            Icons.search,
            color: MyColors.grey,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: () {
      _clearSearch();
    }));
  }

  void _clearSearch() {
    setState(() {
      searchCharacters.clear();
      searchTextController.clear();
    });
  }

  void addSearchedCharactersToSearchList(String value) {
    searchCharacters = allCharacters
        .where((element) => element.name.toLowerCase().startsWith(value))
        .toList();
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: searchTextController.text.isEmpty
          ? allCharacters.length
          : searchCharacters.length,
      itemBuilder: (BuildContext context, int index) {
        return CharacterItem(searchTextController.text.isEmpty
            ? allCharacters[index]
            : searchCharacters[index]);
      },
    );
  }

  Widget buildLoadedWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.grey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharacterCubit, CharacterStates>(
      builder: (context, state) {
        if (state is CharacterLoadedState) {
          allCharacters = state.characters;
          return buildLoadedWidget();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
        child: CircularProgressIndicator(
      color: MyColors.yellow,
    ));
  }

  Widget buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(
        color: MyColors.grey,
      ),
    );
  }

  Widget buildOfflineWidget(){
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Can\'t connect .. check intenet',
              style: TextStyle(
                fontSize: 20.0,
                color: MyColors.grey
              ),
            ),
            const SizedBox(height: 30.0),
            Image.asset('assets/images/offline.png'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.yellow,
          title: _isSearching ? buildSearchTextField() : buildAppBarTitle(),
          actions: buildAppBarActions(),
        ),
        body: OfflineBuilder(
          connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child
              ) {
                final bool connected = connectivity != ConnectivityResult.none;
                if(connected){
                  return buildBlocWidget();
                }else {
                  return buildOfflineWidget();
                }
              },
          child: showLoadingIndicator(),
        )
    );
  }
}
