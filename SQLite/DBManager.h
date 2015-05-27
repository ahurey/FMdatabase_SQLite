//
//  DBManager.h
//  SQLite
//
//  Created by space on 15/3/24.
//  Copyright (c) 2015年 ZYahurey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject{
    NSString *databasePath;
}
+(DBManager *)getShareInsetance;
-(void)createDB;
-(BOOL)saveData:(NSString*)registerNumber name:(NSString*)name department:(NSString*)department year:(NSString*)year;
-(BOOL)delByRegisterNumber:(NSString *)registerNumber;
-(BOOL)updateByRegisterNumber:(NSString *)registerNumber name:(NSString *)name;
-(NSArray *)findByRegisterNumber:(NSString *)registerNumber;
@end
