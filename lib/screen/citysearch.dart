import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherFK/bloc/weather_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String selectedCity = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            // Handle close action
            Navigator.of(context).pop();
          },
                ),
        ),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Weather',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(3, -0.3),
              child: Container(
                height: 300, width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, -1.2),
              child: Container(
                height: 300, width: 600,
                decoration: const BoxDecoration(
                  //shape: BoxShape.circle,
                  color: Color(0xFFFFAB40),
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          style: const TextStyle(
                              color: Colors.white,
                            fontSize: 15,
                          ),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            labelText: 'Search for a city',
                            labelStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11.0),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11.0),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11.0),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                            focusedErrorBorder: InputBorder.none, // Prevent any error underline
                            errorBorder: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            suffixIcon: IconButton(icon: const Icon(Icons.search, color: Colors.white),
                              onPressed: ()async {
                                setState(() {
                                  isLoading = true;
                                });

                                selectedCity = _searchController.text;

                                if (selectedCity.isNotEmpty) {
                                  await Future.delayed(const Duration(seconds: 2));
                                  if (mounted) {
                                    Navigator.pop(context, selectedCity);
                                  }
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                            ),
                            suffixIconConstraints: const BoxConstraints(
                              minHeight: 0, // Ensure no extra space around the icon
                              minWidth: 0,),
                            ),
                        ),
                      ),

                    ],
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: ()async {
                    setState(() {
                      isLoading = true;
                    });

                    selectedCity = '1';

                    if (selectedCity.isNotEmpty) {
                      await Future.delayed(const Duration(seconds: 2));
                      if (mounted) {
                        Navigator.pop(context, selectedCity);
                      }
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.1),
                        borderRadius: BorderRadius.circular(20), // Adjust the border radius as needed
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 11, left: 20),
                        child: Text('My Location',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                if (isLoading)
                  const CircularProgressIndicator(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
