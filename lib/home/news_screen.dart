import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/home/cubit/cubit.dart';
import 'package:news/home/cubit/state.dart';
import '../Screens/tabs.dart';
import '../model/categoryModel.dart';

class NewsScreen extends StatelessWidget {
  CategoryModel categoryModel;
  String query;
  static const String routeName = "NewsScreen";

  NewsScreen(
    this.categoryModel,
    this.query,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getSources(categoryModel.id),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeGetNewsLoadingState ||
              state is HomeGetSourceLoadingState) {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
          } else if (state is HomeGetSourceSuccessState) {
            HomeCubit.get(context).getData();
          } else if (state is HomeGetSourceErrorState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: Text(state.error),
                );
              },
            );
          } else if (state is HomeGetNewsSuccessState) {
            Navigator.pop(context);

          }  else if (state is HomeChangeSource) {
            HomeCubit.get(context).getData();
          }


          else if (state is HomeGetNewsErrorState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: Text(state.error),
                );
              },
            );
          }
        },
        builder: (context, state) {
          if (state is HomeGetSourceSuccessState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return tabsScreen(HomeCubit.get(context).sources, query);
          }
        },
      ),
    );
    //   FutureBuilder(
    //   future: ApiMngment.getSources(categoryModel.id),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(child: CircularProgressIndicator());
    //     }
    //
    //     if (snapshot.hasError) {
    //       return Column(
    //         children: [
    //           const Text("Something went wrong"),
    //           TextButton(
    //             onPressed: () {},
    //             child: const Text("Try Again"),
    //           )
    //         ],
    //       );
    //     }
    //
    //     if (snapshot.data?.status != "ok") {
    //       return Column(
    //         children: [
    //           const Text("Error ..!!"),
    //           TextButton(
    //             onPressed: () {},
    //             child: const Text("Try Again"),
    //           )
    //         ],
    //       );
    //     }
    //     var sources = snapshot.data?.sources ?? [];
    //     return tabsScreen(sources,query);
    //   },
    // );
  }
}
