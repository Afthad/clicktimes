import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPostGrid extends StatefulWidget {
  final int itemcount;

  const ShimmerPostGrid({Key key, this.itemcount}) : super(key: key);
  @override
  _ShimmerPostGridState createState() => _ShimmerPostGridState();
}

class _ShimmerPostGridState extends State<ShimmerPostGrid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
    
       
      ),
                    itemBuilder: (_, __) => Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        height: 100,
                        //width: .3 * MediaQuery.of(context).size.width,
                        color: Colors.white,
                      ),
                    ),
                    itemCount: widget.itemcount,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
