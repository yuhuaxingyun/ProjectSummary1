
//
//  NextFileViewController.m
//  ThirdPartyLogin
//
//  Created by 宋江 on 16/3/7.
//  Copyright © 2016年 wt-vrs. All rights reserved.
//

#import "NextFileViewController.h"
#import "FileManagementViewController.h"
#import <QuickLook/QuickLook.h>
@interface NextFileViewController ()<UITableViewDataSource,UITableViewDelegate,UIDocumentInteractionControllerDelegate,QLPreviewControllerDataSource,QLPreviewControllerDelegate>
{
    NSFileManager *fileManager;
    NSMutableString *documentDir;
    NSArray *fileList;
    BOOL isdir;
    BOOL isDir;
    UITableView *_readTableView;
    NSString * curpath;
    NSString *_npath;
    NSString * nwpath;
    NSArray *fileListnext;
    NSMutableArray *_dirArray;
}
@property (nonatomic, strong) UIDocumentInteractionController *docInteractionController;
@end

@implementation NextFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@",[[_nextPath componentsSeparatedByString:@"/"] lastObject]];
    _readTableView = [[UITableView alloc]initWithFrame:[[UIScreen mainScreen]bounds] style:UITableViewStyleGrouped];
    _readTableView.dataSource =self;
    _readTableView.delegate =self;
    [self.view addSubview:_readTableView];
    
    fileManager = [NSFileManager defaultManager];
    //在这里获取应用程序Documents文件夹里的文件及文件夹列表
    
    if (!_nextPath) {
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSLog(@"%@",documentPaths);
        documentDir = [documentPaths objectAtIndex:0];
        NSLog(@"doc%@",documentDir);
        
    }else{
        
        documentDir = [NSMutableString stringWithFormat:@"%@",_nextPath];
        NSLog(@"npth%@",documentDir);
        
    }
    
    NSError *error = nil;
    fileList = [[NSArray alloc] init];
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    fileList = [fileManager contentsOfDirectoryAtPath:documentDir error:&error];
    NSLog(@"%@",fileList);
    
    for(int i = 0;i < fileList.count;i++){
        _nextPath = [NSString stringWithFormat:@"%@/%@",documentDir,fileList[i]];
        isdir = NO;
        [fileManager fileExistsAtPath:_nextPath isDirectory:&isdir];
        if (isdir){
            NSLog(@"%@是文件夹",fileList[i]);
        }else{
            NSLog(@"%@是文件",fileList[i]);
        }
    }
    
//    self.dirArray = [[NSMutableArray alloc] init];
//    for (NSString *file in fileList)
//    {
//        [self.dirArray addObject:file];
//    }

}
//step7. 利用url路径打开UIDocumentInteractionController
- (void)setupDocumentControllerWithURL:(NSURL *)url
{
    if (self.docInteractionController == nil)
    {
        self.docInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
        self.docInteractionController.delegate = self;
    }
    else
    {
        self.docInteractionController.URL = url;
    }
}
#pragma mark- 列表操作
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellName = @"CellName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellName];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellName];
        
    }
    
    
    NSURL *fileURL= nil;
    
    fileURL = [NSURL fileURLWithPath:_nextPath];
    
    [self setupDocumentControllerWithURL:fileURL];
    cell.textLabel.text = [fileList objectAtIndex:indexPath.row];
    NSInteger iconCount = [self.docInteractionController.icons count];
    if (iconCount > 0)
    {
        
        curpath = [fileList objectAtIndex:indexPath.row];
        nwpath = [NSString stringWithFormat:@"%@/%@",documentDir,curpath];
        isDir = NO;
        [fileManager fileExistsAtPath:nwpath isDirectory:&isDir];
        if (isDir){
            cell.imageView.image = [UIImage imageNamed:@"236_folderopen_16"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }else{
            cell.imageView.image = [UIImage imageNamed:@"word.png"];
        }
        
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [fileList count];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    curpath = [fileList objectAtIndex:indexPath.row];
    
    NSString * path = [NSString stringWithFormat:@"%@/%@",documentDir,curpath];
    isDir = NO;
    [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if (!isDir) {
        QLPreviewController *previewController = [[QLPreviewController alloc] init];
        previewController.dataSource = self;
        previewController.delegate = self;
        
        // start previewing the document at the current section index
        previewController.currentPreviewItemIndex = indexPath.row;
        [self presentViewController:previewController animated:YES completion:^{
            NSLog(@"打开word文档");
        }];
    }else{
        
        NSError *error;
        
        fileListnext = [fileManager contentsOfDirectoryAtPath:path error:&error];
        _dirArray = [[NSMutableArray alloc] init];
        for (NSString *file in fileListnext)
        {
            [_dirArray addObject:file];
        }
        
        if (_dirArray) {
            NSLog(@"--------%@",_dirArray);
            FileManagementViewController *fileManagementVC = [[FileManagementViewController alloc]init];
            fileManagementVC.dirArray = _dirArray;
            fileManagementVC.nPath = path;
            [self.navigationController pushViewController: fileManagementVC animated:YES];
        }
        
    }
    
}

#pragma mark - QLPreviewControllerDataSource
// Returns the number of items that the preview controller should preview
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)previewController
{
    return 1;
}

- (void)previewControllerDidDismiss:(QLPreviewController *)controller
{
    // if the preview dismissed (done button touched), use this method to post-process previews
}

// returns the item that the preview controller should preview
- (id)previewController:(QLPreviewController *)previewController previewItemAtIndex:(NSInteger)idx
{
    NSURL *fileURL = nil;
    NSIndexPath *selectedIndexPath = [_readTableView indexPathForSelectedRow];
    //    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    documentDir = [documentPaths objectAtIndex:0];
    NSString *path = [documentDir stringByAppendingPathComponent:[fileList objectAtIndex:selectedIndexPath.row]];
    fileURL = [NSURL fileURLWithPath:path];
    
    return fileURL;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
