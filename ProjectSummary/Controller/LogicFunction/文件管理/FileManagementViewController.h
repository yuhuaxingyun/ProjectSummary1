//
//  FileManagementViewController.h
//  ThirdPartyLogin
//
//  Created by 宋江 on 16/3/7.
//  Copyright © 2016年 wt-vrs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>
@interface FileManagementViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIDocumentInteractionControllerDelegate,QLPreviewControllerDataSource,QLPreviewControllerDelegate>
@property (nonatomic,strong)UITableView *readTable;
@property(nonatomic,retain) NSMutableArray *dirArray;
@property (nonatomic,copy)NSString *nPath;
@property (nonatomic, strong) UIDocumentInteractionController *docInteractionController;
@end
