 import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// События
abstract class ProfileEvent {}

class FetchProfileData extends ProfileEvent {}

// Состояния
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String title;

  ProfileLoaded(this.title);
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);
}

// BLoC
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is FetchProfileData) {
      yield ProfileInitial();
      try {
        final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final title = data['title'];
          yield ProfileLoaded(title);
        } else {
          yield ProfileError('Failed to load profile data');
        }
      } catch (e) {
        yield ProfileError('An error occurred');
      }
    }
  }
}
