//
//  VCAnimatedController.m
//  AllCodeDataNew
//
//  Created by 宋江 on 16/7/5.
//  Copyright © 2016年 宋江. All rights reserved.
//

#import "AnimatedViewController.h"
#import "ToAnimatedViewController.h"

@interface AnimatedViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation AnimatedViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = setItem;
    
    
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:[[UIScreen mainScreen]bounds] collectionViewLayout:collectionViewLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_collectionView registerClass:[AnimatedCell class] forCellWithReuseIdentifier:@"AnimatedCell"];
    [self.view addSubview:_collectionView];
}
- (void)back{
    //让自定义动画代理失效
    self.navigationController.delegate = nil;
    [self.navigationController popViewControllerAnimated:NO];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 40;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AnimatedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AnimatedCell" forIndexPath:indexPath];
    cell.imageView.image =[UIImage imageNamed:@"1"];
    return cell;
}
-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(60, 60);
}
- (UIEdgeInsets )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 10, 5, 10);
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedCell = (AnimatedCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    ToAnimatedViewController *toAnimatedVC = [[ToAnimatedViewController alloc]init];
    toAnimatedVC.image = self.selectedCell.imageView.image;
    self.navigationController.delegate = toAnimatedVC;
    
    [self.navigationController pushViewController:toAnimatedVC animated:YES];
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
