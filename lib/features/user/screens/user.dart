import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userapp/utils/appColors.dart';
import '../../../widget/shimmer_loader.dart';
import '../view_model/user_view_model.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User', style: TextStyle(fontSize: 18, color: AppColor.onboard),),
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
                      hintStyle: TextStyle(
                        color: Colors.grey, // Hint text color
                        fontSize: 16,       // Hint text size
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10), // Rounded border
                        borderSide: BorderSide(
                          color: Colors.blue, // Border color
                          width: 2,           // Border width
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey, // Border color when not focused
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blue, // Border color when focused
                          width: 2,
                        ),
                      ),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.blue, // Icon color
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ), // Padding inside the text field
                    ),
                    style: TextStyle(
                      fontSize: 16,        // Input text size
                      color: Colors.black, // Input text color
                    ),
                    cursorColor: Colors.blue, // Cursor color
                  ),
                ),
                SizedBox(height: 9,),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: viewModel.fetchUsers,
                    child: ListView.builder(
                      itemCount: viewModel.users.length,
                      itemBuilder: (context, index) {
                        final user = viewModel.users[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12,),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColor.primaryColor),
                            ),
                            margin: EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(color: Color(0xffF2EFFF)),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              trailing:  Text(
                                user.username,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff6361D9),
                                  fontFamily: 'SF Pro Display',
                                ),
                              ),
                              title: Text(
                                user.name.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                user.email.toString(),
                              ),

                            ),

                          ),
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
