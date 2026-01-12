import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

@immutable
class Person {
  final String name;
  final int age;
  final String emoji;

  const Person({required this.name, required this.age, required this.emoji});
}

const people = [
  Person(name: "Alice", age: 30, emoji: "👩‍💻"),
  Person(name: "Bob", age: 25, emoji: "👨‍🎨"),
  Person(name: "Charlie", age: 35, emoji: "👨‍🚀"),
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("People")),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailsPage(person: person),
                ),
              );
            },
            title: Text(person.name),
            subtitle: Text('${person.age} years old'),
            leading: Hero(
              tag: person.name,
              child: Text(person.emoji, style: TextStyle(fontSize: 40)),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          );
        },
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final Person person;

  const DetailsPage({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          flightShuttleBuilder:
              (
                flightContext,
                animation,
                flightDirection,
                fromHeroContext,
                toHeroContext,
              ) {
                switch (flightDirection) {
                  case HeroFlightDirection.push:
                    return Material(
                      color: Colors.transparent,
                      child: ScaleTransition(
                        scale: animation.drive(
                          Tween<double>(
                            begin: 0.0,
                            end: 1.0,
                          ).chain(CurveTween(curve: Curves.fastOutSlowIn)),
                        ),
                        child: toHeroContext.widget,
                      ),
                    );
                  case HeroFlightDirection.pop:
                    return Material(
                      color: Colors.transparent,
                      child: fromHeroContext.widget,
                    );
                }
              },
          tag: person.name,
          child: Text(person.emoji, style: TextStyle(fontSize: 40)),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(person.name, style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text("${person.age} years old", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
