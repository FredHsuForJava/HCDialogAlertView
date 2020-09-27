# HCDialogAlertView

[![CI Status](https://img.shields.io/travis/xuwenfeng/HCDialogAlertView.svg?style=flat)](https://travis-ci.org/xuwenfeng/HCDialogAlertView)
[![Version](https://img.shields.io/cocoapods/v/HCDialogAlertView.svg?style=flat)](https://cocoapods.org/pods/HCDialogAlertView)
[![License](https://img.shields.io/cocoapods/l/HCDialogAlertView.svg?style=flat)](https://cocoapods.org/pods/HCDialogAlertView)
[![Platform](https://img.shields.io/cocoapods/p/HCDialogAlertView.svg?style=flat)](https://cocoapods.org/pods/HCDialogAlertView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

HCDialogAlertView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

pod 'HCDialogAlertView'
如果不能引入请使用下面方式引入
pod 'HCDialogAlertView',:git => 'https://github.com/FredHsuForJava/HCDialogAlertView.git'

## Author

xuwenfeng, xuwf@bsoft.com.cn

## License

HCDialogAlertView is available under the MIT license. See the LICENSE file for more info.
# HCAlertDialogHandler
支持富文本以及自定义view的弹出框

```objective-c
 NSString *content = @"\n您可阅读《服务协议》和《隐私政策》了解详细信息。如您同意，请点击“同意“开始接受我们的服务。";
    HCDialogAlertView*alert = [[HCDialogAlertView alloc]initWithTitle:self.copywriterTitle message:self.content canScroll:YES];
//普通文本 ，此block可以不用写
    alert.messageTapBlock = ^(NSString *url) {
        UIViewController *vc = [[UIViewController alloc] init];
        vc.showDismissItem = YES;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        if ([url containsString:@"service"]) {
            //服务协议
            vc.copywriterCode = UM_Privacy_Service;
        }else if ([url containsString:@"privacy"]){
            //隐私政策
             vc.copywriterCode = UM_Privacy_Privacy;
        }
          [self presentViewController:nav animated:YES completion:^{
          }];
    };
    [alert addButton:Button_CANCEL withTitle:@"暂不使用" handler:^(HCAlertDialogItem *item) {
    }];
    [alert addButton:Button_OK withTitle:@"同意" handler:^(HCAlertDialogItem *item) {
    }];
    [alert show];
```

