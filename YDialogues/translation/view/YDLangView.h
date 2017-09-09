//
//  YDLangView.h
//  YDialogues
//
//  Created by yxf on 2017/8/24.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YDLangViewType) {
    YDLangViewUnknown,
    YDLangViewFrom,
    YDLangViewTo
};

@class YDLangView;

@protocol YDLangViewDelegate <NSObject>

-(void)langViewChangeCountry:(YDLangView *)langView;

-(void)langViewSendMsg:(YDLangView *)langView;

@end

@interface YDLangView : UIView

/** lang*/
@property(nonatomic,assign)NSInteger lang;

/** type*/
@property(nonatomic,assign,readonly)YDLangViewType type;

/** delegate*/
@property(nonatomic,weak)id<YDLangViewDelegate> delegate;

+(instancetype)initWithType:(YDLangViewType)langType
                       lang:(NSInteger)lang;

@end
