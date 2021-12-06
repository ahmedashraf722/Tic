import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictac/cubits/cubit/cubit.dart';
import 'package:tictac/cubits/state/state.dart';
import 'package:tictac/game_logic/game_logic.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TicCubit(),
      child: BlocConsumer<TicCubit, TicStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = TicCubit.get(context);
          return MediaQuery.of(context).orientation == Orientation.portrait
              ? Scaffold(
                  backgroundColor: Theme.of(context).primaryColor,
                  body: SafeArea(
                    child: Column(
                      children: [
                        SwitchListTile.adaptive(
                          contentPadding: const EdgeInsets.all(10.0),
                          title: const Text(
                            'Turn (on <--> off)  Two Players',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          value: cubit.isSwitched,
                          onChanged: cubit.switchedPlayers,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'It\'s --> ',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              ' ${cubit.activePlayer}',
                              style: const TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff02d5a4),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(width: 10.0),
                            const Text(
                              ' <-- Turn',
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(height: 100.0),
                        Expanded(
                          child: GridView.count(
                            padding: const EdgeInsets.all(16.0),
                            crossAxisCount: 3,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                            childAspectRatio: 1.0,
                            children: List.generate(
                              9,
                              (index) => InkWell(
                                borderRadius: BorderRadius.circular(10.0),
                                onTap: cubit.gameOver
                                    ? null
                                    : () {
                                        cubit.onTap(index);
                                      },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).shadowColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      Player.playerX.contains(index)
                                          ? 'X'
                                          : Player.playerO.contains(index)
                                              ? 'O'
                                              : '',
                                      style: TextStyle(
                                        fontSize: 50.0,
                                        fontWeight: FontWeight.bold,
                                        color: Player.playerX.contains(index)
                                            ? Colors.blue
                                            : Theme.of(context).splashColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          cubit.result,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 7.0),
                        defaultButton(
                          width: MediaQuery.of(context).size.width / 2,
                          text: 'Repeat the Game',
                          isUpperCase: false,
                          function: cubit.repeatGame,
                        ),
                        const SizedBox(height: 40.0),
                      ],
                    ),
                  ),
                )
              : Scaffold(
                  backgroundColor: Theme.of(context).primaryColor,
                  body: SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                          child: GridView.count(
                            padding: const EdgeInsets.all(25.0),
                            crossAxisCount: 3,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                            childAspectRatio: 1.1,
                            children: List.generate(
                              9,
                              (index) => InkWell(
                                borderRadius: BorderRadius.circular(10.0),
                                onTap: cubit.gameOver
                                    ? null
                                    : () {
                                        cubit.onTap(index);
                                      },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).shadowColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      Player.playerX.contains(index)
                                          ? 'X'
                                          : Player.playerO.contains(index)
                                              ? 'O'
                                              : '',
                                      style: TextStyle(
                                        fontSize: 50.0,
                                        fontWeight: FontWeight.bold,
                                        color: Player.playerX.contains(index)
                                            ? Colors.blue
                                            : Theme.of(context).splashColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SwitchListTile.adaptive(
                                contentPadding: const EdgeInsets.all(10.0),
                                title: const Text(
                                  'Turn (on <--> off)  Two Players',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                value: cubit.isSwitched,
                                onChanged: cubit.switchedPlayers,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'It\'s --> ',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(width: 10.0),
                                  Text(
                                    ' ${cubit.activePlayer}',
                                    style: const TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff02d5a4),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(width: 10.0),
                                  const Text(
                                    ' <-- Turn',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 50.0),
                              Text(
                                cubit.result,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10.0),
                              defaultButton(
                                width: MediaQuery.of(context).size.width / 3,
                                text: 'Repeat the Game',
                                isUpperCase: false,
                                function: cubit.repeatGame,
                              ),
                              const SizedBox(height: 40.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }

  Widget defaultButton({
    double width = double.infinity,
    Color background = Colors.blue,
    double height = 40.0,
    bool isUpperCase = true,
    double radius = 40.0,
    VoidCallback? function,
    required String text,
  }) {
    return Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: function,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.replay,
            ),
            const SizedBox(width: 7.0),
            Text(
              isUpperCase ? text.toUpperCase() : text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );
  }
}
