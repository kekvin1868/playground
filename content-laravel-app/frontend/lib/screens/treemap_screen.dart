import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_treemap/treemap.dart';
import 'package:frontend/models/ms_skill.dart';

class TreemapScreen extends StatelessWidget {
    final List<Skill> skills;

    TreemapScreen({
      required this.skills
    });

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Overall talent skills.')
            ),
            body: 
            SfTreemap(
                dataCount: skills.length,
                weightValueMapper: (int index) {
                    return skills[index].score;
                },
                levels: [
                    TreemapLevel(
                        groupMapper: (int index) {
                            return skills[index].name;
                        },
                        labelBuilder: (BuildContext context, TreemapTile tile) {
                            return Center(
                                child: Text(tile.group),
                            );
                        },
                        color: Colors.blue
                    ),
                ],
            ),
        );
    }
}