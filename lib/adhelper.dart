// import 'dart:io';

// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class AdHelper {
//   // static String get bannerAdUnitId {
//   //   if (Platform.isAndroid) {
//   //     return 'ca-app-pub-3940256099942544/6300978111';
//   //   } else if (Platform.isIOS) {
//   //     return 'ca-app-pub-3940256099942544/2934735716';
//   //   } else {
//   //     throw new UnsupportedError('Unsupported platform');
//   //   }
//   // }

//   // static String get interstitialAdUnitId {
//   //   if (Platform.isAndroid) {
//   //     return "ca-app-pub-3940256099942544/1033173712";
//   //   } else if (Platform.isIOS) {
//   //     return "ca-app-pub-3940256099942544/4411468910";
//   //   } else {
//   //     throw new UnsupportedError("Unsupported platform");
//   //   }
//   // }

//   // static String get rewardedAdUnitId {
//   //   if (Platform.isAndroid) {
//   //     return "ca-app-pub-3940256099942544/5224354917";
//   //   } else if (Platform.isIOS) {
//   //     return "ca-app-pub-3940256099942544/1712485313";
//   //   } else {
//   //     throw new UnsupportedError("Unsupported platform");
//   //   }
//   // }

//   static String get appopen {
//     if (Platform.isAndroid) {
//       return "ca-app-pub-3940256099942544/3419835294";
//     } else if (Platform.isIOS) {
//       return "ca-app-pub-3940256099942544/1712485313";
//     } else {
//       throw new UnsupportedError("Unsupported platform");
//     }
//   }

//   static String get rewardedinterstitalAdUnitId {
//     if (Platform.isAndroid) {
//       return "ca-app-pub-3940256099942544/5354046379";
//     } else if (Platform.isIOS) {
//       return "ca-app-pub-3940256099942544/1712485313";
//     } else {
//       throw new UnsupportedError("Unsupported platform");
//     }
//   }

//   static String get nativeadunit {
//     if (Platform.isAndroid) {
//       return "ca-app-pub-3940256099942544/2247696110";
//     } else if (Platform.isIOS) {
//       return "ca-app-pub-3940256099942544/1712485313";
//     } else {
//       throw new UnsupportedError("Unsupported platform");
//     }
//   }
// }

// class showad {
//   RewardedInterstitialAd? rewardeInterstitialdAd;
//   void loadAd() {
//     RewardedInterstitialAd.load(
//         adUnitId: AdHelper.rewardedinterstitalAdUnitId,
//         request: const AdRequest(),
//         rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
//           // Called when an ad is successfully received.
//           onAdLoaded: (ad) {
//             print('$ad loaded.');
//             // Keep a reference to the ad so you can show it later.
//             var rewardedInterstitialAd = ad;
//           },
//           // Called when an ad request failed.
//           onAdFailedToLoad: (LoadAdError error) {
//             print('RewardedInterstitialAd failed to load: $error');
//           },
//         ));
//   }
// }
import 'dart:io';

import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdmanager {
  AppOpenAd? openAd;
  Future<void> loadAd() async {
    await AppOpenAd.load(
        adUnitId: 'ca-app-pub-2588803018465773/2685878322',
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (ad) {
          print('ad is loaded');
          openAd = ad;
          openAd!.show();
        }, onAdFailedToLoad: (error) {
          print('ad failed to load $error');
        }),
        orientation: AppOpenAd.orientationPortrait);
  }

  showAd() {
    if (openAd == null) {
      print('trying tto show before loading');
      loadAd();
      return;
    }

    openAd!.fullScreenContentCallback =
        FullScreenContentCallback(onAdShowedFullScreenContent: (ad) {
      print('onAdShowedFullScreenContent');
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      ad.dispose();
      print('failed to load $error');
      openAd = null;
      loadAd();
    }, onAdDismissedFullScreenContent: (ad) {
      ad.dispose();
      print('dismissed');
      openAd = null;
      loadAd();
    });

    openAd!.show();
  }
}

class rewardedInterstitialAd {
  RewardedInterstitialAd? _rewardedInterstitialAd;

  // TODO: replace this test ad unit with your own ad unit.
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-2588803018465773/9922919338'
      : 'ca-app-pub-3940256099942544/6978759866';

  /// Loads a rewarded ad.
  loadAd() async {
    await RewardedInterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            print('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _rewardedInterstitialAd = ad;
            _rewardedInterstitialAd!.show(
                onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
              // Reward the user for watching an ad.
            });
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedInterstitialAd failed to load: $error');
          },
        ));
  }
}

class rewardedad {
  RewardedAd? _rewardedAd;

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-2588803018465773/3780818900'
      : 'ca-app-pub-3940256099942544/1712485313';

  /// Loads a rewarded ad.
  void loadAd() {
    RewardedAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            print('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _rewardedAd = ad;
            _rewardedAd!.show(
                onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
              // Reward the user for watching an ad.
              print('downloaded');
            });
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
          },
        ));
  }
}

class interstitalad {
  InterstitialAd? interstitialAd;
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-2588803018465773/1067844861'
      : 'ca-app-pub-3940256099942544/4411468910';

  /// Loads an interstitial ad.
  loadAd() {
    InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            print('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            interstitialAd = ad;
            // interstitialAd!.show();
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }
}

class MyadController extends GetxController {
  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;
  final String adUnitId = "ca-app-pub-2588803018465773/5879511084";

  loadAd() {
    nativeAd = NativeAd(
        adUnitId: adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            isAdLoaded.value = true;
            print("Ad Loaded");
          },
          onAdFailedToLoad: (ad, error) {
            print('err is 2 as$error');
            isAdLoaded.value = false;
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle:
            NativeTemplateStyle(templateType: TemplateType.medium));
    nativeAd!.load();
  }
}

class MyadControllerforsearch extends GetxController {
  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;
  final String adUnitId = "ca-app-pub-2588803018465773/5879511084";

  loadAd() {
    nativeAd = NativeAd(
        adUnitId: adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            isAdLoaded.value = true;
            print("Ad Loaded");
          },
          onAdFailedToLoad: (ad, error) {
            print('err is 2 as$error');
            isAdLoaded.value = false;
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle:
            NativeTemplateStyle(templateType: TemplateType.medium));
    nativeAd!.load();
  }
}

class MyadControlleraftersearch extends GetxController {
  NativeAd? nativeAd;
  RxBool isAdLoaded = false.obs;
  final String adUnitId = "ca-app-pub-2588803018465773/5879511084";

  loadAd() {
    nativeAd = NativeAd(
        adUnitId: adUnitId,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            isAdLoaded.value = true;
            print("Ad Loaded");
          },
          onAdFailedToLoad: (ad, error) {
            print('err is 2 as$error');
            isAdLoaded.value = false;
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle:
            NativeTemplateStyle(templateType: TemplateType.small));
    nativeAd!.load();
  }
}
