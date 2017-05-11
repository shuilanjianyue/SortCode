//
//  FmdbManger.m
//  总结
//
//  Created by dazaoqiancheng on 16/4/13.
//  Copyright © 2016年 DZQC. All rights reserved.
//

#import "FmdbManger.h"
#import "FMDB.h"
#import "ProvinceModel.h"


/**基础数据库*/
static FMDatabase *_db;

@implementation FmdbManger


+(void)initialize
{
    
    // 1.打开数据库
   // NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"city.db"];
    
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *filePatch = [mainBundle pathForResource:@"city" ofType:@"db"];
    
    NSLog(@"path%@",filePatch);
    
    _db = [FMDatabase databaseWithPath:filePatch];
    
    
    [_db open];
    
    
    NSLog(@"ddd");
    
}


- (NSMutableArray *)privinceArray{
    
    NSMutableArray *temp=[NSMutableArray array];
    
    NSString *sqlStr=[NSString stringWithFormat:@"SELECT * FROM t_prov_city_area where parentno = 0"];
    
    FMResultSet *set=[_db executeQuery:sqlStr];
    
    
    while (set.next) {
        
        ProvinceModel *model=[[ProvinceModel alloc]init];
        
        model.areano=[NSString stringWithFormat:@"%d",[set intForColumn:@"areano"]];
        
        model.areaname=[set stringForColumn:@"areaname"];
        
        model.parentno=[NSString stringWithFormat:@"%d",[set intForColumn:@"parentno"]];
        
        [temp addObject:model];
        
        
    }

    
    return temp;
    
    
}



-(NSMutableArray *)cityArray:(NSString *)parentId{
    NSMutableArray *temp=[NSMutableArray array];
    
    NSString *sqlStr=[NSString stringWithFormat:@"SELECT * FROM t_prov_city_area where parentno = %@",parentId];
    
    FMResultSet *set=[_db executeQuery:sqlStr];
    
    
    while (set.next) {
        
        ProvinceModel *model=[[ProvinceModel alloc]init];
        
        model.areano=[NSString stringWithFormat:@"%d",[set intForColumn:@"areano"]];
        
        model.areaname=[set stringForColumn:@"areaname"];
        
        model.parentno=[NSString stringWithFormat:@"%d",[set intForColumn:@"parentno"]];
        
        [temp addObject:model];
        
    }
    
    return temp;
}


-(NSMutableArray *)aeraArray:(NSString *)parentId{
    NSMutableArray *temp=[NSMutableArray array];
    
                       
    NSString *sqlStr=[NSString stringWithFormat:@"SELECT * FROM t_prov_city_area where parentno = %@",parentId];
    
    FMResultSet *set=[_db executeQuery:sqlStr];
    
    
    while (set.next) {
        
        ProvinceModel *model=[[ProvinceModel alloc]init];
        
        model.areano=[NSString stringWithFormat:@"%d",[set intForColumn:@"areano"]];
        
        model.areaname=[set stringForColumn:@"areaname"];
        
        model.parentno=[NSString stringWithFormat:@"%d",[set intForColumn:@"parentno"]];
        
        [temp addObject:model];
        
    }
    
    
    return temp;
    
    
}


@end
