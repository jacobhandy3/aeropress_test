import 'package:flutter/material.dart';
import 'countdown.dart';
import 'recipe.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        brightness: Brightness.dark
      ),
      home: MyHomePage(title: 'AeroPress TIMER'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CoffeeRecipe classic = makeClassicRecipe();
  final CoffeeRecipe charger = makeChargerRecipe();
  final CoffeeRecipe inverted = makeInvertedRecipe();
    
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Container(
      child: ListView(
        children: <Widget>[
          Card(
          child: ListTile(
            leading: Icon(Icons.album),
            title: Text(classic.name),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => RecipePage(recipe: classic,i: classic.steps.length)));},
          ),),
          Card(
          child: ListTile(
            leading: Icon(Icons.lightbulb_outline),
            title: Text(charger.name),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => RecipePage(recipe: charger,i: charger.steps.length)));},
          ),),
          Card(
            child: ListTile(
            leading: Icon(Icons.backspace),
            title: Text(inverted.name),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => RecipePage(recipe: inverted,i:inverted.steps.length)));},
          ),)
        ],
      ))
    );

  }
}

class RecipePage extends StatefulWidget {
  RecipePage({this.recipe, this.i});
  final CoffeeRecipe recipe;
  final int i;
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _RecipePageState createState() => _RecipePageState(recipe, i);
}

class _RecipePageState extends State<RecipePage> {
  _RecipePageState(this.r, this.items);
    final CoffeeRecipe r;
    int items;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(r.name),
        centerTitle: true,
      ),
      body: new Container(
        child: new Column(
        children: <Widget>[
        new Text('${r.brew_method}'),
        new Text('${r.coffee_volume_grams}'),
        new Text('${r.grind_size}'),
        new Text('${r.water_volume_grams}'),
        new Text('${r.temperature}'),
        new Text("Steps"),
        Expanded(
          child: SizedBox( height: 200.0,

        child: new ListView.builder(
      itemCount: items,
      itemBuilder: (context, index) {
        return Card(child: ListTile(
          title: Text('${r.steps[index].text}'),
          subtitle: Text('${r.steps[index].subtext}'),
          trailing: Text('${r.steps[index].time.toString()}')
        ));
      })))],)),
    bottomNavigationBar: BottomAppBar(child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new MaterialButton(child: Text('START TIMER'), 
        onPressed: (){Navigator.push(context, 
        MaterialPageRoute(builder: (context) => TimerScreen(r)));}
        )
        ],
      ), color: Colors.pink),
    );
  }
}