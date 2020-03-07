import 'dart:math';
import 'recipe.dart';
import 'package:flutter/material.dart';

class TimerScreen extends StatefulWidget {
  CoffeeRecipe recipe;

  TimerScreen(this.recipe);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> with TickerProviderStateMixin {
  AnimationController animationController;
  int current_step=0;
  int total_steps=0;
  bool finished;

  String get timerString {
    Duration duration =
        animationController.duration * animationController.value;
    return '${(duration.inSeconds)}';
  }

  @override
  void initState() {
    super.initState();

    current_step = 0;
    total_steps =widget.recipe.steps.length;
    finished = false;

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
        animationController.reverse(
        from: animationController.value == 0.0
            ? 1.0
            : animationController.value);
  }

  bool timerFinished(){
    return animationController.value == 0;
  }

  bool onLastStep(){
    return current_step == total_steps - 1;
  }

  bool finishedAllSteps(){
    return timerFinished() && onLastStep();
  }

  void restartTimer(){
    animationController.reverse(
    from: animationController.value == 0.0
        ? 1.0
        : animationController.value);
  }

  @override
  Widget build(BuildContext context) {
    print("redraw");

    return AnimatedBuilder(
                          animation: animationController,
                          builder: (BuildContext context, Widget child) {
                                if(finishedAllSteps()){
                                  return Text("Done");
                                }else{
                                  if(timerFinished() && !onLastStep()){
                                    current_step+=1;
                                    restartTimer();
                                  }
                                    
                                  return CurrentStepScreen(widget.recipe.steps[current_step], timerString);

                                }
                          },
                        );
  }
}

class CurrentStepScreen extends StatelessWidget {
  RecipeStep step;
  String timerString;

  CurrentStepScreen(this.step, this.timerString);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: FractionalOffset.center,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: FractionalOffset.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              step.text,
                            ),
                            Text(
                              timerString,
                              style: Theme.of(context).textTheme.display4,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}