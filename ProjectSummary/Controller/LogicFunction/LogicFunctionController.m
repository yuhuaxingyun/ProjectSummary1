//
//  LogicFunctionController.m
//  ProjectSummary
//
//  Created by baolicheng on 2017/2/17.
//  Copyright © 2017年 RenRenFenQi. All rights reserved.
//

#import "LogicFunctionController.h"

@interface LogicFunctionController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIBarButtonItem *edit;
@property(nonatomic,strong)NSMutableArray *englishFamilyNames;
@property(nonatomic,strong)NSMutableArray *chinaFamilyNames;
@property(nonatomic,strong)UITableView *tableView;


@end

@implementation LogicFunctionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createBarItem];
    [self createUI];
    

}
- (void)createBarItem{
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithImageName:@"Back" target:self action:@selector(back)];
    
    self.navigationItem.leftBarButtonItem = backItem;
    self.edit = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editAction)];
    self.navigationItem.rightBarButtonItem = self.edit;
}
- (void)createUI{
    
    self.englishFamilyNames =[NSMutableArray arrayWithArray:[UIFont familyNames]];
     self.chinaFamilyNames = [NSMutableArray arrayWithArray:[self.englishFamilyNames mutableCopy]];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"英文显示全部字体样式和名字";
    }else{
        return @"中文显示全部字体样式和名字";
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
       return self.englishFamilyNames.count;
    }else{
        return self.chinaFamilyNames.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reture = @"cell";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reture];

    }
    if (indexPath.section == 0) {
        cell.textLabel.font = [UIFont fontWithName:self.englishFamilyNames[indexPath.row] size:14];
        cell.detailTextLabel.text = self.englishFamilyNames[indexPath.row];
        cell.textLabel.text = @"This is English";
       
    }else{
        cell.textLabel.font = [UIFont fontWithName:self.chinaFamilyNames[indexPath.row] size:14];
        cell.detailTextLabel.text = self.chinaFamilyNames[indexPath.row];
        cell.textLabel.text = @"这是中文";
    }
    
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//设置编辑风格EditingStyle
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView.editing) //----通过表视图是否处于编辑状态来选择是左滑删除，还是多选删除。
    {
        //当表视图处于没有未编辑状态时选择多选删除
        return UITableViewCellEditingStyleDelete| UITableViewCellEditingStyleInsert;
    }
    else
    {
        //当表视图处于没有未编辑状态时选择左滑删除
        return UITableViewCellEditingStyleDelete;
    }
    
}
//根据不同的editingstyle执行数据删除操作（点击左滑删除按钮的执行的方法）
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if (indexPath.section == 0) {
            [self.englishFamilyNames removeObjectAtIndex:indexPath.row];
        }else{
            [self.chinaFamilyNames removeObjectAtIndex:indexPath.row];
        }
        
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if(editingStyle == (UITableViewCellEditingStyleDelete| UITableViewCellEditingStyleInsert))
    {
        
    }
    
}
//修改左滑删除按钮的title
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"宋 删除";
}
- (void)editAction{

}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
