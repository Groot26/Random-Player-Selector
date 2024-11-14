import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CS'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2,
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        Obx(
                          () => ListView.builder(
                            itemCount: controller.allPlayers.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Obx(
                                () => CheckboxListTile(
                                  // tileColor: Colors.red,
                                  title:
                                      Text(controller.allPlayers[index].name),
                                  value: controller
                                      .allPlayers[index].isPlaying.value,
                                  onChanged: (bool? value) {
                                    controller.allPlayers[index].isPlaying
                                        .value = value!;
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: TextField(
                            controller: controller.name,
                            decoration: InputDecoration(
                              hintText: 'Enter Player Name',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  if (controller.name.text.isNotEmpty) {
                                    controller.allPlayers.add(Players(
                                        name: controller.name.text,
                                        isPlaying: true.obs));

                                    controller.name.clear();
                                  }
                                },
                                icon: const Icon(Icons.arrow_forward),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a number';
                              }

                              final number = int.tryParse(value);
                              if (number == null) {
                                return 'Please enter a valid integer';
                              }

                              // Check if the number is less than the number of currently playing players
                              final playingPlayersCount = controller.allPlayers
                                  .where((player) => player.isPlaying.value)
                                  .length;
                              if (number >= playingPlayersCount) {
                                return 'Number must be less than the number of playing players';
                              }

                              return null;
                            },
                            controller: controller.number,
                            decoration: const InputDecoration(
                              hintText: 'Enter number',
                              // suffixIcon: IconButton(
                              //   onPressed: () {
                              //
                              //   },
                              //   icon: const Icon(Icons.arrow_forward),
                              // ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                    ],
                  ),
                ),
              ],
            ),
            MaterialButton(
              onPressed: () => controller.random(context: context),
              color: Colors.yellow.shade900,
              child: const Text(
                'get',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
