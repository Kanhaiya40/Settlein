import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settelin/api/services/author_service.dart';
import 'package:settelin/models/author_response.dart';
import 'package:settelin/widget/widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var screenWidth;
  var screenHeight;
  late bool _isFav;
  late AuthorProvider _authorProvider;
  late List<Author> _authors=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isFav = false;
    _authorProvider=AuthorProvider();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Author>>(
          future: _getAuthorData(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListView(
                physics: const BouncingScrollPhysics(),
                primary: true,
                children: [
                  SizedBox(
                    height: screenHeight / 5,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildStatusBar(index,snapshot.data![index]);
                      },
                    ),
                  ),
                  getHeightSpace(),
                  Row(
                    children: [
                      CircleAvatar(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage("assets/images/profile.jpeg"))),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18.0,
                            ),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                                  border: Border.all(color: Colors.grey, width: 0.1)),
                              child: TextFormField(
                                autovalidateMode: AutovalidateMode.always,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 20.0, right: 20, top: 10, bottom: 15),
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                                  hintText: 'What do you think?',
                                ),
                              ),
                            ),
                          )),
                      CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        child: const Icon(Icons.copy,color: Colors.grey,size: 15,),
                      )
                    ],
                  ),
                  getHeightSpace(),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildAuthorPostLayout(snapshot.data![index]);
                    },
                  )
                ],
              );
            }
              return const Center(child: CircularProgressIndicator());
          }
        ),
      ),
    );
  }

  Widget buildAuthorPostLayout(Author author) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              child: Container(
                decoration:  BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(author.downloadUrl!)),
              ),
            ),),
            getWidthSpace(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(author.author!,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                  Row(
                    children: [
                       Text(
                         int.parse(author.id!)%2==0?
                        "45 min":"30 min",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                      getWidthSpace(),
                      Container(
                        height: 5,
                        width: 5,
                        decoration: const BoxDecoration(
                            color: Colors.grey, shape: BoxShape.circle),
                      ),
                      getWidthSpace(),
                      const Icon(
                        Icons.group,
                        color: Colors.grey,
                        size: 15,
                      ),
                    ],
                  )
                ],
              ),
            ),
            IconButton(
              icon: _isFav
                  ? const Icon(Icons.favorite, color: Colors.red)
                  : const Icon(Icons.favorite_outline_sharp),
              onPressed: () {
                setState(() {
                  if (_isFav) {
                    _isFav = !_isFav;
                  }
                });
              },
            )
          ],
        ),
        getHeightSpace(),
        Container(
          height: screenHeight / 3,
          width: screenWidth,
          decoration:  BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                  image: NetworkImage(author.downloadUrl!),
              fit: BoxFit.cover)),
        ),
        getHeightSpace(),
        Row(
          children: [
            CircleAvatar(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("assets/images/profile.jpeg"))),
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                  ),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(30)),
                        border: Border.all(color: Colors.grey, width: 0.1)),
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.always,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                        contentPadding: EdgeInsets.only(
                            left: 20.0, right: 20, top: 10, bottom: 15),
                        border: InputBorder.none,
                        hintText: 'Say something',
                      ),
                    ),
                  ),
                )),
            CircleAvatar(
              backgroundColor: Colors.grey[100],
              child: const Icon(Icons.share,color: Colors.grey,size: 15,),
            )
          ],
        ),
        getHeightSpace(),
      ],
    );
  }

  Widget buildStatusBar(int index, Author author) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: index == 0
          ? Stack(
              children: [
                Center(
                  child: Container(
                    height: screenHeight / 5,
                    width: screenWidth / 3.5,
                    decoration:  const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      image: DecorationImage(
                          image: AssetImage("assets/images/profile.jpeg"),
                          fit: BoxFit.cover),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.20),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                  ),
                ),
                const Positioned.fill(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Center(
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.add)),
                      )),
                ),
              ],
            )
          : Stack(
              children: [
                Center(
                    child: Container(
                      height: screenHeight / 5,
                      width: screenWidth / 3.5,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 2),
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        image: DecorationImage(image: NetworkImage(author.downloadUrl!),fit: BoxFit.cover)
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.12),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                  ),
                 Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      author.author!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
    );
  }
  Future<List<Author>> _getAuthorData() async {
    return (await _authorProvider.getAuthorApiResponse())!;
  }
}
