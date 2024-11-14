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
  ].obs;

  RxList playlist = [].obs;

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

  // newRandom({required BuildContext context}) {
  //   List<int> getList(int n, List<int> source) =>
  //       source.sample(n); // to get 5 random non repeating numbers
  //
  //   newList.clear();
  //   playlist.clear();
  //
  //   for (Players player in allPlayers) {
  //     if (player.isPlaying.value) {
  //       newList.add(allPlayers.indexOf(player));
  //     }
  //   }
  //
  //   final outputList = getList(5, newList); // 5 random non repeating numbers
  //   print(outputList);
  //
  //   for (int index in outputList) {
  //     playlist.add(allPlayers[index].name);
  //   }
  // }
  //
  // Randomgenrator({required BuildContext context}) {
  //   int playingCount = 0;
  //   for (var player in allPlayers) {
  //     if (player.isPlaying.value) {
  //       playingCount++;
  //     }
  //   }
  //
  //   if (playingCount >= 6) {
  //     final random = Random();
  //     playlist.clear();
  //     final selectedIndices = <int>[];
  //
  //     while (selectedIndices.length < 5) {
  //       final randomIndex = random.nextInt(allPlayers.length);
  //       if (!selectedIndices.contains(randomIndex) &&
  //           allPlayers[randomIndex].isPlaying.value) {
  //         selectedIndices.add(randomIndex);
  //       }
  //     }
  //
  //     for (int index in selectedIndices) {
  //       playlist.add(allPlayers[index].name);
  //     }
  //
  //     // Now you can be sure that  playlist has exactly 5 players
  //     print(playlist);
  //   } else {
  //     // Handle the case where fewer than 5 players are playing
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Select at least 6 players'),
  //       ),
  //     );
  //   }
  // }
}

class Players {
  final String name;
  final RxBool isPlaying;

  Players({required this.name, required this.isPlaying});
}
