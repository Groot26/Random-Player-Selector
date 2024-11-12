import 'package:get/get.dart';

class HomeController extends GetxController {
  // RxList allPlayers =
  //     ['Jroot', 'Negan', 'Gamer', 'Saitama', 'Turbo', 'Shifty', 'Hello'].obs;

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
}

class Players {
  final String name;
  final RxBool isPlaying;

  Players({required this.name, required this.isPlaying});
}
