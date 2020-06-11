import 'package:flutter/material.dart';
import 'package:p_sticker/p_sticker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Sticker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Sticker> emojisData;
  TextEditingController _textC = TextEditingController();

  String showContent = '';

  @override
  void initState() {
    emojisData = StickerData.getEmojisData();
    super.initState();
  }

  @override
  void dispose() {
    _textC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sticker')),
      body: Column(
        children: <Widget>[
          StickerUtils.createRichText(showContent),
          TextField(
            controller: _textC,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: emojisData.length,
              itemBuilder: (context, index) {
                final img = emojisData[index].img;
                final text = emojisData[index].zhName;
                if (index == 0) {
                  return Row(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          if (_textC.text.isEmpty) return;
                          if (_textC.text.endsWith(']')) {
                            final c = _textC.text;
                            final endIndex = c.lastIndexOf('[');
                            _textC.text = c.substring(0, endIndex);
                          } else {
                            _textC.text = _textC.text
                                .substring(0, _textC.text.length - 1);
                          }
                        },
                        child: Text('Delete'),
                      ),
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            showContent = _textC.text;
                          });
                        },
                        child: Text('Send'),
                      ),
                    ],
                  );
                }

                return InkWell(
                  onTap: () {
                    _textC.text = '${_textC.text}$text';
                  },
                  child: Row(
                    children: <Widget>[
                      Image.asset(img,
                          width: 24, height: 24, package: 'p_sticker'),
                      Text(text)
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
