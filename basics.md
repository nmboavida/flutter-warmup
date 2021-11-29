# Main Function

Flutter will inflate the widget passed to `runApp` into the root widget of the application.

```
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
```

# Stateless Widgets

[Stateless Widgets](https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html) are building blocks for the UI. They do not depend on any internal state or data. They have a `build` method that returns a widget - Flutter will call this method whenever the UI needs to be rendered.

```
class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return a widget here
  }
}
```

# Material App
The MaterialApp is the `root` of your Flutter app. It is required to work with many built-in widgets. It also allows you to configure global routes and themes.

```
MaterialApp(
  theme: ThemeData(),
  routes: myRoutes,
  home: const MyHomePage(),
)
```

# Container
A `Container` is a is the most layout widget. It takes a single child and allows you to control alignment, padding, margin, width, height, and more.

Tip: Use widgets like `SizedBox` and `Padding` instead of a container to make your code more readable.

```
Container(
  margin: EdgeInsets.all(10),
  padding: EdgeInsets.all(10),
  width: 100,
  height: 100,
  decoration: BoxDecoration(
    color: Colors.red,
    border: Border.all(
      color: Colors.black,
      width: 5,
    ),
  ),
  child: Text('Hello World'),
)
```

# Flex Layour
Flex layout allows you to arrange widgets in a `Row` or a `Column`. It’s very similar to CSS flexbox where the parent widget controls the flow of its children. You can control individual children using the `Expanded` and `Flexible` widgets.

```
Col(
    children: [
        Expanded(
            child: Container(
            color: Colors.red,
            height: 100,
            ),
        ),
        Expanded(
            child: Container(
            color: Colors.green,
            height: 100,
            ),
        ),
    ]
)
```

# Stack
A `Stack` is a layout widget that allows you to position widgets on top of each other. The last item in the stack will be on top.

```
Stack(
    children: [
        Container(
            color: Colors.red,
            width: 100,
            height: 100,
        ),
        Icon(Icons.verified)
    ],
)
```

# List View
A `ListView` is a widget that displays a list of children in a scrollable view. You can control the scroll direction, physics, and more.

Create a dynamic list of items using a `ListView.builder`, for example:

```
import 'dart:math';

randomColor() {
  return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
}

/// ...

ListView.builder(
    itemBuilder: (_, index) {
        return Container(
            color: randomColor(),
            width: 500,
            height: 500,
        );
    },
),
```

# Stateful Widgets
Stateful widgets provide widgets with state, which is just data that changes. Use the `setState()` method to update the state of a widget and it will be re-rendered with the latest data.

```
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              count++;
            });
          },
        ),
        body: Center(
          child: Text('$count'),
        ),
      ),
    );
  }
}
```

# Basic Navigation
Use the `Navigator` to push and pop widgets on the [navigation stack](https://docs.flutter.dev/cookbook/navigation/navigation-basics). The `Scaffold` class will automatically handle the back button for you.

```
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Flutter is Fun!'),
      ),
      body: ElevatedButton(
        child: Text('Navigate'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AboutScreen(),
            ),
          );
        },
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('about'),
      ),
    );
  }
}
```

# Stream builders
Special widget that does not have any UI of its own but instead allow you to listen to or unwrap a `Future` or a `Stream`. A `Future` allows you to fetch a one-time async value whilst a `Stream` allows you fetch to fetch multiple async values. With `Future` we can read a single value from firestore, whilst with `Stream` we can read a document and listen to real time updates.

```
class DemoApp extends StatelessWidget {
  const DemoApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: Stream.fromIterable([1,2,3,4]),
      builder: (context, snapshot) {
        var count = snapshot.data;

        // Add UI here

        return Text('$count');
      },
    );
  }
}
```

# State Management
Stateful widgets have the following limitations:
- State is only available in that class (child widgets that also need to use the state will therefore need you to pass it in as an argument or input property)
- Makes it harder to decouple the business logic from the UI

There are 4 main libraries for state management:
- RiverPod
- Provider
- Block
- Cubit


We focus on `Provider`. `Provider` is one of the most popular state management libraries in Flutter. It wraps `InheritedWidget` and provides an easy way to share data between widgets.

1. Define State:
```
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterState extends ChangeNotifier {

  int count = 0;

  updateCount() {
    count++;
    notifyListeners();
  }

}
```

The purpose of the built-in class `ChangeNotifier` is to define any data that changes throughout the lifecycle of the app and provide methods to mutate that data. `notifyListeners()` tells the flutter framework to re-render.


2. Provide State:
```
class CounterApp extends StatelessWidget {
  const CounterApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => CounterState(),
      child: const CountText(),
      
    );
  }
}
```

The widget `ChangeNotifierProvider` will guarantee that all of its children wil have access to the data. The context of `ChangeNotifierProvider` will be an instance of the class created before.

3. Read State:
```
class CountText extends StatelessWidget {
  const CountText({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var state = context.watch<CounterState>();
    var state2 = Provider.of<CounterState>(context);

    return Text('${state.count}');
  }
}
```

The state can then be created withing by using `context.watch<CounterState>()` or `Provider.of<CounterState>(context)`.

