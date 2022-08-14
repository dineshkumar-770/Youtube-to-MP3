import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

class ApiPage extends StatefulWidget {
  final String videoUrl;

  ApiPage({required this.videoUrl});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {

   var duration;
   var title;
   var thumbnail;
   var downloadlink;
   var videodown;
   var videoInfo;
   bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getYoutubeData(widget.videoUrl.toString());
  }
   _launchUrl(String url) async {
    
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launch(
        uri.toString(),
        enableJavaScript: true
        );
      print('URL Launched');
    } else {
    }
  }

  Future<Widget> getImage()async{
    var newLink = thumbnail;
    return await Image.network(newLink);
  }
  Future <Widget> getData()async{
    var newTitle = title;
    var newDuration = duration;
    return await Container(
      width: double.infinity,
      child: ListView(children: [
        Text(newTitle),
        Text(newDuration),
        Text(videoInfo),
      ]),
    );
  }
  Future getYoutubeData(String vurl) async{
    Uri url = Uri.https(
        't-one-youtube-converter.p.rapidapi.com', '/api/v1/createProcess',
        {
            'url': vurl,
            'format': 'mp3',
            'responseFormat': 'json',
            'lang': 'en'
          },//isme jo params diye hai vo aayege vrna khali chod do
        );
    
    var response = await http.get(url, headers: {
          'X-RapidAPI-Key': 'e7eff69b2amsh2e26d250794a32dp1a580djsnf7ebf55b9071',
          'X-RapidAPI-Host': 't-one-youtube-converter.p.rapidapi.com'
        });
    print(response.statusCode);

    var decodeData = jsonDecode(response.body);
    setState(() {
      this.duration = decodeData['YoutubeAPI']['durata_video'];
      this.title = decodeData['YoutubeAPI']['titolo'];
      this.thumbnail = decodeData['YoutubeAPI']['thumbUrl'];
      this.downloadlink = decodeData['YoutubeAPI']['urlMp3'];
      this.videodown = decodeData['YoutubeAPI']['urlVideo'];
      this.videoInfo = decodeData['YoutubeAPI']['data_pubblicazione'];
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Using API DATA',),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
               Container(
                  height: height* 0.3,
                  width: width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 5, color: Colors.blue),
                  ),
                  child: FutureBuilder(
                    future: getImage(),
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        return Image.network(thumbnail, fit: BoxFit.fill,);
                      }else{
                        return SizedBox(
                          height: 50,
                          width: 50,
                          child: Center(child: CircularProgressIndicator(color: Colors.blue,)),
                        );
                      }
                    },
                    ),
                ),
                SizedBox(height: 15,),
                Container(
                  height: height * 0.4,
                  width: width * 0.8,
                  child: FutureBuilder(
                    future: getData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          width: double.infinity,
                          child: ListView(children: [
                            Text('Name:- '+ title,textAlign: TextAlign.center ,style: GoogleFonts.ibmPlexSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),),
                            SizedBox(height: 10,),
                            Text('Duration:- ' +duration,textAlign: TextAlign.center ,style: GoogleFonts.ibmPlexSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),),
                            SizedBox(height: 10,),
                            Text('Date and Time:- ' +videoInfo,textAlign: TextAlign.center ,style: GoogleFonts.ibmPlexSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),)
                          ]),
                        );
                      }else{
                        return Center(child: CircularProgressIndicator());
                      }
                    },),
                ),
                Container(
                  width: width* 0.8,
                  child: ElevatedButton(
                    onPressed: (){
                      setState(() {
                        
                      });
                      downloadlink == false?
                      showDialog(context: context, builder: (context)=>
                         AlertDialog(
                        backgroundColor: Colors.black87,
                        title: Text('YouTube to MP3',style: GoogleFonts.ibmPlexSans(color: Colors.white),),
                        content: Text('Download link not available',style: GoogleFonts.ibmPlexSans(color: Colors.white),),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK', style: TextStyle(color: Colors.blue),))
                        ],
                      ),
                      )
                      : _launchUrl(downloadlink);
                    },
                    child: Container(
                      child: Text('Download MP3'),
                    )),
                ),
                Container(
                  width: width * 0.8,
                  child: ElevatedButton(
                    onPressed: (){
                      setState(() {
                        
                      });
                      videodown==false?
                      showDialog(context: context, builder: (context)=>
                         AlertDialog(
                          backgroundColor: Colors.black87,
                        title: Text('YouTube to MP3', style: GoogleFonts.ibmPlexSans(color: Colors.white),),
                        content: Text('Download link not availabe',style: GoogleFonts.ibmPlexSans(color: Colors.white),),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK', style: TextStyle(color: Colors.blue),))
                        ],
                      ),
                      )
                      :_launchUrl(videodown);
                    },
                    child: Container(
                      child: Text('Download HD'),
                    )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//'https://www.youtube.com/watch?v=6qeT4rvcak0'
/*
Container(
                height: height * 0.3,
                width: width * 0.8,
                child: Image.network(thumbnail)==null?Image.network('https://media.istockphoto.com/vectors/loading-circle-load-internet-data-symbol-business-network-isolated-vector-id1188197628?k=20&m=1188197628&s=170667a&w=0&h=dBtl75DZD_GoW3dYheF6Kc0Gyzm5v8OphdhY4VTMm-M='):Image.network(thumbnail),
              ),
*/ 