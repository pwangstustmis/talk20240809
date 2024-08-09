import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final GenerativeModel _model;
  late final ChatSession _chat;
  String geminitext = '';
  TextEditingController intext = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: 'APIKey',
      generationConfig: GenerationConfig(
          temperature: 0.9,
          topK: 1,
          topP: 1.0,
          //maxOutputTokens: 150,
          responseMimeType: 'text/plain'),
    );
    _chat = _model.startChat();
  }

  void sendMsg() async {
    var response = await _chat.sendMessage(
      Content.text(intext.text),
    );
    setState(() {
      geminitext = response.text!;
    });
  }

  String removeMarkdown(String markdown) {
    // Replace bold text with plain text
    markdown =
        markdown.replaceAll(RegExp(r'\*\*(.+?)\*\*', multiLine: true), '');
    markdown = markdown.replaceAll(RegExp('__(.+?)__', multiLine: true), '');

    // Remove headings
    markdown =
        markdown.replaceAll(RegExp(r'^#+\s+(.+?)\s*$', multiLine: true), '');
    markdown = markdown.replaceAll(RegExp(r'^\s*=+\s*$', multiLine: true), '');
    markdown = markdown.replaceAll(RegExp(r'^\s*-+\s*$', multiLine: true), '');

    // Remove lists
    markdown = markdown.replaceAll(
      RegExp(r'^\s*[\*\+-]\s+(.+?)\s*$', multiLine: true),
      '',
    );
    markdown = markdown.replaceAll(
      RegExp(r'^\s*\d+\.\s+(.+?)\s*$', multiLine: true),
      '',
    );

    return markdown;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(children: [
          TextField(
            controller: intext,
          ),
          Expanded(
              child: Container(child: ListView(children: [Text(geminitext)])))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sendMsg();
        },
        child: Text('傳送'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
