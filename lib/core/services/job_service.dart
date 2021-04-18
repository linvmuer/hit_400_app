import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hit_400_app/core/models/models.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

const JobBoxKey="myJobBox";
class JobService with ChangeNotifier{
    MockApi _api=MockApi();

    List<Job> _jobs=[];
    UnmodifiableListView<Job> get jobs=> UnmodifiableListView<Job>(_jobs);
    bool isLoading=true;
    bool failedToLoad=false;
  JobService(){
    _api.fetchJobs().then(
      (jobs){
        _jobs=jobs;
        isLoading=false;
        notifyListeners();
      })
      .catchError((err){
          failedToLoad=true;
          notifyListeners();
      });
    
  
  
  }

    void refreshJobs(){
      isLoading=true;
      _api.fetchJobs().then( (jobs){ _jobs=jobs; isLoading=false; notifyListeners(); }) .catchError((err){ failedToLoad=true;
          notifyListeners();
      });
    }

}


class MockApi{
Future<List<Job>> fetchJobs() async{
  var url =
      Uri.http("localhost:8081", '/allJobs', {'q': '{http}'});

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  print(response);
  if (response.statusCode == 200) {
    // print(response.body);
  }
  var parsedList=json.decode(response.body);
  List<Job> jobList=List<Job>.from(parsedList.map((i)=>Job.fromJson(i)));
  print(jobList[0].Company);
  print(jobList.length);
  jobList.forEach((job)async {
  var box=await Hive.openBox(JobBoxKey);
    box.add(job);
    print(box.getAt(0));
  });
   return jobList;
}

Future<List<Job>> cachedJobs()async{
  Hive.init("./");
  
  var box=Hive.box(JobBoxKey);
  print(box.get(0));
  List<Job> jobs=[];
  for(var index=0;index<box.length;index++){
    var currJob=box.getAt(index);
    jobs.add(currJob);
  }
  return jobs;
}

Future<List<Job>> fetchJobsDesc(String description,{int pages=1}) async{


var url=   Uri.http("localhost:8081", '/allJobDesc', {'q': '{http}','description':"$description","pages":"2"},);

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  print(response);
  if (response.statusCode == 200) {
    // print(response.body);
  }
  var parsedList=json.decode(response.body);
  List<Job> jobList=List<Job>.from(parsedList.map((i)=>Job.fromJson(i)));
  print(jobList[0].Company);
  print(jobList.length);
  jobList.forEach((job)async {
  var box=await Hive.openBox(JobBoxKey);
    box.add(job);
  });
   return jobList;
}
}
