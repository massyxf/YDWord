//
//  YDLangView.h
//  YDialogues
//
//  Created by yxf on 2017/8/24.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDLangView : UIView

/** lang*/
@property(nonatomic,assign)NSInteger lang;

+(instancetype)initWithTitle:(NSString *)title langBtnAction:(void(^)())langAction;

-(void)flagViewAddGesture:(UIGestureRecognizer *)gesture;

@end
