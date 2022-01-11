import 'package:flutter/material.dart';
import 'package:places/providers/places.dart';
import 'package:places/screens/add_place_screen.dart';
import 'package:places/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchAndSet(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<Places>(
                builder: (ctx, places, child) => places.items.length > 0
                    ? ListView.builder(
                        itemCount: places.items.length,
                        itemBuilder: (ctx, idx) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(places.items[idx].image),
                          ),
                          title: Text(places.items[idx].title),
                          subtitle: Text(places.items[idx].location.address),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              PlaceDetailScreen.routeName,
                              arguments: places.items[idx].id,
                            );
                          },
                        ),
                      )
                    : child,
                child: Center(
                  child: Text('Got no places yet, start adding some!'),
                ),
              ),
      ),
    );
  }
}
