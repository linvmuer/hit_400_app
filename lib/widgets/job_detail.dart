 import 'package:flutter/material.dart';
import 'package:hit_400_app/core/models/models.dart';



 class JobDetail extends StatefulWidget {
   final Job job;
   JobDetail({this.job})
;   @override
   _JobDetailState createState() => _JobDetailState();
 }
 
 class _JobDetailState extends State<JobDetail> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body:Column(children: [
         Flexible(
           flex:9,
           child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
		  backgroundColor:Colors.cyan,
                  title: Text('Job Details'),
                ),
                SliverToBoxAdapter(
                  child: Column(
		      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.job.Company,style: TextStyle(fontSize:20,),),
                      Text(widget.job.Title,style: TextStyle(fontSize: 18,),),
                      Text(widget.job.Type,style: TextStyle(fontSize: 16),),
                      Text(widget.job.CompanyUrl),
		      Text(widget.job.Location),
		      //Text(widget.job.HowToApply),
		      Text(widget.job.Description.replaceAll("<p>","").replaceAll("</p>","").replaceAll("<ul>","").replaceAll("</ul>","").replaceAll("<li>","").replaceAll("</li>","").replaceAll("<strong>","").replaceAll("</strong>",""))
                    ],
                  ),
                )
              ],
           ),
         ),
         Flexible(
           flex:1,
           child:Container(
	       height: double.infinity,
	       decoration: BoxDecoration(
	       color: Colors.grey.shade50,
		   ),
             child:Row(
		 mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 TextButton(onPressed: (){

                 },
                  child:Text('Apply')),
                  TextButton(
                    onPressed:(){},
		    
                    child:Text('Watch')
                  )
               ],
             )
           )
         )
       ],)
     );
   }
 }
