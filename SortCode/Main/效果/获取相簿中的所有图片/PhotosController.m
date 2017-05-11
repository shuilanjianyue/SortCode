//
//  PhotosController.m
//  整理文
//
//  Created by dazaoqiancheng on 17/3/3.
//  Copyright © 2017年 DZQC. All rights reserved.
//

#import "PhotosController.h"
#import "AllPhotosController.h"
#import <Photos/Photos.h>

@interface PhotosController ()<UITableViewDataSource,UITableViewDelegate>
{
    int albumNumber;
    
}

@property(nonatomic,strong)UITableView *myTableView;


//所有的相簿组
@property(nonatomic,strong)NSMutableArray *photosArray;

//所有图片的缩略图
@property(nonatomic,strong)NSMutableDictionary *allPhotosDic;

//所有图片的PHAsset类
@property(nonatomic,strong)NSMutableDictionary *allPhotosAsset;

@end

@implementation PhotosController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar.titleLabel.text = @"获取所有的图片项目组";
    
    self.photosArray = [NSMutableArray array];
    
    
    self.allPhotosDic = [NSMutableDictionary dictionary];
    
    self.allPhotosAsset = [NSMutableDictionary dictionary];
    
    
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    //去掉背景色
    self.myTableView.backgroundView = nil;
    self.myTableView.rowHeight=60;
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.myTableView.backgroundColor=[UIColor clearColor];
    [self.view addSubview:self.myTableView];

    albumNumber = 0;
    
    //[self getOriginalImages];
    
    [self getThumbnailImages];
    
    // Do any additional setup after loading the view.
}


#pragma mark - 获得所有相簿中的原图
- (void)getOriginalImages
{
    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    
    // 遍历所有的自定义相簿
    for (PHAssetCollection *assetCollection in assetCollections) {
        
        [self enumerateAssetsInAssetCollection:assetCollection original:YES];
    }
    
    
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    
    
    // 遍历相机胶卷,获取大图
    [self enumerateAssetsInAssetCollection:cameraRoll original:YES];
}


#pragma mark - 获得所有相簿中的缩略图
- (void)getThumbnailImages
{
    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历所有的自定义相簿
    for (PHAssetCollection *assetCollection in assetCollections) {
        [self enumerateAssetsInAssetCollection:assetCollection original:NO];
    }
    
    
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    
    [self enumerateAssetsInAssetCollection:cameraRoll original:NO];
    
    
}


/**
 *  遍历相簿中的所有图片
 *  @param assetCollection 相簿
 *  @param original        是否要原图
 */


- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original
{
    NSLog(@"相簿名:%@", assetCollection.localizedTitle);
    

    albumNumber = albumNumber + 1;
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    NSMutableArray *tempArray2 = [NSMutableArray array];
    
    for (PHAsset *asset in assets) {
        // 是否要原图
        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
        
        //从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            
            
            NSLog(@"%@", result);
            
            NSLog(@"%@",info);
            
            [tempArray addObject:result];
            [tempArray2 addObject:asset];
            
            
        }];
        
    }
    
    
    
    [self.allPhotosDic setValue:tempArray forKey:[NSString stringWithFormat:@"%d",albumNumber]];
    
    
    
     [self.allPhotosAsset setValue:tempArray2 forKey:[NSString stringWithFormat:@"%d",albumNumber]];
    
    if(!assetCollection.localizedTitle){
        [self.photosArray addObject:@"未命名"];
    }else{
        [self.photosArray addObject:assetCollection.localizedTitle];
    }
    
    
    
    
    NSLog(@"%@",self.allPhotosDic);
    
    
    [self.myTableView reloadData];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.photosArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifer = @"PhotosCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
    }
    
    
    
    UIImage *imagePhoto = [[self.allPhotosDic objectForKey:[NSString stringWithFormat:@"%d",(int)indexPath.row + 1]] objectAtIndex:0];
    
    NSArray *photoA =[self.allPhotosDic objectForKey:[NSString stringWithFormat:@"%d",(int)indexPath.row + 1]];
    
    cell.imageView.image = imagePhoto;
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@(%d)",self.photosArray[indexPath.row],(int)photoA.count];
    
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   

    
    NSArray *phoArray = [self.allPhotosDic objectForKey:[NSString stringWithFormat:@"%d",(int)indexPath.row + 1]] ;
    
    NSArray *assetA =[self.allPhotosAsset objectForKey:[NSString stringWithFormat:@"%d",(int)indexPath.row + 1]];
    
    
    
    AllPhotosController *photos = [[AllPhotosController alloc]init];
    
    
    photos.photoArray = phoArray;
    
    photos.assetArray = assetA;
    
    photos.albumName = self.photosArray[indexPath.row];
    
    
    [self.navigationController pushViewController:photos animated:YES];
    
 
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
