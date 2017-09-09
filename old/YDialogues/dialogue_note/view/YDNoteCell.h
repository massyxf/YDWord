//
//  YDNoteCell.h
//  YDialogues
//
//  Created by yxf on 2017/6/8.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import <UIKit/UIKit.h>
#define YDNoteCellIdentifier @"YDNoteCellIdentifier"

@class YDNoteModel;

@interface YDNoteCell : UITableViewCell

/*model*/
@property (nonatomic,strong)YDNoteModel *noteModel;

@end

