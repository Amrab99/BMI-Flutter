import 'package:bmi/result.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isMale = true;
  double height = 170;
  double weight = 50;
  int age = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Body Mass Index'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    m1Expanded(context, 'male'),
                    const SizedBox(
                      width: 15,
                    ),
                    m1Expanded(context, 'female'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueGrey,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Height',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              height.toStringAsFixed(1),
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            Text(
                              'cm',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        Slider(
                            min: 50,
                            max: 200,
                            value: height,
                            onChanged: (val) => setState(() => height = val))
                      ]),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    m2Expanded(context, 'weight'),
                    const SizedBox(
                      width: 15,
                    ),
                    m2Expanded(context, 'age'),
                  ],
                ),
              ),
            ),
            Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 16,
                color: Colors.teal,
                child: TextButton(
                    onPressed: () {
                      var result = weight / pow((height / 100), 2);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Result(
                          result: result,
                          isMale: isMale,
                          age: age,
                        );
                      }));
                    },
                    child: Text(
                      'Calculate',
                      style: Theme.of(context).textTheme.headline2,
                    )))
          ],
        ),
      ),
    );
  }

  Expanded m1Expanded(BuildContext context, String gender) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isMale = gender == 'male' ? true : false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:
                (isMale && gender == 'male') || (!isMale && gender == 'female')
                    ? Colors.teal
                    : Colors.blueGrey,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                gender == 'male' ? Icons.male : Icons.female,
                size: 90,
              ),
              const SizedBox(height: 15),
              Text(
                gender == 'male' ? 'Male' : 'Female',
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded m2Expanded(BuildContext context, String type) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              type == 'weight' ? 'Weight' : 'Age',
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 15),
            Text(
              type == 'weight' ? '$weight' : '$age',
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: type == 'age' ? 'age--' : 'weight--',
                  onPressed: () {
                    setState(() {
                      type == 'age' ? age-- : weight--;
                    });
                  },
                  mini: true,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(
                  width: 15,
                ),
                FloatingActionButton(
                  heroTag: type == 'age' ? 'age++' : 'weight++',
                  onPressed: () {
                    setState(() {
                      type == 'age' ? age++ : weight++;
                    });
                  },
                  mini: true,
                  child: const Icon(Icons.add),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
