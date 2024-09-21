import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icthub_2024_9/features/more/cubit/profile_cubit.dart';
import 'package:icthub_2024_9/features/more/cubit/profile_states.dart';
import 'package:icthub_2024_9/features/more/ui/widgets/card_info_user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More'),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileLoaded) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CardInfoUser(text: state.user.name),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'phone',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CardInfoUser(text: state.user.phone.toString()),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'email',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CardInfoUser(text: state.user.email),
                ],
              ),
            );
          } else if (state is ProfileErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is ProfileErrorUserNotFound) {
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/signuplogo.svg',
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'user name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'user name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                          backgroundColor: Colors.teal,
                          disabledBackgroundColor: Colors.black26,
                          foregroundColor: Colors.white,
                          disabledForegroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<ProfileCubit>().upDateUserData(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                          }
                        },
                        child: const Text('Update Profile'),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('An error occurred'),
            );
          }
        },
      ),
    );
  }
}
