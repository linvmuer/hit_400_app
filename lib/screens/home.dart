import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:hit_400_app/core/models/models.dart';
import 'package:hit_400_app/core/services/notifiers.dart';
import 'package:hit_400_app/widgets/search.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return 
 Container(
          width: 400,
          height: 1200,
          child: Scaffold(
	    floatingActionButton:FloatingActionButton(
	      backgroundColor:Colors.cyan,	
	      onPressed:(){
		 context.read<JobService>().refreshJobs();
		 var jobs=context.read<JobService>().jobs;
		 print(jobs[1]);
	      },
	      child:Icon(Icons.refresh,)
		),
	    drawer: Drawer(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                      currentAccountPicture: CircleAvatar(
                        child: FlutterLogo(
                          size: 60,
                        ),
                      ),
                      accountName: Text('Linval M'),
                      accountEmail: Text('linvle2@gmail.com')),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text(
                      'Home',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.storage),
                    title: Text(
                      'Applied',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    trailing: Container(
                        width: 40,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Center(
                          child: Text('8'),
                        )),
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite),
                    title: Text(
                      'Wish List',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 12),
                    child: Text('Application Preferences'),
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text(
                      'Help & Support',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text(
                      'Settings',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text(
                      'Languages',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.close),
                    title: Text(
                      'Logout',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          ),
            body: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder: (context, innBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                        backgroundColor: Colors.transparent,
                        actions: [
                          IconButton(
                            onPressed: (){
                              var res=showSearch(context:context,delegate:Search());
			      print(res);
                            },
                            icon: Icon(Icons.search),
                          )
                        ],
                        pinned: true,
                        floating: false,
                        expandedHeight: 350,
                        automaticallyImplyLeading: true,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Flex(
                            direction: Axis.vertical,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                  child: Stack(
                                children: [
                                  // background container
                                  _BackLay(),
                                  //Greeting container
                                  _BackLayB(
                                    brandName:
                                        "Good Morning We want to get you hired",
                                  )
                                ],
                              )),
                              // Container(height: 30, color: Colors.white)
                            ],
                          ),
                        )),
                    SliverPersistentHeader(
                        pinned: true,
                        delegate: _SliverAppBarDelegate(
                            minHeight: 40,
                            maxHeight: 60,
                            child: Center(
                              child: TabBar(
                                  labelColor: Colors.black,
                                  unselectedLabelColor: Colors.grey,
                                  indicatorColor: Colors.transparent,
                                  tabs: [
                                    Tab(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                      left: Radius.circular(20),
                                                      right: Radius.circular(20)),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black54,
                                                    blurRadius: 2)
                                              ]),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: 16,
                                                left: 16,
                                                top: 12,
                                                bottom: 12),
                                            child: Text("All Jobs"),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                      left: Radius.circular(20),
                                                      right: Radius.circular(20)),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black54,
                                                    blurRadius: 2)
                                              ]),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: 16,
                                                left: 16,
                                                top: 12,
                                                bottom: 12),
                                            child: Text("For You"),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            )))
                  ];
                },
                body: TabBarView(children: [
                  _All(jobs:context.watch<JobService>().jobs),
                  _ForYou(),
                ]),
              ),
            ),
          ));
    
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate(
      {@required this.minHeight,
      @required this.maxHeight,
      @required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
var colors=[Colors.white10,Colors.teal[50]];
class _All extends StatelessWidget {

  final List<Job> jobs;
  _All({this.jobs});
  @override
  Widget build(BuildContext context) {
    print("List of jobs are ${jobs.length} long  passed to all jobs"); 
    return Container(
      color: Colors.transparent,
      child: ListView.builder(
        itemCount: jobs.length,
        padding: EdgeInsets.only(bottom:5),
        itemBuilder: (context, index) {
          return jobs.isEmpty?Text("No jobs"):ListTile(
            tileColor: index%2==0?colors[0]:colors[1],
            leading: CircleAvatar(
              backgroundColor: Colors.amberAccent,
              radius: 18,
            ),
            title: Text(jobs[index].Title),
            // subtitle: Text('A creative dev using typescript/NodeJS wanted'),
            //subtitle: _JobSubtitle(),
            trailing:Text(jobs[index].Created_At)
            ,
          );
        },
      ),
    );
  }
}
class  _JobSubtitle extends StatelessWidget{
  final Job job;
  
  _JobSubtitle({this.job});
  @override 
  Widget build(BuildContext context){
    
    return Container(
      height:120,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children:[
	//	Text(job.Company==null?'Nix':job.Company),
              SizedBox(width: 15,),
              Text(job.Location)
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              
              children:[
              Text("Stack"),
              SizedBox(width: 15,),
              for(int i=0;i<=2;i++)
                  Padding(
                    padding: const EdgeInsets.only(right:5.0),
                    child: Chip(
                        elevation: 4,
                      backgroundColor: Colors.grey[100],label: Text("Java"),),
                  )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
             
              children:[
              TextButton(
                onPressed: (){},
                child: Text("Apply"),),
              TextButton(
                onPressed: (){},
                child: Text("WishList"),)
            ]),
          )
        ],
      ),
    );
  }
}
class _ForYou extends StatelessWidget {
  final MockApi _api=MockApi();
  @override
  Widget build(BuildContext context) {
  
    return FutureBuilder(
      future:_api.fetchJobs(),
      builder:(context,jobsSnap){
        if(jobsSnap.connectionState==ConnectionState.none
        && jobsSnap.hasData==null)
        {
          return Center(child:Text("Couldnot find anything;"));
        }
	if(jobsSnap.connectionState==ConnectionState.waiting)
	{
	  return Center(child:CircularProgressIndicator());
	}
        return ListView.builder(
        itemCount: jobsSnap.data.length,
        padding: EdgeInsets.only(bottom:5),
        itemBuilder: (context, index) {
          Job currentJob=jobsSnap.data[index];
          return ListTile(
            tileColor: index%2==0?colors[0]:colors[1],
            leading: CircleAvatar(
              backgroundColor: Colors.amberAccent,
              radius: 18,
            ),
            title: Text(currentJob.Title),
            // subtitle: Text('A creative dev using typescript/NodeJS wanted'),
            //subtitle: _JobSubtitle(),
            trailing:Text(currentJob.Created_At)
            ,
          );
        },
      );
      }
    );
      }
}

class _BackLay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350,
      color: Color(0xFF38BEC9),
      // put some image and a marketing thing in the background
    );
  }
}

class _BackLayB extends StatelessWidget {
  final String brandName;

  const _BackLayB({Key key, this.brandName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350,
      color: Color(0xFF38BEC9),
      child: Center(
        // put the brand log in
        child: Text(
          brandName,
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
    );
  }
}
