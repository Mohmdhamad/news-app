import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:news/modules/web_view/web_view.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double radius = 15.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
      ),
    );


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefix,
  required String? Function(String?) validate,
  Function(String)? onChange,
  Function(String)? onSubmit,
  VoidCallback? onTap ,
  IconData? suffix,
  Function? suffixPressed,
  bool isPassword = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: () {
            if (suffixPressed != null) suffixPressed();
          },
          icon: Icon(suffix),
        )
            : null,
        border: OutlineInputBorder(),
      ),
      onChanged: onChange,
      onTap:onTap,
      onFieldSubmitted: onSubmit,
      validator: validate,
    );

Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 30.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.3,
    color: Colors.grey[300],
  ),
);
Widget buildArticleItem(article,context)=>InkWell(
  onTap:(){
    navigateTo(context, WebViewScreen(article['url']));
  },

  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          height: 120.0,
          width: 120.0,
          decoration: BoxDecoration(
            borderRadius : BorderRadius.circular(10.0,),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage('${article['urlToImage']??'https://cdn.corporatefinanceinstitute.com/assets/marketing.jpeg'}',
              ),
            ),
          ),
  
        ),
        SizedBox(width: 20.0,),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    maxLines: 3,
                    overflow:TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(height: 7.0,),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget articleBuilder(list,context,{isSearch = false})=> ConditionalBuilder(
  condition: list.length > 0,
  builder: (context)=>ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context,index)=>buildArticleItem(list[index],context),
    separatorBuilder: (context,index)=>myDivider(),
    itemCount: 15,
  ),
  fallback: (context)=>isSearch ?Container():Center(child: CircularProgressIndicator()),
);

void navigateTo(context,widget)=>Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);