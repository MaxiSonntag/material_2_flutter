import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter/services.dart';
import 'schedule.dart';

void main() => runApp(new MaterialDesign2App());

class MaterialDesign2App extends StatelessWidget {

  changeStatusBarColor() async{
    await FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  }

  @override
  Widget build(BuildContext context) {

    final lightTheme = ThemeData.light();
    final textTheme = ThemeData.light().textTheme;
    final fontFamily = "GoogleSans";


    //changeStatusBarColor();
    ThemeData _getTheme(){
      var theme = lightTheme.copyWith(
          splashFactory: InkRipple.splashFactory,
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Color.fromARGB(255, 51, 102, 255),
          indicatorColor: Color.fromARGB(255, 51, 102, 255),
          iconTheme: lightTheme.iconTheme.copyWith(color: Color.fromARGB(255, 51, 102, 255)),
          textTheme: textTheme.copyWith(
              title: textTheme.title.copyWith(color: Colors.black, fontFamily: fontFamily, fontWeight: FontWeight.normal),
              headline: textTheme.headline.copyWith(color: Colors.black, fontFamily: fontFamily),
              subhead: textTheme.subhead.copyWith(color: Colors.black54, fontFamily: fontFamily, letterSpacing: 0.0, fontWeight: FontWeight.bold, fontSize: 14.0),
              body1: textTheme.body1.copyWith(color: Colors.black, fontFamily: fontFamily),
              body2: textTheme.body2.copyWith(color: Colors.black, fontFamily: fontFamily),
              display1: textTheme.display1.copyWith(color: Colors.black, fontFamily: fontFamily),
              display2: textTheme.display2.copyWith(color: Colors.black, fontFamily: fontFamily),
              display3: textTheme.display3.copyWith(color: Colors.black, fontFamily: fontFamily),
              display4: textTheme.display4.copyWith(color: Colors.black, fontFamily: fontFamily)
          )
      );
      if(Theme.of(context).platform == TargetPlatform.android){
        return theme.copyWith(
          canvasColor: Color.fromARGB(255, 51, 102, 255),
          iconTheme: lightTheme.iconTheme.copyWith(color: Colors.white)
        );
      }
      return theme;
    }

    return new MaterialApp(
      theme: _getTheme(),
      home: new MaterialHomePage(),
    );
  }
}

class MaterialHomePage extends StatefulWidget {
  MaterialHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MaterialHomePage> {

  ThemeData theme;
  TextTheme textTheme;
  var selectedBottomIndex = 1;

  @override
  void initState() {

    super.initState();
  }

  bool _isAndroid(){
    return Theme.of(context).platform == TargetPlatform.android;
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    textTheme = theme.textTheme;
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: _getAppBar(),
          bottomNavigationBar: BottomNavigationBar(items: [
              BottomNavigationBarItem(
                title: Text("Info", style: textTheme.subhead.copyWith(color: Theme.of(context).iconTheme.color),),
                icon: Icon(Icons.info, color: _getBottomNavItemIconColor(),),
                activeIcon: Icon(Icons.info, color: Theme.of(context).iconTheme.color,)
              ),
              BottomNavigationBarItem(
                  title: Text("Planen", style: textTheme.subhead.copyWith(color: Theme.of(context).iconTheme.color),),
                  icon: Icon(Icons.calendar_today, color: _getBottomNavItemIconColor(),),
                  activeIcon: Icon(Icons.calendar_today, color: Theme.of(context).iconTheme.color,)
              ),
              BottomNavigationBarItem(
                  title: Text("Karte", style: textTheme.subhead.copyWith(color: Theme.of(context).iconTheme.color),),
                  icon: Icon(Icons.location_on, color: _getBottomNavItemIconColor(),),
                  activeIcon: Icon(Icons.location_on, color: Theme.of(context).iconTheme.color,)
              ),
            ],
              type: BottomNavigationBarType.shifting,
            currentIndex: selectedBottomIndex,
            onTap: (idx){
            setState(() {
              selectedBottomIndex = idx;
            });
            },

          ),
          body: _getBody(),
        )
    );
  }

  Color _getBottomNavItemIconColor(){
    if(_isAndroid()){
      return Colors.white70;
    }
    return Colors.black54;
  }

  // #### Start AppBar ####
  AppBar _getAppBar(){
    switch(selectedBottomIndex){
      case 0: return _getAppBarFor(title: "Info", tabBar: _getTabBar(tabs: _getInfoTabs()));
      case 1: return _getAppBarFor(
          title: "Planen",
          leading: IconButton(
            icon: Icon(Icons.info_outline, color: theme.primaryColor,),
            onPressed: (){},
          ),
          tabBar: _getTabBar(tabs: _getScheduleTabs())
      );
      default: return _getAppBarFor(title: "Karte");
    }
  }

  AppBar _getAppBarFor({@required String title, TabBar tabBar, Widget leading}){
    return AppBar(
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(title, style: textTheme.title, textAlign: TextAlign.center,),
      bottom: tabBar,
      leading: leading,
    );
  }

  TabBar _getTabBar({@required List<Tab> tabs}){
    return TabBar(
      tabs: tabs,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: textTheme.subhead,
      labelColor: Colors.black,
      unselectedLabelStyle: textTheme.subhead,
      unselectedLabelColor: Colors.black54,
    );
  }

  List<Tab> _getScheduleTabs(){
    return [
      Tab(text: "8. Mai",),
      Tab(text: "9. Mai"),
      Tab(text: "10 Mai"),
      Tab(text: "Termin-\nübersicht")
    ];
  }

  List<Tab> _getInfoTabs(){
    return [
      Tab(text: "Veranstal\ntung",),
      Tab(text: "Reisen",),
      Tab(text: "About",),
      Tab(text: "Einstellun\ngen",),
    ];
  }
  // #### End AppBar ####

  // #### Start Body ####

Widget _getBody() {
  switch (selectedBottomIndex) {
    case 0: return _getInfoBody();
    case 1: return ScheduleContent();
    default: return _getMapBody();
  }
}

  Widget _getInfoBody(){
    return TabBarView(
        children: [
          Center(
            child: Text("Tab 1 Info"),
          ),
          Center(
            child: Text("Tab 2 Info"),
          ),
          Center(
            child: Text("Tab 3 Info"),
          ),
          Center(
            child: Text("Tab 4 Info"),
          ),
        ]
    );
  }

  Widget _getMapBody(){
    return Center(
      child: Text("Map goes here"),
    );
  }

}