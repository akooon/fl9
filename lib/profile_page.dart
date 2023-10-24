import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';


class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      body: BlocProvider(
        create: (context) => ProfileBloc(),
        child: ProfileView(),
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(FetchProfileData());

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoaded) {
          return Center(child: Text('Title: ${state.title}'));
        } else if (state is ProfileError) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return Center(child: Text('Unknown state'));
        }
      },
    );
  }
}
