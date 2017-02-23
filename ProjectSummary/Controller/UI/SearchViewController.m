//
//  SearchViewController.m
//  AllCodeDataNew
//
//  Created by 宋江 on 16/4/8.
//  Copyright © 2016年 宋江. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating>
{
    NSMutableDictionary *_allteams;
    NSMutableDictionary *_teams;
    NSArray *_teamsname;
    UISearchController *_searchConreoller;
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *tablePath = [[NSBundle mainBundle] pathForResource:@"searchData.plist" ofType:nil];
    _allteams = [[NSMutableDictionary alloc]initWithContentsOfFile:tablePath];
    
    _teams = [NSMutableDictionary dictionary];
    _teamsname = [[NSArray alloc]initWithArray:[_allteams allKeys]];
    _searchConreoller = [[UISearchController alloc]initWithSearchResultsController:nil];
    _searchConreoller.searchResultsUpdater = self;
    _searchConreoller.dimsBackgroundDuringPresentation = NO;
    [_searchConreoller.searchBar sizeToFit];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WEDTH, VIEW_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = _searchConreoller.searchBar;
    
    [self resetSearch];
}
- (void)resetSearch{
    _teams = _allteams;
    NSMutableArray *keysArray = [[NSMutableArray alloc]init];
    [keysArray addObjectsFromArray:[[_teams allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    _teamsname = keysArray;
    [_tableView reloadData];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _teamsname.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 10;
//}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_teamsname objectAtIndex:section];
}
//-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
//    return @"end";
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString *name = [_teamsname objectAtIndex:section];
    NSArray *team = [_teams objectForKey:name];
    return team.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *name = [_teamsname objectAtIndex:indexPath.section];
    NSArray *team = [_teams objectForKey:name];
    
    static NSString *fier = @"cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:fier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fier];
        cell.showsReorderControl =NO;  //我们添加一个重新排序控件
        
    }
    cell.textLabel.text = team[indexPath.row];
    
    return cell;
}
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _teamsname;
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchText = searchController.searchBar.text;
        if (searchText.length == 0) {
            [self resetSearch];
            return;
        }
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        for (NSString *key  in _allteams) {
            NSMutableArray *array = [_allteams valueForKey:key];
            NSMutableArray *newsTeams = [[NSMutableArray alloc]init];
            for (NSString *teamName  in array) {
                if ([teamName rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound) {
                    [newsTeams addObject:teamName];
                }
            }
            if (newsTeams.count > 0) {
                [dict setObject:newsTeams forKey:key];
            }
        }
        _teamsname = [[dict allKeys] sortedArrayUsingSelector:@selector(compare:)];
        _teams = dict;
        [_tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
