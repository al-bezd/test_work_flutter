import 'package:flutter/material.dart';
import 'package:users/apps/posts/models.dart';
import 'package:users/functions.dart';
import 'package:users/widgets.dart';

class PostDetails extends StatefulWidget {
  PostDetails({Key? key, required this.id}) : super(key: key);

  String id;

  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  late Future future;
  late Post currentPost;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    future = fetchFuture();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        Widget result = loader();
        if (snapshot.hasData) {
          result = fetchBody();
        } else if (snapshot.hasError) {
          result = fetchError(snapshot.error.toString());
        }
        return result;
      },
    );
  }

  Future<bool> fetchFuture() async {
    currentPost = await Post.fetchPostById(widget.id);
    return true;
  }

  Widget fetchBody() {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(currentPost.title),
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 16,
                ),
                titleWidget('Пост'),
                Text(currentPost.body),
                titleWidget('Комментарий'),
                Column(
                  children: List.generate(
                      currentPost.comments.length,
                      (index) => ListTile(
                            title: Text(currentPost.comments[index].name),
                            subtitle: Text(currentPost.comments[index].body),
                          )),
                ),
                const SizedBox(
                  height: 96,
                )
              ],
            ),
          ),
          TextButton(
              onPressed: sendComment,
              child: Container(
                height: kToolbarHeight,
                width: MediaQuery.of(context).size.width,
                alignment: AlignmentDirectional.center,
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: LinearGradient(
                        colors: [Colors.blue, Colors.blue[400]!])),
                child: const Text(
                  'Оставить комментарий',
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }

  titleWidget(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  void sendComment() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Имя', labelText: 'Имя'),
                        textInputAction: TextInputAction.next,
                        controller: nameController,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Email', labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: emailController,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Текст', labelText: 'Текст'),
                        controller: textController,
                        minLines: 2,
                        maxLines: 4,
                      ),
                      ElevatedButton(
                        onPressed: send,
                        child: const Text('Отправить'),
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

  void send() async {
    hideKeyboard(context);
    if (_formKey.currentState!.validate()) {
      Comment? response = await Comment.sendComment(
          postId: int.parse(widget.id),
          name: nameController.text,
          email: emailController.text,
          text: textController.text);
      if (response != null) {
        currentPost.comments.add(response);
        _scaffoldKey.currentState!.setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Комментарий успешно сохранен'),
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Произошла ошибка'),
          ),
        );
      }
    }
  }
}
