import 'dart:convert';
// import 'dart:js';
// import 'dart:js';
//  import 'package:path/path.dart' as Path
import 'package:flutter/material.dart';
import 'package:screen_loader/screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  configScreenLoader(
    loader: const AlertDialog(
      title: Text('Gobal Loader..'),
    ),
    bgBlur: 20.0,
  );
  runApp(const MyApp());
}

class Result {
  final Map data;
  Result({required this.data});
  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      data: json['data'],
    );
  }
}

// Future<Result> getHttp() async {
//   try {
//     var params = {'email': 'aaaaa@aaa.com', 'password': 'AaAaA'};
//     var response = await Dio().post(
//       'http://10.210.33.157:5000/post/login',
//       data: jsonEncode(params),
//       options: Options(headers: {
//         Headers.contentTypeHeader: "application/json",
//       }),
//     );
//     var data = response.data.toString();
//     return Result(data: data);
//     // return data;
//   } catch (e) {
//     return Result(data: "error");
//   }
// }

void nothing() {
  print("nothing");
}

Future<Result> post_data(String url, Map<String, dynamic> params) async {
  try {
    // var params = {'email': email, 'password': password};
    var response = await Dio().post(
      'http://10.210.33.157:5000$url',
      data: jsonEncode(params),
      options: Options(headers: {
        Headers.contentTypeHeader: "application/json",
      }),
    );
    var data = response.data;
    return Result(data: data);
    // return data;
  } catch (e) {
    return Result(data: {"Error": "error, API not reachable!"});
  }
}

// Map<String, dynamic> res_conv(Future<Result> res) {
//   print("inside ressssss");
//   var data;
//   FutureBuilder<Result>(
//     future: res,
//     builder: (context, snapshot) {
//       if (snapshot.hasData) {
//         data = (snapshot.data!.data);
//         print(snapshot.data!.data);
//       } else if (snapshot.hasError) {
//         data = ('${snapshot.error}');
//         print(snapshot.error);
//       }
//       return const CircularProgressIndicator();

//       // By default, show a loading spinner.
//       // return const CircularProgressIndicator();
//     },
//   );
//   print(data);
//   print("inside res");
//   return data;
// }

// Future<Result> Login(String email, String password) async {
//   try {
//     var params = {'email': email, 'password': password};
//     var response = await Dio().post(
//       'http://10.210.33.157:5000/post/login',
//       data: jsonEncode(params),
//       options: Options(headers: {
//         Headers.contentTypeHeader: "application/json",
//       }),
//     );
//     var data = response.data.toString();
//     return Result(data: data);
//     // return data;
//   } catch (e) {
//     return Result(data: "error, API not reachable!");
//   }
// }

// Future<Result> Signup(String email, String name, String password) async {
//   try {
//     var params = {'email': email, 'name': name, 'password': password};
//     var response = await Dio().post(
//       'http://10.210.33.157:5000/post/signup',
//       data: jsonEncode(params),
//       options: Options(headers: {
//         Headers.contentTypeHeader: "application/json",
//       }),
//     );
//     var data = response.data.toString();
//     return Result(data: data);
//     // return data;
//   } catch (e) {
//     return Result(data: "error, API not reachable!");
//   }
// }

// Future<Result> addtohisaab(String email, String date, String expense,
//     String amount, String type) async {
//   try {
//     var params = {
//       'email': email,
//       'date': date,
//       'expense': expense,
//       'amount': amount,
//       'type': type
//     };
//     var response = await Dio().post(
//       'http://10.210.33.157:5000/post/addtohisaab',
//       data: jsonEncode(params),
//       options: Options(headers: {
//         Headers.contentTypeHeader: "application/json",
//       }),
//     );
//     var data = response.data.toString();
//     return Result(data: data);
//     // return data;
//   } catch (e) {
//     return Result(data: "error, API not reachable!");
//   }
// }

// Future<Result> Summary(String email, String month) async {
//   try {
//     var params = {'email': email, 'month': month};
//     var response = await Dio().post(
//       'http://10.210.33.157:5000/post/login',
//       data: jsonEncode(params),
//       options: Options(headers: {
//         Headers.contentTypeHeader: "application/json",
//       }),
//     );
//     var data = response.data.toString();
//     return Result(data: data);
//     // return data;
//   } catch (e) {
//     return Result(data: "error, API not reachable!");
//   }
// }

