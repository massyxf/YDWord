//
//  YDWindowView.h
//  YDialogues
//
//  Created by yxf on 2017/8/23.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDWindowView;

typedef NS_ENUM(NSInteger, YDTabClass) {
    YDTabClassNote = 0,
    YDTabClassTrans
};

@protocol YDWindowViewDelegate <NSObject>

-(void)windowView:(YDWindowView *)windowView selectIndex:(YDTabClass)index;

@end

@interface YDWindowView : UIView

+(instancetype)windowView;

/** delagete*/
@property(nonatomic,weak)id<YDWindowViewDelegate> delegate;

@end
