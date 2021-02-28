import 'package:flutter/material.dart';
import 'package:flutter_app/MoneyBox.dart';

class Todo{
  final String title;
  final String description;
  final String images;
  final int prices;
  Todo(this.title, this.description, this.images, this.prices);
}

/*void main() {
  runApp(MyApp());
}*/

void main() {
  runApp(MaterialApp(
    title: 'Passing Data',
    home: TodoScreen(todos: [
      Todo(
          'Wolfsbane',
          'Clipping Wolfsbane Long Sleeve (Black)',
          'https://krm-cdn.s3.amazonaws.com/images/us/6/1/2/61270.jpg',
          35),
      Todo(
          'La mala',
          'Clipping La mala Long Sleeve (Black)',
          'https://merchbar.imgix.net/product/179/7748/16553/PGiswN7O53869.jpg?w=640&h=640&quality=60&auto=compress%252Cformat',
          26),
      Todo(
          'Mosaic',
          'Clipping Mosaic Tee (Black)',
          'https://krm-cdn.s3.amazonaws.com/images/us/6/1/2/61271_400x400.jpg',
          25),
      Todo(
          'Wytchboard',
          'Clipping Wytchboard Tee (Black)',
          'https://krm-cdn.s3.amazonaws.com/images/us/6/1/2/61274_400x400.jpg',
          25),
    ]),
  ));
}

class TodoScreen extends StatelessWidget{
  final List<Todo> todos;
  int AccumulatedPrice = 0;
  TodoScreen({Key key, @required this.todos}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clipping Merchandise'),
      ),
      body: ListView.builder(
        itemCount: todos.length + 1,
        itemBuilder: (context, index) {
          if (index > -1 && index < todos.length) {
            return ListTile(
              title: Text(todos[index].title),
              onTap: () {
                _navigateAndDisplaySelection(context, index);
              },
            );
          } else {
            return ListTile(
              title: Text('Quotation Screen'),
              onTap: () {
                _navigateAndDisplayNextSelection(context);
              },
            );
          }
        },
      ),
    );
}

  _navigateAndDisplaySelection(BuildContext context, index) async {
    AccumulatedPrice = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              DetailScreen(todo: todos[index], totalprice: AccumulatedPrice)),
    );
    Scaffold.of(context).showSnackBar(new SnackBar(
        duration: new Duration(seconds: 2),
        content: new Text("Total Price: $AccumulatedPrice \$")));
  }

  _navigateAndDisplayNextSelection(BuildContext context) async {
    AccumulatedPrice = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => quotationScreen(totalprice: AccumulatedPrice)),
    );
    if (AccumulatedPrice == null) {
      AccumulatedPrice = 0;
    }
    Scaffold.of(context).showSnackBar(new SnackBar(
        duration: new Duration(seconds: 2),
        content: new Text("Thank you for purchase!")));
  }
}

class DetailScreen extends StatelessWidget {
// Declare a field that holds the Todo.
  final Todo todo;
  int totalprice = 0;
// In the constructor, require a Todo.
  DetailScreen({Key key, @required this.todo, this.totalprice})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
// Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Center(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Container(
                    child: new Image.network(todo.images),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Container(
                    child: Text(todo.description),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Container(
                    child: Text("\$ " + todo.prices.toString()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Container(
                    child: Text("Buy " + todo.title + "?"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      totalprice += todo.prices;
                      Navigator.pop(context, totalprice);
                      print(totalprice);
                    },
                    child: Text('Yes'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, totalprice);
                    },
                    child: Text('No'),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class quotationScreen extends StatelessWidget {
  int totalprice = 0;
  quotationScreen({Key key, @required this.totalprice}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotation Screen'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Total Price: '),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("\$" + totalprice.toString()),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    totalprice = 0;
                    Navigator.pop(context, totalprice);
                    print(totalprice);
                  },
                  child: Text('Pay for your Goods'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, totalprice);
                  },
                  child: Text('Not yet, I need to buy more stuff!'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clipping. Merchandise',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Clipping. Merchandise')),
        body: _myListView(context),
      ),
    );
  }
}

class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return _myListView(context);
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: new Center(
        child: RaisedButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondHome()),
            );
          },
          child: Text(
            'Second Page',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}

class SecondHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page',style: TextStyle(fontSize: 30)),
      ),
      body: new Center(
        child: RaisedButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text(
            'Go back',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}

Widget _myListView(BuildContext context) {
  return ListView(
    children: <Widget>[
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/Wolfsbane.jpg'),
        ),
        title: Text('Wolfsbane'),
        subtitle: Text('Price: \$34.99'),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          print('Wolfsbane');
        },
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/Mosaic.jpg'),
        ),
        title: Text('Mosaic'),
        subtitle: Text('Price: \$24.99'),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          print('Mosaic');
        },
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/Wytchboard.jpg'),
        ),
        title: Text('Wytchboard'),
        subtitle: Text('Price: \$24.99'),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          print('Wytchboard');
        },
      ),
      ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/Lamala.jpg'),
        ),
        title: Text('Lamala'),
        subtitle: Text('Price: \$24.99'),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          print('Lamala');
        },
      )
    ],
  );
}

Widget myLayoutWidget() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        MoneyBox('Balance', 100000, Colors.lightBlue, 120),
        SizedBox(height: 10,),

        MoneyBox('Income', 50000, Colors.green, 100),
        SizedBox(height: 10,),

        MoneyBox('Expense', 40000, Colors.red, 100),
        SizedBox(height: 10,),

        MoneyBox('Overdue', 3600, Colors.orange, 100),
        SizedBox(height: 10,)
      ],
    ),
  );
}