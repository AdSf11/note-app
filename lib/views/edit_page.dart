import 'package:flutter/material.dart';
import '../models/note.dart';

class EditPage extends StatefulWidget {
  final Note? note;
  const EditPage({super.key, this.note});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.note == null ? 'إضافة ملاحظة' : 'تعديل الملاحظة', style: const TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.deepPurple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                maxLines: 8,
                style: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'اكتب ملاحظتك هنا...'
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context, Note(content: _controller.text));
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('حفظ'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text('إلغاء'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
