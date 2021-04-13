//
//  WaterFallExampleViewController.m
//  YHWaterFallLayoutExample
//
//  Created by chenyehong on 2021/4/13.
//

#import "WaterFallExampleViewController.h"
#import "YHWaterFallLayout.h"
#import "WaterFallExampleReusableView.h"
#import "WaterFallExampleCell.h"
#import "WaterFallExampleData.h"
#import "WaterFallExampleItemView.h"

@interface WaterFallExampleViewController ()<YHWaterFallLayoutDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) YHWaterFallLayout *layout;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *modelList;
@property (strong, nonatomic) WaterFallExampleItemView *mesView;

@end

@implementation WaterFallExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"YHWaterFallLayoutExample";
    [self setupUI];
    [self requestData];
}

-(void)setupUI{
    YHWaterFallLayout *layout = [[YHWaterFallLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
    layout.delegate = self;
    _layout = layout;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [collectionView registerClass:[WaterFallExampleCell class] forCellWithReuseIdentifier:NSStringFromClass([WaterFallExampleCell class])];
    [collectionView registerClass:[WaterFallExampleReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([WaterFallExampleReusableView class])];
    [collectionView registerClass:[WaterFallExampleReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([WaterFallExampleReusableView class])];
    collectionView.backgroundColor = UIColor.whiteColor;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    WaterFallExampleItemView *mesView = [[WaterFallExampleItemView alloc] init];
    [mesView setHidden:YES];
    [self.view addSubview:mesView];
    _mesView = mesView;
}

-(void)requestData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        // Do something...
        sleep(0.2);//模拟数据请求
        NSMutableArray *modelList = [NSMutableArray array];
        for(int i = 0 ; i < 100 ; i++){
            WaterFallExampleData *data = [[WaterFallExampleData alloc] init];
            data.text = @"";
            NSInteger c = (arc4random() % 20) + 20;
            for(int j = 0 ; j < c ; j++){
                data.text = [data.text stringByAppendingString:@"water"];
            }
            data.text = [data.text stringByAppendingString:@"你好end"];
            [modelList addObject:data];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //核心代码，根据内容和固定宽度，计算每一个item的高度。计算高度的方式随意，但要准确
            //默认3列
            CGFloat colNum = 3;
            //计算每列有多宽
            CGFloat cellWidth = (self.collectionView.bounds.size.width - self.layout.sectionInset.left - self.layout.sectionInset.right - (self.layout.minimumInteritemSpacing * (colNum - 1))) / colNum;
            self.mesView.frame = CGRectMake(0, 0, cellWidth, CGFLOAT_MAX);
            //根据内容，计算高度
            [modelList enumerateObjectsUsingBlock:^(WaterFallExampleData  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CGSize size = [self.mesView setData:obj];
                obj.size = CGSizeMake(cellWidth, size.height);
            }];
            self.modelList = modelList;
            [self.collectionView reloadData];
        });
    });
}

#pragma mark - YHWaterFallLayoutDelegate, UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

//计算每一个header或footer的size
-(CGSize)yHWaterFallLayout:(YHWaterFallLayout *)layout sizeForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return CGSizeMake(400, 45);
    } else {
        return CGSizeMake(400, 45);
    }
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    WaterFallExampleReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([WaterFallExampleReusableView class]) forIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        header.lb.text = UICollectionElementKindSectionHeader;
    } else {
        header.lb.text = UICollectionElementKindSectionFooter;
    }
    return header;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.modelList.count;
}

-(CGSize)yHWaterFallLayout:(YHWaterFallLayout *)layout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterFallExampleData *model = [self.modelList objectAtIndex:indexPath.row];
    return model.size;
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterFallExampleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([WaterFallExampleCell class]) forIndexPath:indexPath];
    [cell.itemView setData:[self.modelList objectAtIndex:indexPath.row]];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
