//
//  XSWheelLayout.m
//  UICollection3DLayout
//
//  Created by facilityone on 2021/9/3.
//

#import "XSWheelLayout.h"

@interface XSWheelLayout()

@end

@implementation XSWheelLayout

-(NSArray <UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *attbutes = [NSMutableArray array];
    for (NSInteger i=0; i<[self.collectionView numberOfItemsInSection:0]; i++) {
        [attbutes addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
    return attbutes;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attbute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    attbute.size = CGSizeMake(260, 100);
    
    //中心点
    attbute.center = CGPointMake(self.collectionView.frame.size.width/2, self.collectionView.frame.size.height/2+self.collectionView.contentOffset.y);
    
    float conffsety = self.collectionView.contentOffset.y;
    
    float anagleOffset = conffsety/self.collectionView.frame.size.height;
    
    //CATransform3DIdentity创建空得矩阵
    CATransform3D trans3D = CATransform3DIdentity;
    //这个值设置的是透视度，影响视觉离投影平面的距离
    trans3D.m34 = -1/900.0;
    //下面这些属性 后面会具体介绍
    //这个是3D滚轮的半径
    CGFloat radius = 50/tanf(M_PI*2/items/2);
    //计算每个item应该旋转的角度
    CGFloat angle = (float)(indexPath.row+anagleOffset)/items*M_PI*2;
    //这个方法返回一个新的CATransform3D对象，在原来的基础上进行旋转效果的追加
    //第一个参数为旋转的弧度，后三个分别对应x，y，z轴，我们需要以x轴进行旋转
    trans3D = CATransform3DRotate(trans3D, angle, 1.0, 0, 0);
    trans3D = CATransform3DTranslate(trans3D, 0, 0, radius);
    //进行设置
    attbute.transform3D = trans3D;

    return attbute;
}


-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

//滑动范围
-(CGSize)collectionViewContentSize{
    return  CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height*([self.collectionView numberOfItemsInSection:0]));
}


@end
