//
//  HCDialogAlertView.m
//  HCDialogAlertView
//
//  Created by 许文锋 on 2020/9/25.
//

#import "HCDialogAlertView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define AlertPadding 10
#define MenuHeight 44

#define AlertHeight 130
#define AlertWidth ([UIScreen mainScreen].bounds.size.width-60)

@implementation HCAlertDialogItem

@end

@implementation HCDialogAlertView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message{
    self = [super init];
    if (self) {
        _items = [[NSMutableArray alloc] init];
        _title  = title;
        _message = message;
        
        
        [self buildViews];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message canScroll:(BOOL)canScroll{
    _canScroll = canScroll;
    return [self initWithTitle:title message:message];
}
-(void)buildViews{
    self.frame = [UIScreen mainScreen].bounds;
     _coverView = [[UIView alloc]initWithFrame:self.frame];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0;

    [self addSubview:_coverView];
    _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, AlertWidth, AlertHeight)];
    _alertView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, AlertWidth, AlertHeight-MenuHeight)];
    _mainView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _mainView.layer.cornerRadius = 5;
    _mainView.layer.masksToBounds = YES;
    _mainView.backgroundColor = [UIColor whiteColor];
    [_mainView addSubview:_alertView];
    [self addSubview:_mainView];
  
    //title
    CGFloat labelHeigh = [self heightWithString:_title fontSize:17 width:AlertWidth-2*AlertPadding];
    _labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(AlertPadding, AlertPadding, AlertWidth-2*AlertPadding, labelHeigh)];
    _labelTitle.font = [UIFont boldSystemFontOfSize:17];
    _labelTitle.textColor = [UIColor blackColor];
    _labelTitle.textAlignment = NSTextAlignmentCenter;
    _labelTitle.numberOfLines = 0;
    _labelTitle.text = _title;
    _labelTitle.lineBreakMode = NSLineBreakByCharWrapping;
    [_alertView addSubview:_labelTitle];
    
    //message
    CGFloat messageHeigh = [self heightWithString:_message fontSize:14 width:AlertWidth-2*AlertPadding];

    if (self.canScroll) {
        _labelmessage =  [[TTTAttributedLabel alloc]initWithFrame:CGRectMake(AlertPadding, _labelTitle.frame.origin.y+_labelTitle.frame.size.height+2*AlertPadding, AlertWidth-2*AlertPadding, messageHeigh+2*AlertPadding)];
            _labelmessage.font = [UIFont systemFontOfSize:14];
        //    _labelmessage.textColor = [UIColor blackColor];
        
        _labelmessage.textColor = UIColorFromRGB(0x666666);
            _labelmessage.textAlignment = NSTextAlignmentLeft;
        //    _labelmessage.text = _message;
            _labelmessage.numberOfLines = 0;
            _labelmessage.lineBreakMode = NSLineBreakByCharWrapping;
            _labelmessage.enabledTextCheckingTypes = NSTextCheckingTypeLink;
            _labelmessage.lineSpacing = 5;
            _labelmessage.delegate = self; // Delegate
            NSRange boldRange1 = [_message rangeOfString:@"《服务协议》" options:NSCaseInsensitiveSearch];
            NSRange boldRange2 = [_message rangeOfString:@"《隐私政策》" options:NSCaseInsensitiveSearch];
            //改变链接的颜色
                NSMutableDictionary *linkAttributes = [NSMutableDictionary dictionary];
            //去掉下划线
                [linkAttributes setValue:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
            //改变链接文字的颜色
        
        
                [linkAttributes setValue:(__bridge id)UIColorFromRGB(0xfb9925).CGColor forKey:(NSString *)kCTForegroundColorAttributeName];
                _labelmessage.linkAttributes = linkAttributes;
        //    [_labelmessage setText:_message];
            [_labelmessage setText:_message afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {

                //设置可点击文本的颜色
                [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[UIColorFromRGB(0xfb9925) CGColor] range:boldRange1];
                 [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[UIColorFromRGB(0xfb9925) CGColor] range:boldRange2];
                 return mutableAttributedString;
            }];
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://service.com"]];
            NSURL *url2 = [NSURL URLWithString:[NSString stringWithFormat:@"http://privacy.com"]];
             //设置链接的url
            [_labelmessage addLinkToURL:url withRange:boldRange1];
            [_labelmessage addLinkToURL:url2 withRange:boldRange2];
            [_alertView addSubview:_labelmessage];
    }else{
        _labelmessage1 =  [[UILabel alloc]initWithFrame:CGRectMake(AlertPadding, _labelTitle.frame.origin.y+_labelTitle.frame.size.height, AlertWidth-2*AlertPadding, messageHeigh+2*AlertPadding)];
        _labelmessage1.font = [UIFont systemFontOfSize:14];
        //    _labelmessage.textColor = [UIColor blackColor];
        _labelmessage1.textColor = UIColorFromRGB(0x666666);
        _labelmessage1.textAlignment = NSTextAlignmentLeft;
        _labelmessage1.text = _message;
        _labelmessage1.numberOfLines = 0;
           [_alertView addSubview:_labelmessage1];
    }

    
    
    
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    if (!self.canScroll) {
            [_alertView addSubview:_contentScrollView];
    }

}
-(void)layoutSubviews{
    _buttonScrollView.frame = CGRectMake(0, _mainView.frame.size.height-MenuHeight,_mainView.frame.size.width, MenuHeight);
    _contentScrollView.frame = CGRectMake(0, _labelTitle.frame.origin.y+_labelTitle.frame.size.height, _mainView.frame.size.width, _mainView.frame.size.height-MenuHeight);
    self.contentView.frame = CGRectMake(0,0,self.contentView.frame.size.width, self.contentView.frame.size.height);
    _contentScrollView.contentSize = self.contentView.frame.size;

}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self addButtonItem];
    [_contentScrollView addSubview:self.contentView];
    CGFloat plus;
    if (self.contentView) {
        plus = self.contentView.frame.size.height-(_mainView.frame.size.height-MenuHeight);
    }else{
        if (self.canScroll) {
             plus = _labelmessage.frame.origin.y+_labelmessage.frame.size.height -(_mainView.frame.size.height-MenuHeight);
        }else{
             plus = _labelmessage1.frame.origin.y+_labelmessage1.frame.size.height -(_mainView.frame.size.height-MenuHeight);
        }
       
    }
   if (plus<0) {
        plus = 0;
    }
    CGFloat height =  MIN([UIScreen mainScreen].bounds.size.height-100,_mainView.frame.size.height+plus);
    CGFloat msgHeight = [self heightWithString:_message fontSize:14.0 width:AlertWidth];
    CGFloat mexHeight = MAX([UIScreen mainScreen].bounds.size.height-100,msgHeight);
    
    _mainView.frame = CGRectMake(_mainView.frame.origin.x, _mainView.frame.origin.y, AlertWidth, height);
    _alertView.frame = CGRectMake(0, 0, AlertWidth, height-MenuHeight);
    _mainView.center = self.center;
    [_alertView setContentSize:CGSizeMake(AlertWidth, mexHeight)];

    [self setNeedsDisplay];
    [self setNeedsLayout];

}
- (CGFloat)heightWithString:(NSString*)string fontSize:(CGFloat)fontSize width:(CGFloat)width
{
   
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    paragraphStyle.paragraphSpacing = 10;//段与段之间的间距
    paragraphStyle.paragraphSpacingBefore = 20.0f;//段首行空白空间/* Distance between the bottom of the previous
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle};
    if (!self.canScroll) {
             attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
       }
    return  [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.height;
}
#pragma mark - add item

