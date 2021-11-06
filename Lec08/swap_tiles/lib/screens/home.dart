import 'package:flutter/material.dart';
import 'package:swap_tiles/util/util.dart';
import 'package:swap_tiles/widgets/stateful_colored_tile.dart';
import 'package:swap_tiles/widgets/stateless_colored_tile.dart';

class PositenedTiles extends StatefulWidget {
  PositenedTiles({Key? key}) : super(key: key) {
    info('PositenedTiles StatefulWidget Costructor Called, Key is $key');
  }

  @override
  _PositenedTilesState createState() {
    info('PositenedTiles createState Called');
    return _PositenedTilesState();
  }
}

class _PositenedTilesState extends State<PositenedTiles> {
  late List<Widget> tiles;
  int counter = 0;

  @override
  void initState() {
    info('_PositenedTilesState initState Called');
    info('-------------------------------------');
    // Random random = Random();
    // var clr1 = Color.fromARGB(
    //     255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
    // var clr2 = Color.fromARGB(
    //     255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
    tiles = [
      //StatefulColorTile('A', key: const ValueKey('A')),
      //StatefulColorTile('B', key: const ValueKey('B')),
      StatefulColorTile('A_ST', key: const ValueKey('A_st')),
      StatefulColorTile('B_ST', key: const ValueKey('B_st')),
      //StateLessColorTile(title: 'A', clr: Colors.blue),
      //StateLessColorTile(title: 'B', clr: Colors.deepPurpleAccent),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    info('_PositenedTilesState build called');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Keys Swap Tiles'),
      ),
      body: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: tiles,
      )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.swap_calls_rounded),
        onPressed: swapTiles,
      ),
    );
  }

  void swapTiles() {
    info('-------------------------');
    info('swapTiles Called $counter times');
    counter++;
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}
