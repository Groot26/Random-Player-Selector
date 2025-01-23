import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<Players> allPlayers = [
    Players(name: 'Jroot', isPlaying: true.obs),
    Players(name: 'Negan', isPlaying: true.obs),
    Players(name: 'Gamer', isPlaying: true.obs),
    Players(name: 'Saitama', isPlaying: true.obs),
    Players(name: 'Turbo', isPlaying: true.obs),
    Players(name: 'Shifty', isPlaying: true.obs),
    Players(name: 'Hello', isPlaying: true.obs),
    Players(name: 'Venom', isPlaying: true.obs),
  ].obs;

  RxList playlist = [].obs;

  RxList steamIds = ['76561199817934976', '76561199817934976'].obs;

  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController(text: '5');
  final formKey = GlobalKey<FormState>();

  // List<int> newList = [];

  void random({required BuildContext context}) {
    if (formKey.currentState!.validate()) {
      final playingPlayers =
          allPlayers.where((player) => player.isPlaying.value).toList();
      playlist.value = playingPlayers
          .sample(int.tryParse(number.text) ?? 0)
          .map((player) => player.name)
          .toList();
    }
  }
}

class Players {
  final String name;
  final RxBool isPlaying;

  Players({required this.name, required this.isPlaying});
}
