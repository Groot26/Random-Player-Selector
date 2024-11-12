import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cs'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2,
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: controller.allPlayers.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Obx(
                          () => CheckboxListTile(
                            // tileColor: Colors.red,
                            title: Text(controller.allPlayers[index].name),
                            value: controller.allPlayers[index].isPlaying.value,
                            onChanged: (bool? value) {
                              controller.allPlayers[index].isPlaying.value =
                                  value!;
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2,
                child: Column(
                  children: [
                    Obx(
                      () => controller.playlist.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.playlist.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(controller.playlist[index]),
                                );
                                // Text(controller.playlist[index]);
                              },
                            )
                          : const SizedBox(),
                    ),

                    // SizedBox(
                    //   width: 50,
                    //   height: 50,
                    //   child:
                    //   ListView.builder(
                    //     itemCount: controller.playlist.length,
                    //     shrinkWrap: true,
                    //     itemBuilder: (context, index) {
                    //       print(controller.playlist[index - 1]);
                    //       Obx(
                    //         () => Text(
                    //           controller.playlist[index - 1],
                    //           style: TextStyle(color: Colors.black),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
          MaterialButton(
            onPressed: () {
              int count = 0;
              for (var player in controller.allPlayers) {
                if (player.isPlaying.value) {
                  count++;
                }
              }

              if (count >= 6) {
                final random = Random();

                // Ensure playlist is empty before adding new players
                controller.playlist.clear();

                // final selectedIndices = List.generate(
                //     5, (i) => random.nextInt(controller.allPlayers.length));
                //
                //
                // final uniqueIndices =
                //     selectedIndices.toSet().toList(); // Remove duplicates

                final selectedIndices = <int>[];

                while (selectedIndices.length < 5) {
                  final randomIndex =
                      random.nextInt(controller.allPlayers.length);
                  if (!selectedIndices.contains(randomIndex)) {
                    selectedIndices.add(randomIndex);
                  }
                }

                for (int index in selectedIndices) {
                  controller.playlist.add(controller.allPlayers[index].name);
                }

                print(controller.playlist[0]);
                print(controller.playlist[1]);
                print(controller.playlist[2]);
                print(controller.playlist[3]);
                print(controller.playlist[4]);

                print('*********************************');
              } else {
                // const GetSnackBar(
                //   title: 'select 5 Players',
                // );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('select 6 Players'),
                  ),
                );
              }
            },
            color: Colors.yellow.shade900,
            child: const Text(
              'get',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
