import 'dart:math';

import 'package:flutter/material.dart';

class ScheduleContent extends StatelessWidget{



  @override
  Widget build(BuildContext context) {
    return TabBarView(
        children: [
          ScheduleFirstTab(List.generate(20, (idx){
            return "Google Keynote $idx";
          })),
          ScheduleSecondTab(List.generate(20, (idx){
            return "9.Mai sample $idx";
          })),
          ScheduleThirdTab(),
          ScheduleFourthTab()
        ]
    );
  }
}

class ScheduleFirstTab extends StatelessWidget{

  List<String> content;

  ScheduleFirstTab(this.content);

  @override
  Widget build(BuildContext context) {
    return TimeList(content);
  }
}

class ScheduleSecondTab extends StatelessWidget{

  List<String> content;

  ScheduleSecondTab(this.content);

  @override
  Widget build(BuildContext context) {
    return TimeList(content);
  }
}

class ScheduleThirdTab extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Schedule Third Tab"),
    );
  }
}

class ScheduleFourthTab extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Schedule Fourth Tab"),
    );
  }
}

class RandomTimeItem extends StatelessWidget{

  final int _hour = Random().nextInt(12);
  final int _minute = Random().nextInt(59);
  final bool _am = Random().nextBool();


  String getMinuteStr(){
    if(this._minute < 10){
      return "0$_minute";
    }
    return "$_minute";
  }

  String getDaytimeStr(){
    return this._am ? "VORM." : "NACHM.";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("$_hour:${getMinuteStr()}", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),),
        Text(getDaytimeStr(), style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12.0),),
      ],
    );
  }
}

class TimeList extends StatelessWidget{

  List<String> content;
  TimeList(this.content);



  @override
  Widget build(BuildContext context) {
    TextStyle _titleStyle = Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.w500, fontSize: 16.0);
    return ListView.builder(
        itemCount: content.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(content[index], style: _titleStyle,),
            subtitle: Text("${content[index]} subtitle"),
            leading: Container(
              width: MediaQuery.of(context).size.width / 7,
              child: RandomTimeItem(),
            ),
            trailing: Icon(Icons.star_border),
          );
        });
  }
}