import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:techeassignment/models/car_model.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});
  final Dio _client = Dio();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Car Master'),
        ),
        body: FutureBuilder(
          future: _client.post(
              'http://182.76.32.122/connectus-dummy/api/v1/GetAllDetails',
              data: {
                'type': 'CAR',
              }),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              final List<CarModel?> cars =
                  (snapshot.data?.data['data'] as List<dynamic>?)
                          ?.map((element) {
                        return CarModel.fromJson(element);
                      }).toList() ??
                      [];
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: cars.length,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CAR_RC_No : ${cars[index]?.rcNumber}'),
                      Text('CAR Name : ${cars[index]?.model}'),
                      Text('CAR Model : ${cars[index]?.model}'),
                      Text('Capacity : ${cars[index]?.capacity}'),
                      const Text('Attachments :'),
                      ...List.generate(
                        cars[index]?.attachments?.length ?? 0,
                        (idx) => Text(
                            '${idx + 1} : ${cars[index]?.attachments?[idx].attachmentType}'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('CAR_RC_No : ${cars[index]?.rcNumber}'),
                                  Text('CAR Name : ${cars[index]?.model}'),
                                ],
                              ),
                            ),
                            Image.network(
                              cars[index]
                                      ?.attachments
                                      ?.first
                                      .attachmentUrl
                                      ?.first
                                      .url ??
                                  '',
                              height: 100,
                              width: 100,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong!'),
              );
            }
            return const Placeholder();
          },
        ),
      ),
    );
  }
}
