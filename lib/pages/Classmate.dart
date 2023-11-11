import 'package:flutter/material.dart';
import 'package:studentapp/utils/myColors.dart';
import '../views/ClassmateCard.dart';

class ClassmatePage extends StatefulWidget {
  const ClassmatePage({super.key});

  @override
  State<ClassmatePage> createState() => _ClassmatePageState();
}

class _ClassmatePageState extends State<ClassmatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Classmates",
        ),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SearchBar(
                hintText: "Search",
                trailing: <Widget>[
                  Tooltip(
                    message: 'Change brightness mode',
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 0, mainAxisSpacing: 8),
                itemCount: 50,
                itemBuilder: ((context, index) {
                  return ClassmateCard(name: "Student Name $index");
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
