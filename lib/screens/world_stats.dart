import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:trackerapp/models/WorldStatsModel.dart';
import 'package:trackerapp/utils/stats_services.dart';

import 'CountrieslistScreen.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({super.key});

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              FutureBuilder(
                future: statsServices.fetchWorldStats(),
                builder: (context,AsyncSnapshot<WorldStatsModel> snapshot){
                if(!snapshot.hasData){
                  return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                      color: Colors.black54,
                      size: 50,
                      controller: _controller,
                    ),
                  );
                }
                else{
                  return Column(
                    children: [
                      PieChart(dataMap: {
                        'Total': double.parse(snapshot.data!.cases!.toString()),
                        'Recovered': double.parse(snapshot.data!.recovered!.toString()),
                        'Deaths':double.parse(snapshot.data!.deaths!.toString()),
                      },
                        chartValuesOptions: ChartValuesOptions(
                          showChartValuesInPercentage: true
                        ),
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        animationDuration: Duration(milliseconds: 1200),
                        chartType: ChartType.ring,
                        legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left
                        ),),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          child: Column(
                            children: [
                              ReusableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                              ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                              ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                              ReusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                              ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                              ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                              ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),

                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesListScreen()));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text('Track Countries'),
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget{
  String title, value;

  ReusableRow({Key? key, required this.title, required this.value}):super(key: key);

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}