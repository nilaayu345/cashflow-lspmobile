import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final ImageProvider<Object> image;

  const MenuItem({
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: image,
          height: MediaQuery.sizeOf(context).height /
              6, // Ubah tinggi gambar sesuai kebutuhan
          width: MediaQuery.sizeOf(context).height /
              6, // Ubah lebar gambar sesuai kebutuhan
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
