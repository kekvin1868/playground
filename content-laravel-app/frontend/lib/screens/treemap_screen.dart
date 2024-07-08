import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_treemap/treemap.dart';
import 'package:frontend/models/ms_skill.dart';
import 'package:frontend/services/api_services.dart';
import 'package:frontend/services/auth_services.dart';

class TreemapScreen extends StatefulWidget {
    const TreemapScreen({super.key, required this.title});

    final String title;

    @override
    State<TreemapScreen> createState() => _TreemapScreenState();
}

class _TreemapScreenState extends State<TreemapScreen> {
  late Future<List<Skill>> skillCluster;

  @override
  void initState() {
    super.initState();
    skillCluster = ApiService().fetchSkills();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut(context);
            }
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Skill>>(
          future: skillCluster,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text("No data available");
            } else {
              return SfTreemap(
                dataCount: snapshot.data!.length,
                weightValueMapper: (int index) {
                  return snapshot.data![index].score;
                },
                levels: [
                  TreemapLevel(
                    groupMapper: (int index) {
                      return snapshot.data![index].name;
                    },
                    labelBuilder: (BuildContext context, TreemapTile tile) {
                      return Center(
                        child: Text(tile.group),
                      );
                    },
                    color: Colors.blue
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}