import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lite_jobs/features/auth/presentation/bloc/auth_bloc.dart';

class SignUpImageSection extends StatelessWidget {
  const SignUpImageSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          context.read<AuthBloc>().add(SignUpImageFetching());
        },
        child: Card(
          elevation: 5,
          color: Colors.white54,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white54),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(13)),
              height: 85,
              width: 100,
              child: BlocBuilder<AuthBloc, AuthBlocState>(
                builder: (context, state) {
                  if (state is SignUpInitial) {
                    return Image.asset("assets/images/add_image.png");
                  }
                  if (state is SignUpImageLoadingState) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Color(0xFFE5AA17),
                    ));
                  }
                  if (state is SignUpImageFetchedState ||
                      state is SignUpFailedState) {
                    final Uint8List? image;
                    if (state is SignUpImageFetchedState) {
                      image = state.image;
                    } else if (state is SignUpFailedState) {
                      image = state.file;
                    } else {
                      image = null;
                    }
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.memory(height: 85, fit: BoxFit.cover, image!),
                          Positioned(
                            bottom: -5,
                            right: -5,
                            child: CircleAvatar(
                              child: Center(
                                child: IconButton(
                                    onPressed: () {
                                      context.read<AuthBloc>().add(
                                          SignUpImageFetching(image: image));
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 18,
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return Image.asset("assets/images/add_image.png");
                },
              )),
        ),
      ),
    );
  }
}
