import 'package:api_understanding/api_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UrlTextField extends StatefulWidget {

  @override
  State<UrlTextField> createState() => _UrlTextFieldState();
}

class _UrlTextFieldState extends State<UrlTextField> {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('Enter your Url'), centerTitle: true,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text('Enter the Video URL here', textAlign: TextAlign.center,style: GoogleFonts.ibmPlexMono(color: Colors.blue, fontSize: 35, fontWeight: FontWeight.bold),),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .2,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
            style: TextStyle(color: Colors.white, fontSize: 17.5),
            onChanged: (value) {},
            controller: controller,
            cursorHeight: 25,
            textAlignVertical: TextAlignVertical.center,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              labelText: 'URL',
              contentPadding: EdgeInsets.all(8),
              labelStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.75, color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              prefixIcon: Icon(Icons.link,size: 25,color: Colors.blue,),
              hintText: 'Enter Video URL',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              fillColor: Colors.blue,
              ),
              )
                  ),
                ),
              ElevatedButton(
                onPressed: (){
                  if(controller.text.isEmpty){
                    showDialog(context: context, builder: (context)=>
                       AlertDialog(
                        backgroundColor: Colors.black87,
                      title: Text('YouTube to MP3',style: GoogleFonts.ibmPlexSans(color: Colors.white),),
                      content: Text('This Field can\'t be empty',style: GoogleFonts.ibmPlexSans(color: Colors.white),),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK', style: TextStyle(color: Colors.blue),))
                      ],
                    ),
                    );
                  }else {Navigator.push(context, CupertinoPageRoute(builder: (context){
                    return ApiPage(videoUrl: controller.text.trim());
                  }));}
                },
                child: Container(
                  height: 50,
                  width: 150,
                  child: Center(child: Text('Validate'))))
              ],
            ),
          ),
        ),
      ),
    );
  }
}