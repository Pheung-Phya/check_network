import 'package:check_network/product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckConnectivity extends StatelessWidget {
  CheckConnectivity({super.key});

  final controller = Get.put(ConnectivityController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('check_network'),
      ),
      body: Column(
        children: [
          Obx(() {
            if (!controller.isConnected.value) {
              return Center(
                child: Text(
                  'No internet connection',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.red,
                      ),
                ),
              );
            }

            return ListView(
              shrinkWrap: true,
              children: List.generate(
                controller.connectionStatus.length,
                (index) => Center(
                  child: Text(
                    controller.connectionStatus[index].toString(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}


//  AIzaSyBjT0Um92nHtrnZLeWjLLf9nwjUvyFfMac