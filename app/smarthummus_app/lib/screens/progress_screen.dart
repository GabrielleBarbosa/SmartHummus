import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smarthummusapp/bluetooth/bluetooth_app.dart';
import 'package:smarthummusapp/database/database.dart';
import 'package:smarthummusapp/database/instruction.dart';

class ProgressScreen extends StatefulWidget {
  bool _hasComposter;
  bool isFull;
  Function() reload;

  ProgressScreen(this._hasComposter, this.reload, this.isFull);

  @override
  _ProgressScreenState createState() =>
      _ProgressScreenState(this._hasComposter);
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
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 20, bottom: 20, left: 10, right: 10),
                    child: buildInstructions(snapshot.data),
                  );
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        ),
      )),
    );
  }

  Widget buildInstructions(instructions) {
    return ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            instructions[index].isExpanded = !isExpanded;
          });
        },
        children: instructions.map<ExpansionPanel>((Instruction item) {
          return ExpansionPanel(
              isExpanded: item.isExpanded,
              headerBuilder: (context, isExpanded) {
                return Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: Text(
                        item.title,
                        style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(30, 67, 255, 0.7),
                        ),
                      ),
                    )
                  ],
                );
              },
              body: Container(
                margin: EdgeInsets.only(bottom: 30),
                width: MediaQuery.of(context).size.width / 1.3,
                child: Text(
                  item.content,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.raleway(height: 1.4),
                ),
              ));
        }).toList());
  }

  Widget buildProgress() {
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
                Text(
                  (progress * 100).toString() + "%",
                  style: GoogleFonts.raleway(
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Aproximadamente " +
                        (30 - progress * 30).toInt().toString() +
                        "\ndias até ficar pronto",
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
        SizedBox(
          height: 20,
        ),
        Divider(),
        Image(
          image: AssetImage('assets/images/level.png'),
          width: 50,
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width / 1.5,
          child: Text(widget.isFull
              ? "O nível do chorume está cheio, você já pode extraí-lo pela torneira!"
              : "O chorume ainda não está cheio!",
            textAlign: TextAlign.center,),
        ),

        Divider(),

      ],
    );
  }

  Widget buildButton() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 30),
      child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Image(
                  image: AssetImage("assets/images/composter-off.png"),
                  fit: BoxFit.cover,
                  width: 150),
              SizedBox(height: 10),
              Text(
                "Parece que você ainda não\ntem uma composteira :(",
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(fontSize: 17),
              ),
              SizedBox(height: 30),
              RaisedButton(
                color: Color.fromRGBO(17, 204, 199, 1.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                  child: Text(
                    "Conectar\nComposteira",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => BluetoothApp()))
                      .then((value) => widget.reload());
                },
              ),
            ],
          )),
    );
  }
}
