import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

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
    );
  }
}
