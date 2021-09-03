//
//  ViewController.m
//  UICollection3DLayout
//
//  Created by facilityone on 2021/8/31.
//

#import "ViewController.h"
#import "XSWheelLayout.h"

#define ScrWidth [UIScreen mainScreen].bounds.size.width
#define ScrHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property(nonatomic,strong)UICollectionView *wheelCollection;

@end

@implementation ViewController

-(UICollectionView *)wheelCollection{
    if (!_wheelCollection) {
        XSWheelLayout *layout = [XSWheelLayout new];
        _wheelCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        _wheelCollection.backgroundColor=[UIColor greenColor];

    }
    return _wheelCollection;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.wheelCollection.frame = CGRectMake(0, 0, ScrWidth, ScrHeight);
    [self.view addSubview:self.wheelCollection];
    self.wheelCollection.delegate = self;
    self.wheelCollection.dataSource = self;
    self.wheelCollection.contentOffset = CGPointMake(0, ScrHeight);
    [self.wheelCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];

}

#pragma mark collectionView代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  
    return 10;
    

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    __weak typeof(self) weakSelf=self;

//    NSString *identifier=[NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
//    [self.wheelCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
//    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UICollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    UILabel *lab = [UILabel new];
    lab.text = [NSString stringWithFormat:@"滚轮%ld行",indexPath.row];
    lab.textColor = [UIColor blackColor];
    lab.frame = CGRectMake(20, 20, 150, 50);
    [cell.contentView addSubview:lab];

    return cell;

}



@end