addValue(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<String> getValue(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString(key);
  return stringValue;
}

Future<bool> isThere(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isthere = await prefs.containsKey(key);
  return isthere.toString() == "true" ? true : false;
}

removeValues(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Remove String
  prefs.remove(key);
}

// test() {
//   final Map<String, dynamic> params = {
//     'email': 'aaaaa@aaa.com',
//     'password': 'AaAaA'
//   };
//   String url = '/post/login';
//   Future<Result> result = post_data(url, params);

//   FutureBuilder<Result>(
//     future: result,
//     builder: (context, snapshot) {
//       if (snapshot.hasData) {
//         return Text(snapshot.data!.data);
//       } else if (snapshot.hasError) {
//         return Text('${snapshot.error}');
//       }

//       // By default, show a loading spinner.
//       return const CircularProgressIndicator();
//     },
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Home',
        logout: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final logout;

  const MyHomePage({super.key, required this.title, required this.logout});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState(logout);
}

var logged_in_icons = [
  Icons.home,
  Icons.person,
  Icons.add_circle,
  Icons.list,
  Icons.logout
];
var logged_in_names = ['Home', 'Profile', 'Add Expense', 'Summary', 'Logout'];
// ignore: non_constant_identifier_names
var logged_in_screens = [
  const MyHomePage(title: 'Home', logout: false),
  const Profile(),
  const AddExpense(),
  const Summarise(),
  const MyHomePage(title: 'Home', logout: true),
];

var not_logged_in_icons = [Icons.home, Icons.login, Icons.person_add_alt];
var not_logged_in_names = ['Home', 'Login', 'Register'];
var not_logged_in_screens = [
  const MyHomePage(title: 'Home', logout: false),
  const SignIn(),
  const Register()
];

