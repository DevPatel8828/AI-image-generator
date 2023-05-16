import 'package:flutter/material.dart';
import 'package:ai_image_generator/colors.dart';

import 'package:ai_image_generator/api_services.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  var sizes = ["Small", "Medium", "Large"];
  var values = ["256x256", "512x512", "1024x1024"];
  String? dropvalue;
  var textController = TextEditingController();
  String image = '';
  bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(8),
                backgroundColor: btnColor,
              ),
              onPressed: () {},
              child: Text("My Arts"),
            ),
          ),
        ],
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('AI Image Generator',
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 44,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: TextFormField(
                          controller: textController,
                          decoration: InputDecoration(
                              hintText: "eg 'A dog in moon'",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      height: 44,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          icon: Icon(Icons.expand_more, color: btnColor),
                          value: dropvalue,
                          hint: Text("Select Size"),
                          items: List.generate(
                            sizes.length,
                            (index) => DropdownMenuItem(
                              value: values[index],
                              child: Text(
                                sizes[index],
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              dropvalue = value.toString();
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                    width: 300,
                    height: 38,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: btnColor, shape: StadiumBorder()),
                        onPressed: () async {
                          if (textController.text.isNotEmpty &&
                              dropvalue!.isNotEmpty) {
                            setState(() {
                              isLoaded = false;
                            });
                            image = await Api.generateImage(
                                textController.text, dropvalue!);
                            setState(() {
                              isLoaded = true;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Please enter the text and select size"),
                              ),
                            );
                          }
                        },
                        child: Text("Generate")))
              ],
            )),
            Expanded(
              flex: 4,
              child: isLoaded
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          child: Image.network(
                            image,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                icon: const Icon(
                                    Icons.download_for_offline_rounded),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(8),
                                  backgroundColor: btnColor,
                                ),
                                onPressed: () {},
                                label: Text("Download"),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.share),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(8),
                                backgroundColor: btnColor,
                              ),
                              onPressed: () {},
                              label: Text("Share"),
                            ),
                          ],
                        )
                      ],
                    )
                  : Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/loader.gif"),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text(
                            "Waiting for image to be genereted...",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          )
                        ],
                      ),
                    ),
            ),
            Text(
              "Developed by Darshit & his teams",
              style: TextStyle(color: Colors.white, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
