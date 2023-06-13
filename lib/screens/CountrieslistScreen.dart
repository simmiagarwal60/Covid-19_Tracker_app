import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trackerapp/screens/details_screen.dart';
import 'package:trackerapp/utils/stats_services.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with Country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  )
                ),
              ),
            ),
            Expanded(child: FutureBuilder(
              future: statsServices.countiresListapi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                if(!snapshot.hasData){
                  return ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, index){
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade300,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Container(width: 89,height: 10,color: Colors.white,),
                                    subtitle: Container(width: 89,height: 10,color: Colors.white,),
                                    leading: Container(width: 50,height: 50,color: Colors.white,)
                                  )],
                              ),
                            );
                          });
                }
                else{
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                      String searchcountry = snapshot.data![index]['country'];
                      if(searchController.text.isEmpty){
                        return Column(
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsScreen(
                                  name: snapshot.data![index]['country'],
                                  image: snapshot.data![index]['countryInfo']['flag'],
                                  totalCases: snapshot.data![index]['cases'].toString(),
                                  totalDeaths: snapshot.data![index]['deaths'].toString(),
                                  totalRecovered: snapshot.data![index]['recovered'].toString(),
                                  active: snapshot.data![index]['active'].toString(),
                                  critical: snapshot.data![index]['critical'].toString(),
                                  todayRecovered: snapshot.data![index]['todayRecovered'].toString(),
                                  test: snapshot.data![index]['tests'].toString(),
                                )));
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),

                              ),
                            )
                          ],
                        );
                      }
                      else if(searchcountry.toLowerCase().contains(searchController.text.toLowerCase())){
                        return Column(
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsScreen(
                                  name: snapshot.data![index]['country'],
                                  image: snapshot.data![index]['countryInfo']['flag'],
                                  totalCases: snapshot.data![index]['cases'].toString(),
                                  totalDeaths: snapshot.data![index]['deaths'].toString(),
                                  totalRecovered: snapshot.data![index]['recovered'].toString(),
                                  active: snapshot.data![index]['active'].toString(),
                                  critical: snapshot.data![index]['critical'].toString(),
                                  todayRecovered: snapshot.data![index]['todayRecovered'].toString(),
                                  test: snapshot.data![index]['tests'].toString(),
                                )));
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),

                              ),
                            )
                          ],
                        );
                      }
                      else{
                        return Container();
                      }

                      });
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
