//
//  TextToPictureViewController.m
//  AllCodeDataNew
//
//  Created by 宋江 on 16/5/4.
//  Copyright © 2016年 宋江. All rights reserved.
//

#import "TextToPictureViewController.h"
#define CONTENT_MAX_WIDTH   300.0f
@interface TextToPictureViewController ()

@end

@implementation TextToPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEDTH, 300)];
    imageView.image = [TextToPictureViewController imageFromText:@[@"那就看你的什么你们那你的发哪了第三方力量的开始发了快速打开了",@"那就看你的什么你们那你的发哪了第三方力量的开始发了快速打开了",@"那就看你的什么你们那你的发哪了第三方力量的开始发了快速打开了",@"那就看你的什么你们那你的发哪了第三方力量的开始发了快速打开了"] withFont:12 withTextColor:[UIColor brownColor] withBgImage:[UIImage imageNamed:@"game.jpg"] withBgColor:[UIColor grayColor]];
    [self.view addSubview:imageView];
    
    
//    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//    [library writeImageToSavedPhotosAlbum:imageView.image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
//        NSLog(@"sss");
//    }];
    
}

+(UIImage *)imageFromText:(NSArray*)arrContent withFont:(CGFloat)fontSize withTextColor:(UIColor *)textColor withBgImage:(UIImage *)bgImage withBgColor:(UIColor *)bgColor
{
    // set the font type and size
    
    UIFont *font = [UIFont fontWithName:@"Heiti SC" size:fontSize];
    NSMutableArray *arrHeight = [[NSMutableArray alloc] initWithCapacity:arrContent.count];
    
    CGFloat fHeight = 0.0f;
    for (NSString *sContent in arrContent) {
        CGSize stringSize = [sContent sizeWithFont:font constrainedToSize:CGSizeMake(CONTENT_MAX_WIDTH, 10000) lineBreakMode:NSLineBreakByWordWrapping];
        [arrHeight addObject:[NSNumber numberWithFloat:stringSize.height]];
        
        fHeight += stringSize.height;
    }
    
    CGSize newSize = CGSizeMake(CONTENT_MAX_WIDTH+20, fHeight+50);
    
    
    // Create a stretchable image for the top of the background and draw it
    UIGraphicsBeginImageContextWithOptions(newSize,NO,0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    //如果设置了背景图片
    if(bgImage)
    {
        UIImage* stretchedTopImage = [bgImage stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        [stretchedTopImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    }else
    {
        if(bgColor)
        {
            //填充背景颜色
            [bgColor set];
            UIRectFill(CGRectMake(0, 0, newSize.width, newSize.height));
        }
    }
    
    CGContextSetCharacterSpacing(ctx, 10);
    CGContextSetTextDrawingMode (ctx, kCGTextFill);
    [textColor set];
    
    
    int nIndex = 0;
    CGFloat fPosY = 20.0f;
    for (NSString *sContent in arrContent) {
        NSNumber *numHeight = [arrHeight objectAtIndex:nIndex];
        CGRect rect = CGRectMake(10, fPosY, CONTENT_MAX_WIDTH , [numHeight floatValue]);
        
        
        [sContent drawInRect:rect withFont:font lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        fPosY += [numHeight floatValue];
        nIndex++;
    }
    
    // transfer image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
