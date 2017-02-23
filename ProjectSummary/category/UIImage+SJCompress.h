//
//  UIImage+SJCompress.h
//  ProjectSummary
//
//  Created by baolicheng on 2017/2/17.
//  Copyright © 2017年 RenRenFenQi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>
@interface UIImage (SJCompress)
/**
 *  图片拉伸
 *
 *  @param name 图片名
 *
 */
+ (UIImage *)resizableImage:(NSString *)name;

/**
 *  图片压缩
 *
 *  @param asset
 *  @param size 压缩尺寸
 *
 */

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;

- (UIImage *)makeThumbnailFromImage:(UIImage *)srcImage scale:(double)imageScale;

/**
 *  颜色转换成图片
 *
 *  @param color
 */
+(UIImage*) createImageWithColor:(UIColor*) color;
@end
