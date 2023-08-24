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
        useMaterial3: true,
      ),
      home: const ParentingAnimations(title: 'Flutter Demo Home Page'),
    );
  }
}

class ParentingAnimations extends StatefulWidget {
  const ParentingAnimations({super.key, required this.title});

  final String title;

  @override
  State<ParentingAnimations> createState() => _ParentingAnimationsState();
}

class _ParentingAnimationsState extends State<ParentingAnimations>
    with TickerProviderStateMixin {
  Animation animation = const AlwaysStoppedAnimation(0.0);

  Animation childAnimation = const AlwaysStoppedAnimation(0.0);

  late AnimationController animationController;
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    animation = Tween(begin: -0.25, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ));

    childAnimation = Tween(begin: 0.0, end: 125.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();

    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget? child) {
          return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: Align(
                alignment: Alignment.center,
                child: Transform(
                  transform: Matrix4.translationValues(
                      animation.value * width, 0.0, 0.0),
                  child: Container(
                    child: Center(
                      child: AnimatedBuilder(
                          animation: childAnimation,
                          builder: (BuildContext context, Widget? child) {
                            print("childAnimation.value");
                            print(childAnimation.value);
                            return Center(
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                height: childAnimation.value * 2,
                                width: childAnimation.value * 2,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Login',
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    const TextField(
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Username',
                                      ),
                                      strutStyle: StrutStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    const TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Password',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        print("Login");
                                      },
                                      child: const Text('Login'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ));
        });
  }
}

class DelayedAnimation extends StatefulWidget {
  const DelayedAnimation({super.key, required this.title});

  final String title;

  @override
  State<DelayedAnimation> createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with TickerProviderStateMixin {
  Animation animation = const AlwaysStoppedAnimation(0.0);

  Animation delayAnimated = const AlwaysStoppedAnimation(0.0);

  Animation muchDelayAnimated = const AlwaysStoppedAnimation(0.0);

  late AnimationController animationController;
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ));

    delayAnimated = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      //a animação vai começar após 50% dos x segundos de duração
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    ));

    muchDelayAnimated = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      //a animação vai começar após 80% dos x segundos de duração
      curve: const Interval(0.8, 1.0, curve: Curves.fastOutSlowIn),
    ));

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget? child) {
          return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: Align(
                alignment: Alignment.center,
                child: Container(
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Transform(
                          transform: Matrix4.translationValues(
                              animation.value * width, 0.0, 0.0),
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              delayAnimated.value * width, 0.0, 0.0),
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Username',
                                    ),
                                  ),
                                  TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Password',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              muchDelayAnimated.value * width, 0.0, 0.0),
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      print("Login");
                                    },
                                    child: const Text('Login'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}

class GestureAnimation extends StatefulWidget {
  const GestureAnimation({super.key, required this.title});

  final String title;

  @override
  State<GestureAnimation> createState() => _GestureAnimationState();
}

class _GestureAnimationState extends State<GestureAnimation>
    with TickerProviderStateMixin {
  Animation animation = const AlwaysStoppedAnimation(0.0);
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ));

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Center(
          child: GestureDetector(
            onTap: () {
              print("Tap");
            },
            child: Container(
              height: 70.0,
              width: 100.0,
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: const Text("Click Me"),
            ),
          ),
        ));
  }
}

class LoginAnimationProvider extends StatefulWidget {
  const LoginAnimationProvider({super.key, required this.title});

  final String title;

  @override
  State<LoginAnimationProvider> createState() => _LoginAnimationProviderState();
}

class _LoginAnimationProviderState extends State<LoginAnimationProvider>
    with TickerProviderStateMixin {
  Animation animation = const AlwaysStoppedAnimation(0.0);
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ));

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget? child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: Transform(
              transform:
                  Matrix4.translationValues(animation.value * width, 0.0, 0.0),
              child: Center(
                child: Column(
                  children: [
                    const Text("Login"),
                    const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print("Login");
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
