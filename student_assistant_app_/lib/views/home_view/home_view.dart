import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/home_viewmodel.dart';
///import '../../models/application.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch data when the screen loads
    Provider.of<HomeViewModel>(context, listen: false).fetchUserApplications();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Student Portal - Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Sign out logic using Supabase
            },
          ),
        ],
      ),
      body: viewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Your Applications',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.applications.length,
                    itemBuilder: (context, index) {
                      final app = viewModel.applications[index];
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text(app.position),
                          subtitle: Text('Submitted: ${app.dateSubmitted.toLocal()}'),
                          trailing: Chip(
                            label: Text(app.status),
                            backgroundColor: app.status == 'Approved' ? Colors.green[100] : Colors.orange[100],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to "Submit Application" screen
        },
        label: Text('New Application'),
        icon: Icon(Icons.add),
      ),
    );
  }
}