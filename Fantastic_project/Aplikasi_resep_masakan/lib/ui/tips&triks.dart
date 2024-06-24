import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class TipsTricksPage1 extends StatelessWidget {
  TipsTricksPage1({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tips dan Triks',
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontFamily: 'Euclid Circular A',
            fontSize: 16,
            letterSpacing: 0,
            fontWeight: FontWeight.normal,
            height: 1,
          ),
        ),
        backgroundColor: const Color.fromRGBO(26, 77, 46, 1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cari artikel...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 16.0),
              // Category tabs
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChoiceChip(
                    label: const Text('Untukmu'),
                    selected: true,
                    onSelected: (bool selected) {},
                  ),
                  ChoiceChip(
                    label: const Text('Populer'),
                    selected: false,
                    onSelected: (bool selected) {},
                  ),
                  ChoiceChip(
                    label: const Text('Suka'),
                    selected: false,
                    onSelected: (bool selected) {},
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              // Featured article card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Image.asset(
                        'assets/image/tip_feature.png'), // Replace with your featured tip image
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              // Recommended section title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Rekomendasi Untukmu',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Lihat Semua'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              // Recommended articles list
              const TipsTricksCard(
                imagePath:
                    'assets/image/tip1.png', // Replace with your tip image
                title: 'Cara memotong dengan benar',
                subtitle: '10m Lalu',
              ),
              const SizedBox(height: 16.0),
              const TipsTricksCard(
                imagePath:
                    'assets/image/tip2.png', // Replace with another tip image
                title: 'Ternyata ini bumbu rahasia Crustycrab!',
                subtitle: '10m Lalu',
              ),
              const SizedBox(height: 16.0),

              // StreamBuilder for Firestore data
              StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('tasks')
                    .orderBy('timestamp', descending: false) // Change order
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        final titleEdc = TextEditingController(
                            text: data['title'].toString());
                        final noteEdc = TextEditingController(
                            text: data['note'].toString());
                        return SizedBox(
                          height: 170.0,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: Text(
                                          data['title'],
                                          maxLines: 1,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: PopupMenuButton<String>(
                                          onSelected: (value) {
                                            if (value == 'edit') {
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (context) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Form(
                                                      key: _formKey,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          TextFormField(
                                                            controller:
                                                                titleEdc,
                                                          ),
                                                          const SizedBox(
                                                              height: 10.0),
                                                          SizedBox(
                                                            height: 300,
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  noteEdc,
                                                              maxLines: null,
                                                              expands: true,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                bottom: MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                            child: SizedBox(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  if (_formKey
                                                                      .currentState!
                                                                      .validate()) {
                                                                    try {
                                                                      await _firestore
                                                                          .collection(
                                                                              'tasks')
                                                                          .doc(document
                                                                              .id)
                                                                          .update({
                                                                        'title':
                                                                            titleEdc.text,
                                                                        'note':
                                                                            noteEdc.text,
                                                                        'timestamp':
                                                                            FieldValue.serverTimestamp(),
                                                                      });
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        const SnackBar(
                                                                            content:
                                                                                Text('Note berhasil diperbarui')),
                                                                      );
                                                                      Navigator.pop(
                                                                          context);
                                                                    } catch (e) {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                            content:
                                                                                Text('$e')),
                                                                      );
                                                                    }
                                                                  }
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'Save'),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            } else if (value == 'delete') {
                                              String documentId = document.id;
                                              _firestore
                                                  .collection('tasks')
                                                  .doc(documentId)
                                                  .delete();
                                            }
                                          },
                                          itemBuilder: (BuildContext context) =>
                                              [
                                            const PopupMenuItem<String>(
                                              value: 'edit',
                                              child: Text('Edit'),
                                            ),
                                            const PopupMenuItem<String>(
                                              value: 'delete',
                                              child: Text('Hapus'),
                                            ),
                                          ],
                                          child: Icon(Icons.more_vert_outlined),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    data['note'],
                                    textAlign: TextAlign.justify,
                                    maxLines: 5,
                                    style: const TextStyle(fontSize: 17.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          hintText: 'Title',
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      SizedBox(
                        height: 300,
                        child: TextFormField(
                          controller: noteController,
                          maxLines: null,
                          expands: true,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            hintText: 'Write a note',
                            filled: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  DocumentReference docRef =
                                      await _firestore.collection('tasks').add({
                                    'title': titleController.text,
                                    'note': noteController.text,
                                    'timestamp': FieldValue.serverTimestamp(),
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Artikel ditambahkan'),
                                    ),
                                  );
                                  Navigator.pop(context);
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('$e')),
                                  );
                                }
                              }
                            },
                            child: const Text('Save'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: const Color.fromRGBO(26, 77, 46, 1),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Resep',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
        currentIndex: 2, // Set the current index to Tips
        selectedItemColor: const Color.fromRGBO(26, 77, 46, 1),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}

class TipsTricksCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const TipsTricksCard({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        leading: Image.asset(imagePath), // Replace with your tip image
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.favorite_border),
      ),
    );
  }
}
