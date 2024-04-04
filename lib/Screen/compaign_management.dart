import 'package:drawmoneyadmin/Helper/Colors.dart';
import 'package:drawmoneyadmin/Screen/add_compaign.dart';
import 'package:flutter/material.dart';
class CompaignManagement extends StatefulWidget {
  const CompaignManagement({Key? key}) : super(key: key);

  @override
  State<CompaignManagement> createState() => _CompaignManagementState();
}

class _CompaignManagementState extends State<CompaignManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: AppColors.whit,
        backgroundColor: AppColors.appbar,
        title:Text("Campaign Management",style: TextStyle(fontSize: 20),),
      ),
      floatingActionButton: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCompaign()));
        },
        child: Container(
          height: 40,
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
                color: AppColors.appbar
          ),
          child: Center(child: Text('Add Compaign+',style: TextStyle(color: AppColors.whit),),),
        ),
      ),
    );
  }
}
