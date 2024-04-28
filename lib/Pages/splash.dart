
import 'package:flutter/material.dart';
import 'package:nbtt_masr/Pages/onBoarding.dart';
import 'package:nbtt_masr/Pages/start_page.dart';
import 'package:nbtt_masr/helpers/constants.dart';
import 'package:nbtt_masr/models/BoardingModel.dart';
import 'package:nbtt_masr/service/sqlite_service/dbhelper.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //final FormDataService service = FormDataService();
  late DBHelper helper;
  late Future<void> _initForm;
  bool isFirst = false;

  /*final _boardingList = <BoardingModel>[];
  Future<void> _initStateAsync() async {
    _boardingList.addAll(await helper.allBoardingValue());
    //await dbInstallation();
    print(_boardingList.length);
  }*/

  @override
  void initState() {
    super.initState();
    helper = DBHelper();
    //_initStateAsync();
     dbInstallation();
  }
  void dbInstallation() async{
    List<BoardingModel> localBoardingList = await helper.allBoardingValue();
    print(localBoardingList.length);
    if(localBoardingList.length == 0){
      setState(() {
        isFirst = true;
      });
    }else{
      setState(() {
        isFirst = false;
      });
    }
  }

/*
  _SplashScreenState(){
    getData();
  }
  getData() async{
    Future<LastUpdateModel> apiLastUpdate =  service.getLastUpdate();
    Future<String> localLastUpdate = dbHelper.allLastUpdate();
    LastUpdateModel serverTime = await  apiLastUpdate.then((value) => value) ;
    // String localTime = localLastUpdate.then((value) => value.updateTime) as String;
    if(localLastUpdate !=null || localLastUpdate != ""){
      if(serverTime.updateTime != localLastUpdate){
        List goverData = service.getGovers() as List;
        List districtData = service.getDistrict() as List;
        for(int i = 0 ; i < goverData.length; i++ ){
          dbHelper.createGovernarate(goverData[i]);
        }
        for(int i =0 ; i < districtData.length; i++ ){
          dbHelper.createDistricts(districtData[i]);
        }

      }
      List govers = dbHelper.allGovers() as List;
      List districts = dbHelper.allDistricts() as List;
      for(int i = 0 ; i < govers.length; i ++){
        print(govers[i]);
      }
    }else{
      dbHelper.createLastUpdate(serverTime);
    }
  }
*/

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: screenHeight * 0.78,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/Group-99.png",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                /*SafeArea(child: SvgPicture.asset("assets/icons/splashLogo.svg",
                  height: screenHeight*0.2,), bottom: false,top: true,),*/
                Transform.translate(
                  offset: Offset(screenWidth * 0.35, screenHeight * 0.12),
                  child:
                      /*SvgPicture.asset("assets/icons/splashLogo.svg",
                    height: screenHeight*0.2,),*/
                      Image.asset(
                    "assets/images/nbttMasrLogo.png",
                    height: screenHeight * 0.2,
                  ),
                ),
              ],
            ),
            Container(
              height: screenHeight * 0.22,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.6,
                        height: screenHeight * 0.07,
                        child: FlatButton(
                          onPressed: () {
                            if (isFirst) {

                              helper.createBoardingValue(BoardingModel(name: "First"));

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OnBoardingPage()));
                            } else {
                             Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StartPage(
                                            firstTime: true,
                                          )));
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 45,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "البدء",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          gradient: kGradientColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ],
                  ),
                  /*     SizedBox(height: screenHeight*0.02,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(children: [
                        InkWell(
                          child: Text("الدخول لحسابى",style: TextStyle(
                            fontSize: 20,color: kGreenColor,
                          ),),
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage())),
                        ),
                        SizedBox(width: 20,),
                        Icon(Icons.person_rounded,color: kGreenColor,size: 25,)
                      ],)
                    ],
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
