import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_material_pickers/helpers/show_number_picker.dart';
import 'package:flutter_material_pickers/helpers/show_radio_picker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:injector/injector.dart';
import 'package:just_more_fitness/constants.dart';
import 'package:just_more_fitness/db/DatabaseService.dart';
import 'package:just_more_fitness/db/UserRepo.dart';
import 'package:just_more_fitness/model/UserProfile.dart';
import 'package:just_more_fitness/service/generation/db_generation.dart';
import 'package:just_more_fitness/ui/screens/eat/EatProgram.dart';
import 'package:just_more_fitness/ui/screens/exercise_details/ExerciseDetails.dart';
import 'package:just_more_fitness/ui/screens/home/components/ChooseExercise.dart';
import 'package:just_more_fitness/view_model/HomeScreenViewModel.dart';
import 'package:just_more_fitness/view_model/first_run_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences prefs;

  bool _isAppBarOpen = true;

  bool frameLoading = true;

  _getPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  UserProfile user; // = RAMDB.appInstance.user;

  final HomeScreenViewModel viewModel = Injector.appInstance.get<HomeScreenViewModel>();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      prefs = await SharedPreferences.getInstance();

      user = UserRepo.getUser(prefs);

      setState(() => frameLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return frameLoading
        ? Material(child: Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: AppBar(
              title: Text('511FITNESS'),
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: width * 0.05,
                      right: width * 0.05,
                      bottom: 10,
                    ),
                    color: Colors.grey[800],
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.outlined_flag_rounded,
                              size: 38,
                              color: Colors.greenAccent,
                            ),
                            InkWell(
                              onTap: () {
                                showMaterialRadioPicker(
                                  context: context,
                                  title: "?????????????? ???????? ????????",
                                  confirmText: '??????????????????????',
                                  cancelText: '??????????????????',
                                  items: CONSTANTS.allGoals.map((e) => e).toList(),
                                  selectedValue: user.selectedGoal,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        user.selectedGoal =
                                            CONSTANTS.allGoals.firstWhere((element) => element == value);
                                      },
                                    );
                                  },
                                );
                              },
                              child: Column(
                                children: [
                                  Text(
                                    '?????????????? ????????'.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 23,
                                    ),
                                  ),
                                  Text(
                                    user.selectedGoal,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 21,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () => showMaterialNumberPicker(
                                context: context,
                                title: "?????????????? ?????????????? ????????",
                                maxNumber: 200,
                                minNumber: 40,
                                confirmText: "??????????????????????",
                                cancelText: "??????????????????",
                                selectedNumber: viewModel.weight,
                                onChanged: (value) => setState(() => viewModel.weight = value),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '????????'.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.pink,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '${user.weight}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 35,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.fitness_center_rounded,
                              size: 38,
                              color: Colors.yellowAccent,
                            ),
                            Text(
                              '${user.selectedLevel}',
                              style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 38,
                              ),
                            ),
                          ],
                        ),
                        if (_isAppBarOpen)
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.local_drink_rounded,
                                    size: 44,
                                    color: Colors.lightBlue,
                                  ),
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        LinearProgressIndicator(
                                          value: viewModel.drinkedWater / viewModel.drinkGoal,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
                                          backgroundColor: Color(0x33000000),
                                          minHeight: 33,
                                        ),
                                        Center(
                                          child: Text(
                                            '${(viewModel.drinkedWater).toInt()} / ${(viewModel.drinkGoal).toInt()} ????',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(
                                    Icons.restaurant_rounded,
                                    size: 44,
                                    color: Colors.redAccent,
                                  ),
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        LinearProgressIndicator(
                                          value: viewModel.burnedCalories / viewModel.caloriesGoal,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                                          backgroundColor: Color(0x33000000),
                                          minHeight: 33,
                                        ),
                                        Center(
                                          child: Text(
                                            '${(viewModel.burnedCalories).toInt()} / ${(viewModel.caloriesGoal).toInt()} ????????',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              RawMaterialButton(
                                fillColor: Colors.amber,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EatProgram(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('?????????????????????? ???????????????? ????????????????????'.toUpperCase()),
                                ),
                              ),
                            ],
                          ),
                        InkWell(
                          child: Icon(
                            _isAppBarOpen ? Icons.expand_less : Icons.expand_more,
                            size: 33,
                            color: Colors.white,
                          ),
                          onTap: () {
                            setState(() {
                              _isAppBarOpen = !_isAppBarOpen;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ChooseExercise(
                      exercises: viewModel.exercises,
                      callback: (value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseDetailsScreen(value),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // bottomNavigationBar: HomeBottomNavigationBar(items: []),
            // body: _list[_page],
            floatingActionButton: SpeedDial(
              icon: Icons.add,
              activeIcon: Icons.remove,
              elevation: 2.0,
              children: [
                SpeedDialChild(
                  child: Icon(Icons.local_drink_rounded),
                  label: '???????????? ????????',
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () {
                    _displayDialog(context, '?????????????? ?????????????????? ?????????????? ????????', (value) {
                      setState(() {
                        viewModel.drinkedWater += value;
                      });
                    });
                  },
                ),
                SpeedDialChild(
                  child: Icon(Icons.restaurant_rounded),
                  label: '???????????? ??????????????',
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () {
                    _displayDialog(context, '?????????????? ?????????????????? ??????????????', (value) {
                      setState(() {
                        viewModel.burnedCalories += value;
                      });
                    });
                  },
                ),
              ],
            ),
          );
  }

  _displayDialog(BuildContext context, String title, ValueCallback<double> callback) async {
    TextEditingController _textFieldController = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: _textFieldController,
            textInputAction: TextInputAction.go,
            keyboardType: TextInputType.numberWithOptions(),
            // decoration: InputDecoration(hintText: hint),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('??????????????????'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('??????????????????????'),
              onPressed: () {
                final double value = int.tryParse(_textFieldController.text)?.toDouble() ?? 0;
                callback(value);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
