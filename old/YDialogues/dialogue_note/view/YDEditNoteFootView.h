//
//  YDEditNoteFootView.h
//  YDialogues
//
//  Created by yxf on 2017/8/17.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YDNoteWordModel;
@class YDEditNoteFootView;

@protocol YDEditNoteFootViewDelegate <NSObject>

-(void)editnoteFootview:(YDEditNoteFootView *)footview addWordModel:(YDNoteWordModel *)wordModel;

@end

@interface YDEditNoteFootView : UIView

/** delegate*/
@property(nonatomic,weak)id<YDEditNoteFootViewDelegate> delegate;

@end
