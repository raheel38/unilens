import 'package:flutter/material.dart';
import 'dart:io';

// Post Model
class Post {
  final String title;
  final String content;
  final DateTime datePosted;
  final String? imageUrl;
  int likes;
  bool isLiked;

  Post({
    required this.title,
    required this.content,
    required this.datePosted,
    this.imageUrl,
    this.likes = 0,
    this.isLiked = false,
  });
}

// AddWidget for adding posts
class AddWidget extends StatefulWidget {
  final Function(Post) onPostCreated;

  const AddWidget({super.key, required this.onPostCreated});

  @override
  State<AddWidget> createState() => _AddWidgetState();
}

class _AddWidgetState extends State<AddWidget> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  File? _image;
  final _formKey = GlobalKey<FormState>();

  void _createPost() {
    if (_formKey.currentState!.validate()) {
      final newPost = Post(
        title: _titleController.text,
        content: _contentController.text,
        datePosted: DateTime.now(),
        imageUrl: _image?.path,
      );

      widget.onPostCreated(newPost);

      // Clear form
      _titleController.clear();
      _contentController.clear();
      setState(() {
        _image = null;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post created successfully!')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some content';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _createPost,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Create Post',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// CommunityWidget to display posts
class CommunityWidget extends StatefulWidget {
  final List<Post> posts;

  const CommunityWidget({super.key, required this.posts});

  @override
  State<CommunityWidget> createState() => _CommunityWidgetState();
}

class _CommunityWidgetState extends State<CommunityWidget> {
  void _toggleLike(int index) {
    setState(() {
      if (widget.posts[index].isLiked) {
        widget.posts[index].likes--;
        widget.posts[index].isLiked = false;
      } else {
        widget.posts[index].likes++;
        widget.posts[index].isLiked = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: widget.posts.length,
      itemBuilder: (context, index) {
        final post = widget.posts[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  post.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  'Posted on ${post.datePosted.toString().split(' ')[0]}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              if (post.imageUrl != null)
                Image.file(
                  File(post.imageUrl!),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(post.content),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        post.isLiked ? Icons.favorite : Icons.favorite_border,
                        color: post.isLiked ? Colors.red : Colors.grey,
                      ),
                      onPressed: () => _toggleLike(index),
                    ),
                    Text('${post.likes} likes'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// MainScreen to manage navigation and posts
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Post> _posts = [];

  void _addPost(Post post) {
    setState(() {
      _posts.insert(0, post); // Add new post at the beginning
    });
    // Navigate to community page after posting
    setState(() {
      _selectedIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      CommunityWidget(posts: _posts),
      AddWidget(onPostCreated: _addPost),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text(
              'UniLens',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

// Main entry point
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UniLens',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MainScreen(),
    );
  }
}
