import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          'Counter Strike 2',
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Players',
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 18,
                              fontFamily: 'Orbitron',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Obx(
                            () => ListView.builder(
                              itemCount: controller.allPlayers.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Obx(
                                  () => CheckboxListTile(
                                    activeColor: Colors.amber,
                                    title: Text(
                                      controller.allPlayers[index].name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Orbitron',
                                      ),
                                    ),
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
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: TextField(
                              cursorColor: Colors.white,
                              controller: controller.name,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Enter Player Name',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Orbitron',
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade700,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    if (controller.name.text.isNotEmpty) {
                                      controller.allPlayers.add(Players(
                                        name: controller.name.text,
                                        isPlaying: true.obs,
                                      ));

                                      controller.name.clear();
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.add_circle,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              cursorColor: Colors.white,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a number';
                                }

                                final number = int.tryParse(value);
                                if (number == null) {
                                  return 'Please enter a valid integer';
                                }

                                final playingPlayersCount = controller
                                    .allPlayers
                                    .where((player) => player.isPlaying.value)
                                    .length;
                                if (number >= playingPlayersCount) {
                                  return 'Number must be less than the number of playing players';
                                }

                                return null;
                              },
                              controller: controller.number,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Enter number',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Orbitron',
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade700,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Playlist',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 18,
                            fontFamily: 'Orbitron',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => controller.playlist.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.playlist.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        controller.playlist[index],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Orbitron',
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const Center(
                                  child: Text(
                                    'No players in playlist',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Orbitron',
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(
                  vertical: 14.0,
                  horizontal: 24.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => controller.random(context: context),
              child: const Text(
                'Randomize',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Orbitron',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