class _MyHomePageState extends State<MyHomePage> {
  bool isthere = false;
  String loggedin = 'false';
  bool logout_true = false;
  _MyHomePageState(logout) {
    // print(logout.toString());
    if (logout == true) {
      logout_true = true;
      addValue('loggedIn', 'false');
      addValue('email', 'johndoe@gmail.com');
      addValue('name', 'John Doe');
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Future<Result> result = getHttp();

  // _MyHomePageState(){
  //   FutureBuilder<Result>(
  //   future: result,
  //   builder: (context, snapshot) {
  //     if (snapshot.hasData) {
  //       var data = Text(snapshot.data!.data);
  //     } else if (snapshot.hasError) {
  //       var data = Text('${snapshot.error}');
  //     }

  //     // By default, show a loading spinner.
  //     return const CircularProgressIndicator();
  //   },
  // );
  // }

  String email = '';
  String name = '';
  @override
  Widget build(BuildContext context) {
    getValue('email').then((String value) {
      if (value != null) {
        setState(() {
          email = value;
        });
      }
    });
    getValue('name').then((String value) {
      if (value != null) {
        setState(() {
          name = value;
        });
      }
    });
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // actions: [Text('OoOo')],
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            // FutureBuilder<Result>(
            //   future: result,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return Text(snapshot.data!.data);
            //     } else if (snapshot.hasError) {
            //       return Text('${snapshot.error}');
            //     }

            //     // By default, show a loading spinner.
            // return const CircularProgressIndicator();
            //   },
            // ),
            Text(
              'Welcome to OnlyHisaab',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            // Text(
            //   '',
            //   // '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: nothing,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
          child: Wrap(
        children: [
          ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              children:  [
                DrawerHeader(
                  decoration:const  BoxDecoration(
                    color: Colors.green,
                  ), //BoxDecoration
                  child: UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(color: Colors.green),
                    accountName: Text(
                      name,
                      style: TextStyle(fontSize: 18),
                    ),
                    accountEmail: Text(email),
                    currentAccountPictureSize: Size.square(50),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 165, 255, 137),
                      child: Text(
                        name[0],
                        style: TextStyle(fontSize: 30.0, color: Colors.blue),
                      ), //Text
                    ), //circleAvatar
                  ), //UserAccountDrawerHeader
                ), //DrawerHeader
                // ListTile(
                //   leading: const Icon(Icons.home),
                //   title: const Text(' Home '),
                //   onTap: () {
                //     Navigator.pop(context);
                //     // Navigator.pop(context);
                //     Navigator.of(context).pushReplacement(MaterialPageRoute(
                //         builder: (context) => MyHomePage(
                //               title: widget.title,
                //             )));
                //     // Navigator.pop(context);
                //   },
                // ),
                // ListTile(
                //   leading: const Icon(Icons.person),
                //   title: const Text(' My Profile '),
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                // ),
              ]),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                isThere('loggedIn').then((bool result) {
                  setState(() {
                    isthere = (result);
                  });
                });
                getValue('loggedIn').then((String result) {
                  setState(() {
                    loggedin = (result);
                  });
                });
                if (isthere == true && loggedin == 'true') {
                  if (index == 4) {
                    return ListTile(
                      leading: Icon(logged_in_icons[index]),
                      title: Text(logged_in_names[index]),
                      onTap: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Logging out in 5 seconds!'),
                          ),
                        );
                        Future.delayed(const Duration(seconds: 5), () {
                          Navigator.of(_scaffoldKey.currentContext!)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => const MyHomePage(
                                        title: "Home",
                                        logout: true,
                                      )));
                        });
                        print("adaada");
                      },
                    );
                  } else {
                    return ListTile(
                      leading: Icon(logged_in_icons[index]),
                      title: Text(logged_in_names[index]),
                      onTap: () {
                        // if(index == 4){
                        //   Navigator.pop(context);
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //     content: Text(
                        //         'Logging out in 5 seconds!'),
                        //   ),
                        // );
                        // Future.delayed(const Duration(seconds: 5), () {
                        //   Navigator.of(context)
                        //       .push(MaterialPageRoute(builder: (context) => const SignIn()));
                        // });
                        // }
                        Navigator.pop(context);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => logged_in_screens[index]));
                      },
                    );
                  }
                } else {
                  // print("not isthere");
                  if (index <= not_logged_in_names.length - 1) {
                    return ListTile(
                      leading: Icon(not_logged_in_icons[index]),
                      title: Text(not_logged_in_names[index]),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                not_logged_in_screens[index]));
                      },
                    );
                  }
                  // }
                }
                // });
                return const Text('');
              }),

          // ListView(
          //   scrollDirection: Axis.vertical,
          //   shrinkWrap: true,
          //   padding: const EdgeInsets.all(0),
          //   children: [
          //   LayoutBuilder(builder: (context, constraints) {
          //     if (!(isThere('loggedIn') == 'true')) {
          //       // return Text("Y is greater than or equal to 10");
          //       return ListView(padding: const EdgeInsets.all(0),
          // children: [
          // ListTile(
          //   leading: const Icon(Icons.person),
          //   title: const Text(' My Profile '),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
          //   ListTile(
          //     leading: const Icon(Icons.add_circle),
          //     title: const Text(' Add to Hisaab'),
          //     onTap: () {
          //       Navigator.pop(context);
          //     },
          //   ),
          //   ListTile(
          //     leading: const Icon(Icons.list),
          //     title: const Text(' Summary '),
          //     onTap: () {
          //       Navigator.pop(context);
          //     },
          //   ),
          //   ListTile(
          //     leading: const Icon(Icons.logout),
          //     title: const Text('LogOut'),
          //     onTap: () {
          //       Navigator.pop(context);
          //     },
          //   ),
          //   ]);
          //     } else {
          //       return const Text("Y is less than 10");
          //     }
          //   }),

          // ListTile(
          //   leading: const Icon(Icons.add_circle),
          //   title: const Text(' Add to Hisaab'),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.list),
          //   title: const Text(' Summary '),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),

          // ListTile(
          //   leading: const Icon(Icons.login),
          //   title: const Text(' Login '),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.person_add_alt),
          //   title: const Text(' Signup '),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.logout),
          //   title: const Text('LogOut'),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
        ],
        //   ),
        // ]
      )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Register extends StatefulWidget {
  const Register({
    Key? key,
  }) : super(key: key);
  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  bool isthere = false;
  String loggedin = 'false';
  // final String text;
  // Sign_up();
  // bool isLoading = false;
  // State<Register> createState() => Register();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'name': null,
    'email': null,
    'password': null
  };
  final focusPassword = FocusNode();

  String email = '';
  String name = '';
  @override
  Widget build(BuildContext context) {
    getValue('email').then((String value) {
      if (value != null) {
        setState(() {
          email = value;
        });
      }
    });
    getValue('name').then((String value) {
      if (value != null) {
        setState(() {
          name = value;
        });
      }
    });
   
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('Sign up page')),
      body: Center(
        child: Column(
          children: <Widget>[
            _buildForm(context),
          ],
        ),
      ),
      drawer: Drawer(
          child: Wrap(children: [
        ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            children:  [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ), //BoxDecoration
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.green),
                  accountName: Text(
                    name,
                    style: TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text(email),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 165, 255, 137),
                    child: Text(
                      name[0],
                      style: TextStyle(fontSize: 30.0, color: Colors.blue),
                    ), //Text
                  ), //circleAvatar
                ), //UserAccountDrawerHeader
              ),
            ]),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              isThere('loggedIn').then((bool result) {
                setState(() {
                  isthere = (result);
                });
              });
              getValue('loggedIn').then((String result) {
                setState(() {
                  loggedin = (result);
                });
              });
              if (isthere == true && loggedin == 'true') {
                if (index == 4) {
                  return ListTile(
                    leading: Icon(logged_in_icons[index]),
                    title: Text(logged_in_names[index]),
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Logging out in 5 seconds!'),
                        ),
                      );
                      Future.delayed(const Duration(seconds: 5), () {
                        Navigator.of(_scaffoldKey.currentContext!)
                            .pushReplacement(MaterialPageRoute(
                                builder: (context) => const MyHomePage(
                                      title: "Home",
                                      logout: true,
                                    )));
                      });
                      print("adaada");
                    },
                  );
                } else {
                  return ListTile(
                    leading: Icon(logged_in_icons[index]),
                    title: Text(logged_in_names[index]),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => logged_in_screens[index]));
                    },
                  );
                }
              } else {
                if (index <= not_logged_in_names.length - 1) {
                  return ListTile(
                    leading: Icon(not_logged_in_icons[index]),
                    title: Text(not_logged_in_names[index]),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => not_logged_in_screens[index]));
                    },
                  );
                }
                // }
              }

              return const Text('');
            }),
      ])),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildNameField(context),
            _buildEmailField(context),
            _buildPasswordField(context),
            _buildSubmitButton(context),
          ],
        ));
  }

  Widget _buildNameField(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Name'),
      validator: (String? value) {
        if (value.toString().isEmpty) {
          return 'Name cannot be Empty!';
        }
      },
      onSaved: (String? value) {
        _formData['name'] = value.toString();
      },
      textInputAction: TextInputAction.next,
      // onFieldSubmitted: (v) {
      //   FocusScope.of(context).requestFocus(focusName);
      // },
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Email'),
      // ignore: body_might_complete_normally_nullable
      validator: (String? value) {
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value.toString())) {
          return 'This is not a valid email';
        }
      },
      onSaved: (String? value) {
        _formData['email'] = value;
      },
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(focusPassword);
      },
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Password'),
      validator: (String? value) {
        if (value.toString().isEmpty) {
          return 'Password cannot be Empty!';
        }
      },
      onSaved: (String? value) {
        _formData['password'] = value.toString();
      },
      focusNode: focusPassword,
      onFieldSubmitted: (v) {
        _submitForm(context);
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _submitForm(context);
      },
      child: const Text('Submit'),
    );
  }

  void _submitForm(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: 'Dissmiss',
          textColor: Colors.yellow,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        duration: const Duration(days: 1),
        content: const Text('Loading...'),
      ),
    );
    var data;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      print(_formData['email'] + _formData['password'] + _formData['name']);

      Future res = (post_data('/post/signup', _formData));
      res.then((data) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        var result = Result(data: data.data).data;
        var res_encode = jsonEncode(result);
        var res_decode = jsonDecode(res_encode);

        if (res_decode['user_already_signed_up'].toString() == 'True') {
          print('Already signed up');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'User already exists, redirecting to login screen in 5 seconds!'),
            ),
          );
          Future.delayed(const Duration(seconds: 5), () {
            Navigator.pop(context);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const SignIn()));
          });
        } else if (res_decode['user_new_signup'].toString() == 'True') {
          print('New signup');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Signup Successful!, redirecting to login page in 5 seconds!'),
            ),
          );
          Future.delayed(const Duration(seconds: 5), () {
            Navigator.pop(context);
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const SignIn()));
          });
        }
      });
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }
}

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
  }) : super(key: key);
  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  // final String text;
  // Profile();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isthere = false;
  String loggedin = 'false';
  String email = '';
  String name = '';
  @override
  Widget build(BuildContext context) {
    getValue('email').then((String value) {
      if (value != null) {
        setState(() {
          email = value;
        });
      }
    });
    getValue('name').then((String value) {
      if (value != null) {
        setState(() {
          name = value;
        });
      }
    });
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('My Profile')),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              name,
              style: TextStyle(fontSize: 24.0),
            ),
            Text(
              email,
              style: TextStyle(fontSize: 24.0),
            ),
            const Text(
              "My Profile!",
              style: TextStyle(fontSize: 24.0),
            ),
            
            // ElevatedButton(
            //   child: const Text(
            //     'Profile!',
            //     style: TextStyle(fontSize: 24.0),
            //   ),
            //   onPressed: () {
            //     Navigator.pop(context);
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (context) => const MyHomePage(
            //               title: 'Home',
            //             )));
            //   },
            // ),
          ],
        ),
      ),
      drawer: Drawer(
          child: Wrap(children: [
        ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            children:  [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ), //BoxDecoration
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.green),
                  accountName: Text(
                    name,
                    style: TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text(email),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 165, 255, 137),
                    child: Text(
                      name[0],
                      style: TextStyle(fontSize: 30.0, color: Colors.blue),
                    ), //Text
                  ), //circleAvatar
                ), //UserAccountDrawerHeader
              ),
            ]),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              isThere('loggedIn').then((bool result) {
                setState(() {
                  isthere = (result);
                });
              });
              getValue('loggedIn').then((String result) {
                setState(() {
                  loggedin = (result);
                });
              });
              if (index == 4) {
                return ListTile(
                  leading: Icon(logged_in_icons[index]),
                  title: Text(logged_in_names[index]),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Logging out in 5 seconds!'),
                      ),
                    );
                    Future.delayed(const Duration(seconds: 5), () {
                      Navigator.of(_scaffoldKey.currentContext!)
                          .pushReplacement(MaterialPageRoute(
                              builder: (context) => const MyHomePage(
                                    title: "Home",
                                    logout: true,
                                  )));
                    });
                    print("adaada");
                  },
                );
              } else {
                if (isthere == true && loggedin == 'true') {
                  return ListTile(
                    leading: Icon(logged_in_icons[index]),
                    title: Text(logged_in_names[index]),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => logged_in_screens[index]));
                    },
                  );
                  // }
                } else {
                  // print("OOOOoasdsas");
                  // for (var i = 0; i < not_logged_in_names.length; i++) {
                  if (index <= not_logged_in_names.length - 1) {
                    return ListTile(
                      leading: Icon(not_logged_in_icons[index]),
                      title: Text(not_logged_in_names[index]),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                not_logged_in_screens[index]));
                      },
                    );
                  }
                }
                // }
              }

              return const Text('');
            }),
      ],

      )
      ),
    );
  }
}

