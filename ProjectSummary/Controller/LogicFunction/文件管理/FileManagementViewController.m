//
//  FileManagementViewController.m
//  ThirdPartyLogin
//
//  Created by 宋江 on 16/3/7.
//  Copyright © 2016年 wt-vrs. All rights reserved.
//

#import "FileManagementViewController.h"
#import "NextFileViewController.h"
@interface FileManagementViewController ()
{
    NSFileManager *fileManager;
    NSMutableString *documentDir;
    NSString * curpath;
    NSString * nwpath;
    NSArray *fileList;
    NSArray *fileListnext;
    BOOL isDir;
    BOOL isdir;
}
@end

@implementation FileManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBarItem];
    if (_nPath == nil) {
         self.title = @"文件管理";
    }else{
         self.title = [NSString stringWithFormat:@"%@",[[_nPath componentsSeparatedByString:@"/"] lastObject]];
    }
    self.readTable = [[UITableView alloc]initWithFrame:[[UIScreen mainScreen]bounds] style:UITableViewStyleGrouped];
    self.readTable.dataSource =self;
    self.readTable.delegate =self;
    [self.view addSubview:self.readTable];
    
    fileManager = [NSFileManager defaultManager];
    //在这里获取应用程序Documents文件夹里的文件及文件夹列表
    
    if (!_nPath) {
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSLog(@"%@",documentPaths);
        documentDir = [documentPaths objectAtIndex:0];
        NSLog(@"doc%@",documentDir);
        
    }else{
        
        documentDir = [NSMutableString stringWithFormat:@"%@",_nPath];
        NSLog(@"npth%@",documentDir);
        
    }
    
    NSError *error = nil;
    fileList = [[NSArray alloc] init];
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    fileList = [fileManager contentsOfDirectoryAtPath:documentDir error:&error];
    NSLog(@"%@",fileList);
    
    for(int i = 0;i < fileList.count;i++){
        _nPath = [NSString stringWithFormat:@"%@/%@",documentDir,fileList[i]];
        isdir = NO;
        [fileManager fileExistsAtPath:_nPath isDirectory:&isdir];
        if (isdir){
            NSLog(@"%@是文件夹",fileList[i]);
        }else{
            NSLog(@"%@是文件",fileList[i]);
        }
    }
    
    self.dirArray = [[NSMutableArray alloc] init];
    for (NSString *file in fileList)
    {
        [self.dirArray addObject:file];
    }

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
- (void)createBarItem{
    UIBarButtonItem *backBtnItem = [UIBarButtonItem itemWithImageName:@"Back" target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = backBtnItem;
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
    
    fileURL = [NSURL fileURLWithPath:_nPath];
    
    [self setupDocumentControllerWithURL:fileURL];
    cell.textLabel.text = [self.dirArray objectAtIndex:indexPath.row];
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
    return [self.dirArray count];
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
        NSLog(@"next%@",fileListnext);
        self.dirArray = [[NSMutableArray alloc] init];
        for (NSString *file in fileListnext)
        {
            [self.dirArray addObject:file];
        }
        
        if (_dirArray) {
            NSLog(@"--------%@",_dirArray);
            NextFileViewController *nextFileVC = [[NextFileViewController alloc]init];
            nextFileVC.dataArray = self.dirArray;
            nextFileVC.nextPath = path;
            [self.navigationController pushViewController: nextFileVC animated:YES];
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
    NSIndexPath *selectedIndexPath = [self.readTable indexPathForSelectedRow];
    //    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    documentDir = [documentPaths objectAtIndex:0];
    NSString *path = [documentDir stringByAppendingPathComponent:[self.dirArray objectAtIndex:selectedIndexPath.row]];
    fileURL = [NSURL fileURLWithPath:path];
    
    return fileURL;
}

- (void)loadDocument:(NSString *)documentName inView :(UIWebView *)webView{
    NSString *path = [[NSBundle mainBundle]pathForResource:documentName ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
