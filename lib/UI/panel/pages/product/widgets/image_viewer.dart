
import 'package:flutter/material.dart';

import '../../../../../urls/Urls.dart';


class ImageViewer extends StatefulWidget {
  const ImageViewer({super.key, required this.imgList});
  final List<String> imgList;
  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  int index=0;
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 4,
      child: Stack(
              children: [
                SizedBox(
                  width:MediaQuery.of(context).size.width,
                  child: PageView.builder(
                    itemCount: widget.imgList.length,
                      onPageChanged: (i){
                      index=i;
                      setState(() {

                      });
                      },
                    itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          // onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (c)=>ImageShower(url: "${Urls.baseImageUrl}/${widget.imgList[index]}"))),
                          child: Image(
                            image: NetworkImage("${AppUrls.baseImageUrl}/${widget.imgList[index]}"),
                            fit: BoxFit.cover,),
                        );

                  },
                      )
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      height: 30,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:widget.imgList.length ,
                          itemBuilder: (context,i)=>Row(
                            children: [
                              circle(index==i),
                            ],
                          )),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5,right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.redAccent
                    ),
                    child: IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.favorite_border_outlined,color: Colors.white,),
                    ),
                  ),
                )
              ],
            ),
    );
  }
  Widget circle(bool isBigCircle)
  {
    if(isBigCircle){
      return Container(
        margin: EdgeInsets.all(5),
        width: 20,
        height: 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white,width: 7)
        ),
      );
    }
    return  Container(
        margin: EdgeInsets.all(5),
        width: 15,
        height: 15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.5),
            border: Border.all(color: Colors.white38,width: 3)
        ),
      );

  }
}
