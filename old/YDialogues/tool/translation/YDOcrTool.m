//
//  YDOcrTool.m
//  YDialogues
//
//  Created by yxf on 2017/8/21.
//  Copyright © 2017年 yxf. All rights reserved.
//

#import "YDOcrTool.h"
#import "YDNetServerManager.h"
#import "YDYoudaoConfig.h"
#import "NSString+Hashes.h"

@implementation YDOcrTool

+(void)transPic:(UIImage *)image completion:(YDTransCompletion)completion{
    YDYoudaoConfig *config = [YDYoudaoConfig initForTrans:NO];
    
    NSString *img64Str = [self image2DataURL:image];
    
    NSNumber *salt = @((NSInteger)[[NSDate date] timeIntervalSince1970]);
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"img"] = img64Str;
    params[@"langType"] = [self langTypeForEn:NO];
    params[@"imgType"] = @"Base64";
    params[@"appKey"] = config.youdaoId;
    params[@"salt"] = salt;
    params[@"sign"] = [NSString stringWithFormat:@"%@%@%@%@",config.youdaoId,img64Str,salt,config.youdaokey].md5.uppercaseString;
    params[@"docType"] = @"json";
    
    [YDNetServerManager transTextWithUrl:config.youdaoHost
                                  params:params
                              completion:^(id result, NSError *error) {
                                  NSLog(@"result:%@,error:%@",result,error);
                              }];
    
}

+(NSString *)langTypeForEn:(BOOL)en{
    return en ? @"en" : @"zh-en";
}

//将图片转为base64编码字符串
+(NSString *)image2DataURL:(UIImage *)image {
    NSData *imageData = nil;
    
    //注意：1.图片最长宽不能超过768
    if (image.size.width > 768 || image.size.height > 768) {
        CGSize newSize;
        if (image.size.width > image.size.height) {
            newSize = CGSizeMake(768, image.size.height / image.size.width * 768);
        }else {
            newSize = CGSizeMake(image.size.width / image.size.height * 768, 768);
        }
        image = [self imageWithImage:image scaledToSize:newSize];
    }
    
    //注意：2.imageData压缩后不能超过1.5MB
    CGFloat imageDataSize = 0, compressionQuality = 0.9;
    do {
        imageData = UIImageJPEGRepresentation(image, compressionQuality);
        imageDataSize = imageData.length / 1024;
        compressionQuality = compressionQuality * 0.5;
    } while (imageDataSize > 1.5 * 1024);
    
    return [imageData base64EncodedStringWithOptions:0];
}

+ (UIImage *)imageWithImage:(UIImage*)image
               scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