- (NSInteger)addButtonWithTitle:(NSString *)title{
    HCAlertDialogItem *item = [[HCAlertDialogItem alloc] init];
    item.title = title;
//    item.action = nil;
    item.type = Button_OK;
    [_items addObject:item];
    return [_items indexOfObject:title];
}
- (void)addButton:(HCButtonType)type withTitle:(NSString *)title handler:(HCAlertDialogHandler)handler{
    HCAlertDialogItem *item = [[HCAlertDialogItem alloc] init];
    item.title = title;
    item.action = handler;
    item.type = type;
    [_items addObject:item];
    item.tag = [_items indexOfObject:item];
}
- (void)addButtonItem {
    _buttonScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _mainView.frame.size.height- MenuHeight,AlertWidth, MenuHeight)];
    _buttonScrollView.bounces = NO;
    _buttonScrollView.showsHorizontalScrollIndicator = NO;
    _buttonScrollView.showsVerticalScrollIndicator =  NO;
    CGFloat  width;
    if(self.buttonWidth){
        width = self.buttonWidth;
        _buttonScrollView.contentSize = CGSizeMake(width*[_items count], MenuHeight);
    }else
    {
       width = _alertView.frame.size.width/[_items count];
    }
    [_items enumerateObjectsUsingBlock:^(HCAlertDialogItem *item, NSUInteger idx, BOOL *stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.translatesAutoresizingMaskIntoConstraints = YES;
        button.frame = CGRectMake(idx*width, 1, width, MenuHeight);
        //seperator
        button.backgroundColor = [UIColor whiteColor];
        button.layer.shadowColor = [[UIColor grayColor] CGColor];
        button.layer.shadowRadius = 0.5;
        button.layer.shadowOpacity = 1;
        button.layer.shadowOffset = CGSizeZero;
        button.layer.masksToBounds = NO;
        button.tag = 90000+ idx;
        // title
        [button setTitle:item.title forState:UIControlStateNormal];
        [button setTitle:item.title forState:UIControlStateSelected];
        
        [button setTitleColor:UIColorFromRGB(0x35b46f) forState:UIControlStateNormal];
//        button.titleLabel.font = [UIFont boldSystemFontOfSize:button.titleLabel.font.pointSize];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        // action
        [button addTarget:self
                    action:@selector(buttonTouched:)
          forControlEvents:UIControlEventTouchUpInside];

        [_buttonScrollView addSubview:button];
    }];
    [_mainView addSubview:_buttonScrollView];
    
}

