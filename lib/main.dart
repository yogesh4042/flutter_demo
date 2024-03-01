// import 'package:flutter/material.dart';
// import 'dart:math';

// void main() {
//   runApp(LudoGame());
// }

// class LudoGame extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Ludo Game'),
//         ),
//         body: Center(
//           child: LudoBoard(),
//         ),
//       ),
//     );
//   }
// }

// class LudoBoard extends StatefulWidget {
//   @override
//   _LudoBoardState createState() => _LudoBoardState();
// }

// class _LudoBoardState extends State<LudoBoard> with SingleTickerProviderStateMixin {
//   final int _numberOfCells = 100;
//   final int _numberOfPlayers = 4;
//   List<int>? _playersPositions;
//   final List<Color> _playerColors = [Colors.red, Colors.green, Colors.blue, Colors.yellow];
//   int _currentPlayer = 0;
//   int _diceValue = 1;
//   bool _isDiceRolling = false;
//   AnimationController? _controller;
//   Animation<double>? _animation;

//   @override
//   void initState() {
//     super.initState();
//     _playersPositions = List<int>.filled(_numberOfPlayers, 0);
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 300),
//     );
//     _animation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _controller!,
//         curve: Curves.easeInOut,
//       ),
//     )
//       ..addListener(() {
//         setState(() {});
//       })
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           setState(() {
//             _diceValue = Random().nextInt(6) + 1;
//             _movePlayer(_currentPlayer, _diceValue);
//             _currentPlayer = (_currentPlayer + 1) % _numberOfPlayers;
//             _isDiceRolling = false;
//           });
//         }
//       });
//   }

//   @override
//   void dispose() {
//     _controller!.dispose();
//     super.dispose();
//   }

//   void _rollDice() {
//     setState(() {
//       _isDiceRolling = true;
//       _controller!.reset();
//       _controller!.forward();
//     });
//   }

//   void _movePlayer(int playerIndex, int steps) {
//     int currentPosition = _playersPositions![playerIndex];
//     int newPosition = (currentPosition + steps) % _numberOfCells;
//     if (_checkCollision(newPosition)) {
//       newPosition = currentPosition;
//     }
//     _playersPositions![playerIndex] = newPosition;
//     // Check for winning condition
//     if (newPosition == _numberOfCells - 1) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Player ${playerIndex + 1} Wins!'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   _resetGame();
//                 },
//                 child: Text('Play Again'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   bool _checkCollision(int newPosition) {
//     for (int i = 0; i < _numberOfPlayers; i++) {
//       if (_playersPositions![i] == newPosition) {
//         return true;
//       }
//     }
//     return false;
//   }

//   void _resetGame() {
//     setState(() {
//       _playersPositions = List<int>.filled(_numberOfPlayers, 0);
//       _currentPlayer = 0;
//       _diceValue = 1;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         GridView.builder(
//           shrinkWrap: true,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 10,
//           ),
//           itemCount: _numberOfCells,
//           itemBuilder: (BuildContext context, int index) {
//             return Container(
//               decoration: BoxDecoration(
//                 border: Border.all(),
//               ),
//               child: Center(
//                 child: _buildPlayerToken(index),
//               ),
//             );
//           },
//         ),
//         SizedBox(height: 20),
//         Text(
//           'Current Player: ${_currentPlayer + 1}',
//           style: TextStyle(fontSize: 20),
//         ),
//         SizedBox(height: 10),
//         AnimatedOpacity(
//           duration: Duration(milliseconds: 300),
//           opacity: _isDiceRolling ? 0.5 : 1,
//           child: Text(
//             'Dice Value: $_diceValue',
//             style: TextStyle(fontSize: 20),
//           ),
//         ),
//         SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: _isDiceRolling ? null : _rollDice,
//           child: Text('Roll Dice'),
//         ),
//       ],
//     );
//   }

//   Widget _buildPlayerToken(int cellIndex) {
//     List<int> playerIndices = [];
//     for (int i = 0; i < _numberOfPlayers; i++) {
//       if (_playersPositions![i] == cellIndex) {
//         playerIndices.add(i);
//       }
//     }

//     return Stack(
//       children: playerIndices.map((index) {
//         return Container(
//           width: 20,
//           height: 20,
//           decoration: BoxDecoration(
//             color: _playerColors[index],
//             shape: BoxShape.circle,
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps Example',
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194), // San Francisco coordinates
    zoom: 12.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Example'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
