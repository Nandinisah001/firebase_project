import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_project/link_view/view_pages/product_details.dart';
import 'package:firebase_project/link_view/view_pages/share_link_gat.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      checkDynamicLink();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(
          Icons.shopping_bag,
          size: 50,
          color: Colors.green,
        ),
      ),
    );
  }

  Future<void> checkDynamicLink() async {
    try {
      FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
        print('Received dynamic link: ${dynamicLinkData.link}');
        handleDynamicLink(dynamicLinkData);
      }).onError((error) {
        print('onLinkError: ${error.message}');
      });


      final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
      if (initialLink != null && initialLink.link != null) {
        print('Initial dynamic link: ${initialLink.link}');
        handleDynamicLink(initialLink);
      } else {
        print('No initial dynamic link found');
        navigateToShareLinkGat();
      }
    } catch (e) {
      print('checkDynamicLinkError: $e');
      navigateToShareLinkGat();
    }
  }

  void handleDynamicLink(PendingDynamicLinkData data) {
    final Uri deepLink = data.link;
    final String? productId = deepLink.queryParameters['productId'];
    print('Deep link: $deepLink');
    print('Product ID: $productId');

    if (productId != null && productId.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetails(
            docId: productId,
            title: '',
            images: '',
            price: '',
            desc: '',
          ),
        ),
      );
    } else {
      navigateToShareLinkGat();
    }
  }

  void navigateToShareLinkGat() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => ShareLinkGat()),
      );
    });
  }
}
