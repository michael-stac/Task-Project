import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widget/shimmer_loader.dart';
import '../view_model/user_view_model.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => UserViewModel()..fetchUsers(),
        child: Consumer<UserViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(child: LoadingShimmerIndicator(context: context,));
            }

            if (viewModel.errorMessage != null) {
              return Center(child: Text(viewModel.errorMessage!));
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (query) {
                      context.read<UserViewModel>().searchUsers(query);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search users by name',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: viewModel.fetchUsers,
                    child: ListView.builder(
                      itemCount: viewModel.users.length,
                      itemBuilder: (context, index) {
                        final user = viewModel.users[index];
                        return ListTile(
                          title: Text(user.name),
                          subtitle: Text(user.email),
                          trailing: Text(user.username),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
