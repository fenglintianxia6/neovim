return {
  -- 代码片段
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node
      local c = ls.choice_node
      local d = ls.dynamic_node
      
      -- Dart/Flutter 代码片段
      ls.add_snippets("dart", {
        -- Flutter Widget
        s("fwidget", {
          t("class "),
          i(1, "WidgetName"),
          t(" extends StatelessWidget {"),
          t({ "", "  const " }),
          f(function(args) return args[1][1] end, { 1 }),
          t("({super.key});"),
          t({ "", "", "  @override", "  Widget build(BuildContext context) {", "    return " }),
          i(2, "Container()"),
          t({ ";", "  }", "}" }),
        }),
        
        -- StatefulWidget
        s("sfwidget", {
          t("class "),
          i(1, "WidgetName"),
          t(" extends StatefulWidget {"),
          t({ "", "  const " }),
          f(function(args) return args[1][1] end, { 1 }),
          t("({super.key});"),
          t({ "", "", "  @override", "  State<" }),
          f(function(args) return args[1][1] end, { 1 }),
          t("> createState() => _"),
          f(function(args) return args[1][1] end, { 1 }),
          t("State();"),
          t({ "}", "", "class _" }),
          f(function(args) return args[1][1] end, { 1 }),
          t("State extends State<"),
          f(function(args) return args[1][1] end, { 1 }),
          t("> {"),
          t({ "", "  @override", "  Widget build(BuildContext context) {", "    return " }),
          i(2, "Container()"),
          t({ ";", "  }", "}" }),
        }),
        
        -- MaterialApp
        s("mapp", {
          t("MaterialApp("),
          t({ "", "  title: " }),
          i(1, "'Flutter Demo'"),
          t({ ",", "  theme: ThemeData(", "    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),", "    useMaterial3: true,", "  ),", "  home: " }),
          i(2, "MyHomePage(title: 'Flutter Demo Home Page')"),
          t({ ",", ")" }),
        }),
        
        -- Scaffold
        s("scaffold", {
          t("Scaffold("),
          t({ "", "  appBar: AppBar(", "    backgroundColor: Theme.of(context).colorScheme.inversePrimary,", "    title: " }),
          i(1, "Text('Title')"),
          t({ ",", "  ),", "  body: " }),
          i(2, "Center("),
          t({ "", "    child: " }),
          i(3, "Text('Hello World')"),
          t({ "", "  )," }),
          i(4, ""),
          t({ ")" }),
        }),
        
        -- Column
        s("column", {
          t("Column("),
          t({ "", "  children: [" }),
          i(1, ""),
          t({ "", "  ]," }),
          t({ ")" }),
        }),
        
        -- Row
        s("row", {
          t("Row("),
          t({ "", "  children: [" }),
          i(1, ""),
          t({ "", "  ]," }),
          t({ ")" }),
        }),
        
        -- Container
        s("container", {
          t("Container("),
          t({ "", "  child: " }),
          i(1, "Text('Hello')"),
          t({ "", ")" }),
        }),
        
        -- Text
        s("text", {
          t("Text("),
          i(1, "'Hello World'"),
          t({ ")" }),
        }),
        
        -- ElevatedButton
        s("ebutton", {
          t("ElevatedButton("),
          t({ "", "  onPressed: () {", "    " }),
          i(1, ""),
          t({ "", "  },", "  child: " }),
          i(2, "Text('Button')"),
          t({ "", ")" }),
        }),
        
        -- ListView
        s("listview", {
          t("ListView("),
          t({ "", "  children: [" }),
          i(1, ""),
          t({ "", "  ]," }),
          t({ ")" }),
        }),
        
        -- Future
        s("future", {
          t("Future<"),
          i(1, "void"),
          t("> "),
          i(2, "functionName"),
          t("() async {"),
          t({ "", "  " }),
          i(3, ""),
          t({ "", "}" }),
        }),
        
        -- Stream
        s("stream", {
          t("Stream<"),
          i(1, "String"),
          t("> "),
          i(2, "streamName"),
          t("() async* {"),
          t({ "", "  " }),
          i(3, ""),
          t({ "", "}" }),
        }),
      })
    end,
  },
} 