//
//  HCDialogAlertView.h
//  HCDialogAlertView
//
//  Created by 许文锋 on 2020/9/25.
//

#import <UIKit/UIKit.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum HCButtonType
{
    Button_OK,
    Button_CANCEL,
    Button_OTHER,
    Button_NoDismiss
    
}HCButtonType;

@class HCAlertDialogItem;
typedef void(^HCAlertDialogHandler)(HCAlertDialogItem *item);

typedef void(^HCAlertMessageTapHandler)(NSString *url);

@interface HCDialogAlertView : UIView<TTTAttributedLabelDelegate>
{
    UIView *_coverView;
    UIScrollView *_alertView;
    UIView *_mainView;
    UILabel *_labelTitle;
//    UILabel *_labelmessage1;
    
    UIScrollView *_buttonScrollView;
    UIScrollView *_contentScrollView;
    
    NSMutableArray *_items;
    NSString *_title;
    NSString *_message;

}
//按钮宽度,如果赋值,菜单按钮宽之和,超过alert宽,菜单会滚动
@property(assign,nonatomic) CGFloat buttonWidth;
//将要显示在alert上的自定义view
@property(strong,nonatomic) UIView *contentView;

@property(assign,nonatomic) BOOL canScroll;

@property(strong,nonatomic) UILabel *labelmessage1;

@property(strong,nonatomic)  TTTAttributedLabel *labelmessage;

@property (nonatomic, copy) HCAlertMessageTapHandler messageTapBlock;


- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message canScroll:(BOOL)canScroll;
- (NSInteger)addButtonWithTitle:(NSString *)title;
- (void)addButton:(HCButtonType)type withTitle:(NSString *)title handler:(HCAlertDialogHandler)handler;
- (void)show;
- (void)dismiss;

- (void)buttonColor:(UIColor *)color;

@end

@interface HCAlertDialogItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic) HCButtonType type;
@property (nonatomic) NSUInteger tag;
@property (nonatomic, copy) HCAlertDialogHandler action;
@end

NS_ASSUME_NONNULL_END
