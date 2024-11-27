import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final List<Post> _posts = [];
  bool _isAddingPost = false;

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Color _postButtonColor = const Color(0xFF450000);
  Color _postTextColor = Colors.white;
  Color _cancelButtonColor = Colors.white;
  Color _cancelTextColor = const Color(0xFF450000);

  void _addPost() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _posts.insert(
          0,
          Post(
            title: _titleController.text,
            content: _contentController.text,
            datePosted: DateTime.now(),
          ),
        );
        _isAddingPost = false; // Close the add post screen
      });
      _titleController.clear();
      _contentController.clear();
    }
  }

  void _toggleAddPost() {
    setState(() {
      _isAddingPost = !_isAddingPost;
    });
  }

  void _toggleButtonColors() {
    setState(() {
      // Swap Post button colors
      final tempPostColor = _postButtonColor;
      _postButtonColor = _postTextColor;
      _postTextColor = tempPostColor;

      // Swap Cancel button colors
      final tempCancelColor = _cancelButtonColor;
      _cancelButtonColor = _cancelTextColor;
      _cancelTextColor = tempCancelColor;
    });
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
      body: _isAddingPost
          ? Padding(
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
                        border: UnderlineInputBorder(),
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
                        border: UnderlineInputBorder(),
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
                      onPressed: () {
                        _addPost();
                        _toggleButtonColors();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _postButtonColor,
                      ),
                      child: Text(
                        'Post',
                        style: TextStyle(color: _postTextColor),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _toggleAddPost();
                        _toggleButtonColors();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: _cancelTextColor,
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: _cancelButtonColor),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : _posts.isEmpty
              ? const Center(
                  child: Text('No posts yet. Tap the "+" button to add one!'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _posts.length,
                  itemBuilder: (context, index) {
                    final post = _posts[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(post.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.content,
                              style: const TextStyle(color: Colors.black54),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Posted on ${post.datePosted.toString().split(' ')[0]}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleAddPost,
        backgroundColor: const Color(0xFF450000),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class Post {
  final String title;
  final String content;
  final DateTime datePosted;

  Post({
    required this.title,
    required this.content,
    required this.datePosted,
  });
}
