import 'package:flutter/material.dart';
import 'package:github_finder/utils/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('asset/images/logo.png'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(24, 55, 32, 0),
        children: [
          Text(
            'Find users in Github',
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 11,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type the user name',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(
                    Icons.search,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          Text(
            'Searched users',
            style: TextStyle(
              fontSize: 26,
            ),
          ),
          SizedBox(height: 20),
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Image.network(
                        'https://avatars3.githubusercontent.com/u/47111228?s=460&u=2d077bf84376e754ef2ae90d879521f6d5a453ba&v=4',
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Felipe Passos',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
