import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  String s = "s";
 @override
  void initState() {
    super.initState();

    myController.addListener(_printLatestValue);
  }

   @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

_printLatestValue() {
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Page 2",
      )),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: myController,
            ),
            
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return "please enter some text";
                }
                return "salam";
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: RaisedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    
                    if (_formKey.currentState.validate()) {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                    }
                  }),
            ),
            Text(myController.text, style: TextStyle(color: Colors.green, fontSize: 22),)
          ],
        ),
      ),
    );
  }
}
