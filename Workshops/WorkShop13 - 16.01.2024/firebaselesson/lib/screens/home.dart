import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final firebaseAuthInstance = FirebaseAuth.instance;
final firebaseStorageInstance = FirebaseStorage.instance;
final firebaseFireStore = FirebaseFirestore.instance;
final fcm = FirebaseMessaging.instance;

class Message {
  final String senderId;
  final String content;
  final DateTime timestamp;

  Message({
    required this.senderId,
    required this.content,
    required this.timestamp,
  });
}

class ChatService {
  final CollectionReference _messagesCollection =
      FirebaseFirestore.instance.collection('messages');

  Future<void> sendMessage(String senderId, String content) async {
    await _messagesCollection.add({
      'senderId': senderId,
      'content': content,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Message>> getMessages() {
    return _messagesCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Message(
          senderId: data['senderId'],
          content: data['content'],
          timestamp: (data['timestamp'] as Timestamp).toDate(),
        );
      }).toList();
    });
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  File? _selectedImage;

  @override
  void initState() {
    _requestNotificationPermission();
    super.initState();
  }

  void _requestNotificationPermission() async {
    NotificationSettings settings = await fcm.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await fcm.getToken();
      _updateTokenInDb(token!);

      fcm.onTokenRefresh.listen((token) {
        _updateTokenInDb(token);
      });

      await fcm.subscribeToTopic("flutter1b");
    }
  }

  void _updateTokenInDb(String token) async {
    await firebaseFireStore
        .collection("users")
        .doc(firebaseAuthInstance.currentUser!.uid)
        .update({'fcm': token});
  }

  void _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _uploadImage() async {
    if (_selectedImage != null) {
      User? loggedInUser = firebaseAuthInstance.currentUser;

      final storageRef = firebaseStorageInstance
          .ref()
          .child("images")
          .child("${loggedInUser!.uid}.jpg");

      await storageRef.putFile(_selectedImage!);

      final url = await storageRef.getDownloadURL();

      await firebaseFireStore
          .collection("users")
          .doc(loggedInUser.uid)
          .update({'imageUrl': url});
    }
  }

  Future<String> _getUserImage() async {
    User? loggedInUser = firebaseAuthInstance.currentUser;
    final document =
        firebaseFireStore.collection("users").doc(loggedInUser!.uid);
    final documentSnapshot = await document.get();

    final imageUrl = await documentSnapshot.get("imageUrl");

    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: Center(
            child: const Text(
              "Tobeto Chat",
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                firebaseAuthInstance.signOut();
              },
              icon: const Icon(Icons.logout),
            ),
          ]),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _chatService.getMessages(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  List<Message> messages = snapshot.data ?? [];
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      Message message = messages[index];
                      bool isCurrentUser = message.senderId ==
                          firebaseAuthInstance.currentUser!.uid;

                      return ListTile(
                        title: Align(
                          alignment: isCurrentUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(100),
                              color: isCurrentUser
                                  ? Colors.blue
                                  : Colors.grey[300],
                            ),
                            padding: EdgeInsets.all(8),
                            child: Text(
                              message.content,
                              style: TextStyle(
                                color:
                                    isCurrentUser ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        subtitle: Text(
                          '${message.senderId} - ${message.timestamp}',
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Mesajınızı yazınız...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    String messageContent = _messageController.text.trim();
                    if (messageContent.isNotEmpty) {
                      _chatService.sendMessage(
                        firebaseAuthInstance.currentUser!.uid,
                        messageContent,
                      );
                      _messageController.clear();
                    }
                  },
                  icon: Icon(
                    Icons.send_sharp,
                    color: Colors.grey.shade900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          if (_selectedImage == null)
            FutureBuilder(
              future: _getUserImage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    foregroundImage: NetworkImage(snapshot.data!),
                  );
                }
                if (snapshot.hasError) {
                  return Text("Avatar yüklenirken bir hata oluştu..");
                }
                return CircularProgressIndicator();
              },
            ),
          if (_selectedImage != null)
            CircleAvatar(
              radius: 40,
              foregroundImage: FileImage(_selectedImage!),
            ),
          TextButton(
            onPressed: () {
              _pickImage();
            },
            child: const Text("Resim Seç"),
          ),
          if (_selectedImage != null)
            ElevatedButton(
              onPressed: () {
                _uploadImage();
              },
              child: const Text("Yükle"),
            ),
        ],
      ),
    );
  }
}