class AddExpense extends StatefulWidget {
  const AddExpense({
    Key? key,
  }) : super(key: key);
  @override
  State<AddExpense> createState() => _AddExpense();
}

class _AddExpense extends State<AddExpense> {
  // final String text;
  // Sign_up();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isthere = false;
  String loggedin = 'false';
  String email = '';
  String name = '';
  @override
  Widget build(BuildContext context) {
    getValue('email').then((String value) {
      if (value != null) {
        setState(() {
          email = value;
        });
      }
    });
    getValue('name').then((String value) {
      if (value != null) {
        setState(() {
          name = value;
        });
      }
    });
   
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('Add an Expense')),
      body: Center(
        child: Column(
          children: <Widget>[
            //   Text(
            //   text,
            //   style: TextStyle(fontSize: 24.0),
            // ),
            ElevatedButton(
              child: const Text(
                'Add to Expenses!',
                style: TextStyle(fontSize: 24.0),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                          title: 'Home',
                          logout: false,
                        )));
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
          child: Wrap(children: [
        ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            children:  [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ), //BoxDecoration
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.green),
                  accountName: Text(
                    name,
                    style: TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text(email),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 165, 255, 137),
                    child: Text(
                      name[0],
                      style: TextStyle(fontSize: 30.0, color: Colors.blue),
                    ), //Text
                  ), //circleAvatar
                ), //UserAccountDrawerHeader
              ),
            ]),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              isThere('loggedIn').then((bool result) {
                setState(() {
                  isthere = (result);
                });
              });
              getValue('loggedIn').then((String result) {
                setState(() {
                  loggedin = (result);
                });
              });
              if (index == 4) {
                return ListTile(
                  leading: Icon(logged_in_icons[index]),
                  title: Text(logged_in_names[index]),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Logging out in 5 seconds!'),
                      ),
                    );
                    Future.delayed(const Duration(seconds: 5), () {
                      Navigator.of(_scaffoldKey.currentContext!)
                          .pushReplacement(MaterialPageRoute(
                              builder: (context) => const MyHomePage(
                                    title: "Home",
                                    logout: true,
                                  )));
                    });
                    print("adaada");
                  },
                );
              } else {
                if (isthere == true && loggedin == 'true') {
                  return ListTile(
                    leading: Icon(logged_in_icons[index]),
                    title: Text(logged_in_names[index]),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => logged_in_screens[index]));
                    },
                  );
                  // }
                } else {
                  // print("OOOOoasdsas");
                  // for (var i = 0; i < not_logged_in_names.length; i++) {
                  if (index <= not_logged_in_names.length - 1) {
                    return ListTile(
                      leading: Icon(not_logged_in_icons[index]),
                      title: Text(not_logged_in_names[index]),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                not_logged_in_screens[index]));
                      },
                    );
                  }
                }
                // }
              }

              return const Text('');
            }),
      ])),
    );
  }
}