- (void)buttonColor:(UIColor *)color{
    
    [_items enumerateObjectsUsingBlock:^(HCAlertDialogItem *item, NSUInteger idx, BOOL *stop) {
        NSInteger tag= 90000+ idx;
        UIButton *button = [_buttonScrollView viewWithTag:tag];
        [button setTitleColor:color forState:UIControlStateNormal];
    }];
}

- (void)buttonTouched:(UIButton*)button{
    HCAlertDialogItem *item = _items[button.tag-90000];
    if (item.action) {
        item.action(item);
    }
    if (item.type == Button_NoDismiss) {
        
    }else{
        [self dismiss];
    }
    
}
#pragma mark - show and dismiss

- (void)show {
    [UIView animateWithDuration:0.5 animations:^{
        self->_coverView.alpha = 0.5;

    } completion:^(BOOL finished) {
        
    }];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    UIView *topView = window.subviews[0];
//    [topView addSubview:self];
    [window addSubview:self];
    [self showAnimation];
}

- (void)dismiss {
    [self hideAnimation];
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (!self.canScroll) {
        [self removeFromSuperview];
    }
}

- (void)showAnimation {
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [_mainView.layer addAnimation:popAnimation forKey:nil];
}

- (void)hideAnimation{
    [UIView animateWithDuration:0.4 animations:^{
        self->_coverView.alpha = 0.0;
        self->_mainView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
         [self removeFromSuperview];
    }];

    
}

#pragma mark - TTAttributeLabel Delegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url{
    //点击健康档案跳转---
    if (self.messageTapBlock) {
        self.messageTapBlock(url.absoluteString);
    }
}

@end
