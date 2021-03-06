import 'package:flutter/material.dart';
import 'package:just_more_fitness/constants.dart';
import 'package:just_more_fitness/db/DatabaseService.dart';
import 'package:just_more_fitness/model/Exercise.dart';
import 'package:just_more_fitness/model/Goal.dart';
import 'package:just_more_fitness/model/UserProfile.dart';
import 'package:just_more_fitness/routes.dart';
import 'package:just_more_fitness/service/generation/db_generation.dart';
import 'package:just_more_fitness/service/navigation/navigation_service.dart';
import 'package:just_more_fitness/view_model/first_run_view_model.dart';

class HomeScreenViewModel with ChangeNotifier {
  HomeScreenViewModel({
    this.navigationService,
  });

  final NavigationService navigationService;
  final UserProfile user = RAMDB.appInstance.user;

  final List<Exercise> exercises = RAMDB.appInstance.exercises;

  List<String> selectedBodyParts;

  void selectBodyPart(String part) {
    selectedBodyParts.add(part);
    notifyListeners();
  }

  void removeBodyPart(String part) {
    selectedBodyParts.remove(part);
    notifyListeners();
  }

  String get selectedGoal => user.selectedGoal;

  set selectedGoal(String goal) {
    user.selectedGoal = goal;
    notifyListeners();
  }

  int get selectedLevel => user.selectedLevel;

  set selectedLevel(int level) {
    user.selectedLevel = level;
    notifyListeners();
  }

  double get drinkedWater => user.drinkedWater;

  set drinkedWater(double level) {
    user.drinkedWater = level;
    notifyListeners();
  }

  double get burnedCalories => user.burnedCalories;

  set burnedCalories(double level) {
    user.burnedCalories = level;
    notifyListeners();
  }

  int get weight => user.weight;

  set weight(int value) {
    user.weight = value;
    notifyListeners();
  }

  double get caloriesGoal =>
      ((user.age < 40 ? 2000 : 1600) +
          (user.sex == Sex.FEMALE ? 0 : 400) +
          (user.selectedLevel * 100)) *
      (user.selectedGoal == CONSTANTS.allGoals[0] ? 0.85 : 1.0) *
      (user.selectedGoal == CONSTANTS.allGoals[2] ? 1.2 : 1.0) *
      (user.selectedGoal == CONSTANTS.allGoals[3] ? 1.1 : 1.0);

  double get drinkGoal => user.weight * 40.0;

  // ValueCallback<void> nextPageAction;
  ValueCallback<String> snackAction;

  void nextPageAction(
      int currentPage, VoidCallback callback, BuildContext context) {
    RAMDB.appInstance.user = user;
    currentPage == 4
        ? Navigator.pushReplacementNamed(context, HOME_SCREEN)
        : callback();
  }
}