class Summarise extends StatefulWidget {
  const Summarise({
    Key? key,
  }) : super(key: key);
  @override
  State<Summarise> createState() => _Summarise();
}

class _Summarise extends State<Summarise> {
  // final String text;
  // Sign_up();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isthere = false;
  String loggedin = 'false';
  String email = '';
  String name = '';
  @override
  Widget build(BuildContext context) {
    getValue('email').then((String value) {
      if (value != null) {
        setState(() {
          email = value;
        });
      }
    });
    getValue('name').then((String value) {
      if (value != null) {
        setState(() {
          name = value;
        });
      }
    });
   
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('Summary')),
      body: Center(
        child: Column(
          children: <Widget>[
            //   Text(
            //   text,
            //   style: TextStyle(fontSize: 24.0),
            // ),
            ElevatedButton(
              child: const Text(
                'Show Summary',
                style: TextStyle(fontSize: 24.0),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                          title: 'Home',
                          logout: false,
                        )));
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
          child: Wrap(children: [
        ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            children:  [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ), //BoxDecoration
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.green),
                  accountName: Text(
                    name,
                    style: TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text(email),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 165, 255, 137),
                    child: Text(
                      name[0],
                      style: TextStyle(fontSize: 30.0, color: Colors.blue),
                    ), //Text
                  ), //circleAvatar
                ), //UserAccountDrawerHeader
              ),
            ]),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              isThere('loggedIn').then((bool result) {
                setState(() {
                  isthere = (result);
                });
              });
              getValue('loggedIn').then((String result) {
                setState(() {
                  loggedin = (result);
                });
              });
              if (index == 4) {
                return ListTile(
                  leading: Icon(logged_in_icons[index]),
                  title: Text(logged_in_names[index]),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Logging out in 5 seconds!'),
                      ),
                    );
                    Future.delayed(const Duration(seconds: 5), () {
                      Navigator.of(_scaffoldKey.currentContext!)
                          .pushReplacement(MaterialPageRoute(
                              builder: (context) => const MyHomePage(
                                    title: "Home",
                                    logout: true,
                                  )));
                    });
                    print("adaada");
                  },
                );
              } else {
                if (isthere == true && loggedin == 'true') {
                  return ListTile(
                    leading: Icon(logged_in_icons[index]),
                    title: Text(logged_in_names[index]),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => logged_in_screens[index]));
                    },
                  );
                  // }
                } else {
                  // print("OOOOoasdsas");
                  // for (var i = 0; i < not_logged_in_names.length; i++) {
                  if (index <= not_logged_in_names.length - 1) {
                    return ListTile(
                      leading: Icon(not_logged_in_icons[index]),
                      title: Text(not_logged_in_names[index]),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                not_logged_in_screens[index]));
                      },
                    );
                  }
                }
              }

              return const Text('');
            }),
      ])),
    );
  }
}

