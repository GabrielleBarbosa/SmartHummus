import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:smarthummusapp/database/database.dart';
import 'package:smarthummusapp/database/instruction.dart';

class ProgressScreen extends StatefulWidget {
  bool _hasComposter;

  ProgressScreen(this._hasComposter);
  @override
  _ProgressScreenState createState() => _ProgressScreenState(this._hasComposter);
}

class _ProgressScreenState extends State<ProgressScreen> {

  bool _hasComposter;
  _ProgressScreenState(this._hasComposter);


  double progress = 0.4;
  Future<List<Instruction>> _instructions;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _instructions = Database.getInstructions();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _hasComposter ? buildProgress() : buildButton(),
                FutureBuilder<List<Instruction>>(
                  future: _instructions,
                  builder: (context, snapshot){
                    if(snapshot.hasData)
                      return Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
                        child: buildInstructions(snapshot.data),
                      );
                    return CircularProgressIndicator();
                  },
                )
              ],
            ),
          )
      ),
    );
  }

  Widget buildInstructions(instructions){
    return ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            instructions[index].isExpanded = !isExpanded;
          });
        },
        children: instructions.map<ExpansionPanel>((Instruction item) {
          return ExpansionPanel(
              isExpanded: item.isExpanded,
              headerBuilder: (context, isExpanded){
                return Row(
                  children: [
                    Text(item.title),
                  ],
                );
              },
              body: Container (
                width: MediaQuery.of(context).size.width/1.5,
                child: Text(item.content, textAlign: TextAlign.justify,),
              )
          );
        }).toList()
    );
  }

  Widget buildProgress(){
    return Column(
      children: [
        Text(
          "STATUS",
          style: GoogleFonts.raleway(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color.fromRGBO(10, 10, 10, 100.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: CircularPercentIndicator(
            radius: 200.0,
            lineWidth: 15.0,
            percent: progress,
            backgroundColor: Color.fromRGBO(195, 214, 220, 100.0),
            progressColor: Color.fromRGBO(143, 255, 0, 100.0),
            footer: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text((progress*100).toString() + "%",
                  style: GoogleFonts.raleway(
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text("Aproximadamente " + (30 - progress*30).toInt().toString() + "\ndias até ficar pronto",
                    style: GoogleFonts.raleway(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            center: Image(
              image: AssetImage('assets/images/leaf_progress.png'),
              width: 150,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButton(){
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 30),
      child: Container(
        alignment: Alignment.center,
        child: RaisedButton(
          child: Text("Conectar\nComposteira", textAlign: TextAlign.center,),
          onPressed: (){},
        ),
      ),
    );
  }
}


