//
//  DBManager.m
//  SQLite
//
//  Created by space on 15/3/24.
//  Copyright (c) 2015年 ZYahurey. All rights reserved.
//

#import "DBManager.h"
#import "FMDB.h"
static DBManager *shareInstance = nil;
static FMDatabase *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager
+(DBManager *)getShareInsetance{
    if (!shareInstance) {
        shareInstance = [[super allocWithZone:NULL]init];
        [shareInstance createDB];
    }
    return shareInstance;
}

- (NSString*) getPath {
    NSString *path = NSHomeDirectory();
    return [path stringByAppendingPathComponent:@"Documents/data.db"];
}

-(void)createDB{
    database = [FMDatabase databaseWithPath:[self getPath]];
    BOOL res = [database open];
    if (res == NO) {
        NSLog(@"打开失败");
        return;
    }else{
        NSLog(@"数据库打开成功");
    }
    //如果表不存在，创建
    res = [database executeUpdate:@"create table if not exists Students(registerNumber,name,department,year)"];//执行sql语句
    
    if (res == NO) {
        NSLog(@"创建失败");
        [database close];//关闭数据库
        return;
    }else if(res==YES){
        NSLog(@"创建成功");
    }
}

-(BOOL)saveData:(NSString*)registerNumber name:(NSString*)name department:(NSString*)department year:(NSString*)year{
    BOOL res = [database open];
    //插入数据
    res = [database executeUpdate:@"insert into Students values (?,?,?,?)", registerNumber, name, department, year];
    [database close];
    if (res == NO) {
        NSLog(@"插入失败");
        return NO;
    }else{
        return YES;
    }
    
}

-(BOOL)delByRegisterNumber:(NSString *)registerNumber{
    BOOL res = [database open];
    if (res == NO) {
        NSLog(@"打开失败");
        return NO;
    }
    res = [database executeUpdate:@"delete from Students where registerNumber=?",registerNumber];
    if (res == NO) {
        NSLog(@"删除失败");
        return NO;
    }
    return YES;
}

-(BOOL)updateByRegisterNumber:(NSString *)registerNumber name:(NSString *)name{
    BOOL res = [database open];
    if (res == NO) {
        NSLog(@"修改失败");
        return NO;
    }
   
    res = [database executeUpdate:@"update Students set name=? where registerNumber=?", name, registerNumber];
    if (res == NO) {
        NSLog(@"修改失败");
    }
    return res;
}

-(NSArray *)findByRegisterNumber:(NSString *)registerNumber{
    
    BOOL res = [database open];
    if (res == NO) {
        NSLog(@"打开失败");
        
    }
    FMResultSet* set = [database executeQuery:@"select * from Students"];//FMResultSet相当于游标集
    //创建数组，保存所有学生信息
    NSMutableArray* array = [NSMutableArray array];
    //遍历Students表
    while ([set next]) {//有下一个的话，就取出它的数据，然后关闭数据库
        NSString* registern = [set stringForColumn:@"registerNumber"];
        
        if ([registerNumber isEqualToString:registern]) {
            NSLog(@"%@",registern);
            NSString* name = [set stringForColumn:@"name"];
            NSString* department = [set stringForColumn:@"department"];
            NSString* year = [set stringForColumn:@"year"];
            
            NSArray *data = @[registerNumber,name,department,year];
            [array addObject:data];

            }
        }
    [set close];
    [database close];
    return array;
}
@end