class SignIn extends StatefulWidget {
  const SignIn({
    Key? key,
  }) : super(key: key);
  @override
  State<SignIn> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  bool isthere = false;
  String loggedin = 'false';
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {'email': null, 'password': null};
  final focusPassword = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String email = '';
  String name = '';
  @override
  Widget build(BuildContext context) {
    getValue('email').then((String value) {
      if (value != null) {
        setState(() {
          email = value;
        });
      }
    });
    getValue('name').then((String value) {
      if (value != null) {
        setState(() {
          name = value;
        });
      }
    });
   
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('Log in page')),
      body: Center(
        child: Column(
          children: <Widget>[
            _buildForm(context),
          ],
        ),
      ),
      drawer: Drawer(
          child: Wrap(children: [
        ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(0),
            children:  [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ), //BoxDecoration
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.green),
                  accountName: Text(
                    name,
                    style: TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text(email),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 165, 255, 137),
                    child: Text(
                      name[0],
                      style: TextStyle(fontSize: 30.0, color: Colors.blue),
                    ), //Text
                  ), //circleAvatar
                ), //UserAccountDrawerHeader
              ),
            ]),
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              isThere('loggedIn').then((bool result) {
                setState(() {
                  isthere = (result);
                });
              });
              getValue('loggedIn').then((String result) {
                setState(() {
                  loggedin = (result);
                });
              });

              if (isthere == true && loggedin == 'true') {
                if (index == 4) {
                  return ListTile(
                    leading: Icon(logged_in_icons[index]),
                    title: Text(logged_in_names[index]),
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Logging out in 5 seconds!'),
                        ),
                      );
                      Future.delayed(const Duration(seconds: 5), () {
                        Navigator.of(_scaffoldKey.currentContext!)
                            .pushReplacement(MaterialPageRoute(
                                builder: (context) => const MyHomePage(
                                      title: "Home",
                                      logout: true,
                                    )));
                      });
                      print("adaada");
                    },
                  );
                } else {
                  return ListTile(
                    leading: Icon(logged_in_icons[index]),
                    title: Text(logged_in_names[index]),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => logged_in_screens[index]));
                    },
                  );
                }
              } else {
                if (index <= not_logged_in_names.length - 1) {
                  return ListTile(
                    leading: Icon(not_logged_in_icons[index]),
                    title: Text(not_logged_in_names[index]),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => not_logged_in_screens[index]));
                    },
                  );
                }
                // }
              }

              return const Text('');
            }),
      ])),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildEmailField(context),
            _buildPasswordField(context),
            _buildSubmitButton(context),
          ],
        ));
  }

  Widget _buildEmailField(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Email'),
      // ignore: body_might_complete_normally_nullable
      validator: (String? value) {
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value.toString())) {
          return 'This is not a valid email';
        }
      },
      onSaved: (String? value) {
        _formData['email'] = value;
      },
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(context).requestFocus(focusPassword);
      },
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Password'),
      validator: (String? value) {
        if (value.toString().isEmpty) {
          return 'Password cannot be Empty!';
        }
      },
      onSaved: (String? value) {
        _formData['password'] = value.toString();
      },
      focusNode: focusPassword,
      onFieldSubmitted: (v) {
        _submitForm(context);
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _submitForm(context);
      },
      child: const Text('Submit'),
    );
  }

  void _submitForm(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: 'Dissmiss',
          textColor: Colors.yellow,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        duration: const Duration(days: 1),
        content: const Text('Loading...'),
      ),
    );
    var data;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      print(_formData['email'] + _formData['password']);

      Future res = (post_data('/post/login', _formData));
      res.then((data) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        var result = Result(data: data.data).data;
        var res_encode = jsonEncode(result);
        var res_decode = jsonDecode(res_encode);

        if (res_decode['user_signed_up'].toString() == 'False') {
          print('Sign up before!');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  "You haven't signed up yet, redirecting to Sign up screen in 5 seconds!"),
            ),
          );
          Future.delayed(const Duration(seconds: 5), () {
            Navigator.pop(context);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Register()));
          });
        } else if (res_decode['correct_pass'].toString() == 'True') {
          print('Correct Pass!');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Login Successful!, redirecting to home page in 5 seconds!'),
            ),
          );
          addValue('loggedIn', 'true');
          addValue('email', _formData['email'].toString());
          addValue('name', res_decode['name'].toString());
          Future.delayed(const Duration(seconds: 5), () {
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const MyHomePage(
                      title: "Home",
                      logout: false,
                    )));
          });
        } else {
          print('Wrong Pass!');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Wrong Password!'),
            ),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }
}
