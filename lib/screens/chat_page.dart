import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
   ChatPage({super.key});
  static String id='ChatPage';
  CollectionReference messages = FirebaseFirestore.instance.collection('messages');
  TextEditingController controller=TextEditingController();
  ScrollController scrollController=ScrollController();
 


  @override
  Widget build(BuildContext context) {
     var email=ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('atCreated',descending: true).snapshots(), 
    builder: (context,snapshot){
      if(snapshot.hasData){
        List<Message>messageList=[];
        for (int i=0; i<snapshot.data!.docs.length;i++) {
          messageList.add(Message.fromJson(snapshot.data!.docs[i]));
          
        }
         return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/scholar.png',height: 50,),
            const Text('chat',style: TextStyle(color: Colors.white),)
          ],
        ), 
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              
              itemCount: messageList.length,
            controller: scrollController,
              itemBuilder: (context,index){
              return messageList[index].id==email? ChatBuble(message: messageList[index],):
                ChatBubleForFrind(message: messageList[index]);
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller:controller ,
              onSubmitted: (value) {
                messages.add({
                  'message':value,
                'atCreated':DateTime.now(),
                'id':email});
                controller.clear();
                scrollController.animateTo(
                  0, 
                  duration: const Duration(seconds: 1), 
                  curve: Curves.fastOutSlowIn);

              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: const Icon(Icons.send,color: kPrimaryColor,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: kPrimaryColor
                  )
                )
              ),
            ),
          )
        ],
      ),
    );

      }
      else {
        return const Text('logining....');
      }
    });
  }
}

