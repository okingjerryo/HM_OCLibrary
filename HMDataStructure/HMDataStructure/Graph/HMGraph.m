//
//  HMGraph.m
//  HMLibrary
//
//  Created by 万能的仓鼠 on 5/24/16.
//  Copyright © 2016 UryuoHamusta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMGraph.h"

@implementation HMGraph{
    NSMutableDictionary *releationship; //用hash 表存储邻接链表中的行映射关系
    NSMutableArray * graphElem; //图类主体数据结构
    NSMutableDictionary * graphData;//图类的元素的信息
}
//=======================初始化方法========================
@synthesize isDirection,count;
-(id)init{
    self=[super init];
    releationship=[[NSMutableDictionary  alloc]init];
    graphElem =[[NSMutableArray alloc]init];
    graphData=[[NSMutableDictionary alloc]init];
    return self;
}


//控制台普通文件输入 格式为 A B 权重；
-(id)initStringObjectWithPath:(NSString *)path{
    self=[self init];
    //读入数据
    NSArray *input=[self readGraphData:path];
    if(!input)
        NSLog(@"HMGraph Error: 在图的初始化时出现了问题：");
    
    //生成图 和对应关系
   [self constructReadFile:input];
    return self;
}
//从属于initStringObjectWithPath
-(NSArray *)readGraphData:(NSString *)path{
    //读文件
    NSString *reader=[[NSString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    if (!reader){
        NSLog(@"HMGraph Error :文件打开失败");
        return nil;
    }
    else{
        NSMutableArray *initArray= [[NSMutableArray alloc]initWithArray: [reader componentsSeparatedByString:@"\n"]];
        [initArray removeObjectAtIndex:[initArray count]-1];
    //读取第一个标志元素 1为有向图 其他为无向图
        if ([initArray[0] isEqualToString:@"1"])
            isDirection=true;
        [initArray removeObjectAtIndex:0];
        return initArray;
    }
}
//从属于initStringObjectWithPath
-(void)constructReadFile:(NSArray *)initReadGraphArray{
    for (NSString *elem in initReadGraphArray) {
        NSArray *thisTwoPar=[elem componentsSeparatedByString:@" "];
        NSString *source=[thisTwoPar objectAtIndex:0];
        NSString *target=[thisTwoPar objectAtIndex:1];
        NSUInteger quan=(unsigned)[[thisTwoPar objectAtIndex:2] integerValue];
        [self addRelationshipByObject:source andSourceKey:source and:target andTargetKey:target andWeight:quan];
        
    }
}

-(void)addDataObject:(id)inputObject andkey:(NSString *)keyval{
    if (![graphData valueForKey:keyval]){
        [graphData setValue:inputObject forKey:keyval];
        //邻接表中加入一行
        [graphElem addObject:[[NSMutableArray alloc]initWithObjects:keyval, nil]];
        
        //同时对邻接表位置的hash字典新增新项目的行号
        [releationship setValue:[[NSNumber alloc]initWithUnsignedInteger: [graphElem count]-1 ] forKey:keyval];
        count++;
    }else{
        NSLog(@"HMGraph Error:插入图元素中待插入的key重复，已存在key值为：%@",keyval);
    }
}



//============================成员方法======================================

-(BOOL)addRelationshipByKeySourse:(NSString *)keyS andKeyTarget:(NSString *)keyT andWeight:(NSUInteger)weight{
    BOOL flag=true;
   //对应键值的数据类检查 不存在 抛出
    if (![graphData valueForKey:keyS]) {
        NSLog(@"HMGraph Error:待插入的映射关系对应的数据不存在，缺少的数据key为%@",keyS);
        flag=false;
    }
    if (![graphData valueForKey:keyT]){
        flag=false;
        NSLog(@"HMGraph Error:待插入的映射关系对应的数据不存在，缺少的数据key为%@",keyT);
    }
    if (!flag) return flag;
    
    //插入对应关系
    //正向插入
    //构造正向键值串
    NSMutableString *relInput=[[NSMutableString alloc]initWithString:keyS];
    [relInput appendFormat:@" %@",keyT];
    //只有关系不存在才插入
    
    if (![releationship valueForKey:relInput]){
    NSUInteger sourIndex=[[releationship valueForKey:keyS]unsignedIntegerValue];
        if(![keyS isEqualToString:keyT]) [graphElem[sourIndex] addObject:keyT];
        //构造键值Array
        NSArray *inputValue=[[NSArray alloc]initWithObjects:[[NSNumber alloc]initWithUnsignedInteger:sourIndex],[[NSNumber alloc]initWithUnsignedInteger:[graphElem [sourIndex]count]-1],[[NSNumber alloc] initWithUnsignedInteger:weight],nil];
        [releationship setValue:inputValue forKey:relInput];
    }
    //如果是无向图则要插入相反方向的节点
    if (!isDirection&& ![keyS isEqualToString:keyT]){
        NSMutableString *relInputDe=[[NSMutableString alloc]initWithString:keyT];
        [relInputDe appendFormat:@" %@",keyS];
        
        if (![releationship valueForKey:relInputDe]){
            NSUInteger tarIndex=[[releationship valueForKey:keyT]unsignedIntegerValue];
            [graphElem[tarIndex] addObject:keyS];
            NSArray *inputValue=[[NSArray alloc]initWithObjects:[[NSNumber alloc]initWithUnsignedInteger:tarIndex],[[NSNumber alloc]initWithUnsignedInteger:[graphElem [tarIndex]count]-1],[[NSNumber alloc] initWithUnsignedInteger:weight],nil];
            [releationship setValue:inputValue forKey:relInputDe];
        }
    }
    return flag;
}

-(void)addRelationshipByObject:(id)source andSourceKey:(NSString *)keyS and:(id)target andTargetKey:(NSString *)keyTar andWeight:(NSUInteger)weight{
    //这个万全的策略，插入关系前先检查有没有这一项 没有就插入对象
    if (![graphData valueForKey:keyS])
        [self addDataObject:source andkey:keyS];
    if(![graphData valueForKey:keyTar])
        [self addDataObject:target andkey:keyTar];
    [self addRelationshipByKeySourse:keyS andKeyTarget:keyTar andWeight:weight];
}


//深度优先搜索
-(NSArray *)deepFirstSearch{
    //存储已经遍历过的对象key
    NSMutableArray *searchedKey=[[NSMutableArray alloc]init];
    //是否已经使用过的点的检查
    NSMutableSet * useCheck=[[NSMutableSet alloc]init];
    searchedKey=[self DTSBuildArray:searchedKey andTKey:[graphElem [0]objectAtIndex:0 ] andusedSet:useCheck];
    while ([useCheck count]<[self count]){
        NSMutableSet *leaveElem=[[NSMutableSet alloc]init];
        for (NSMutableArray* keyList in graphElem) {
            [leaveElem addObject:keyList[0]];
        }
        //做与总体的差集合
        [leaveElem minusSet:useCheck];
        //然后随便取一个元素做头继续遍历
        searchedKey=[self DTSBuildArray:searchedKey andTKey:[leaveElem anyObject] andusedSet:useCheck];
    }
    return [[NSArray alloc]initWithArray:searchedKey];
}
-(BOOL)isGraphInterConnected{
    //采用深度优先中的单点辐射搜索一次
    NSMutableArray *searchedKey=[[NSMutableArray alloc]init];
    NSMutableSet * useCheck=[[NSMutableSet alloc]init];
    searchedKey=[self DTSBuildArray:searchedKey andTKey:[graphElem [0]objectAtIndex:0 ] andusedSet:useCheck];
    if ([useCheck count]<[self count]) return false;
    return true;
}

-(NSMutableArray*)DTSBuildArray:(NSMutableArray *)array andTKey:(NSString *)inKey andusedSet:(NSMutableSet*)usedS{
    //行号
    NSUInteger line=[[releationship valueForKey:inKey]unsignedIntegerValue];
    //添加当前的元素key
    for (NSString* thisKey in graphElem[line]) {
        if (![usedS containsObject:thisKey]){
        [array addObject:thisKey];
        [usedS addObject:thisKey];
        }else continue;//减枝
        //寻找这层下一个的元素Key
        NSString *nextKey=[self DTSfindNextElemInLine:line andUsedSet:usedS];
        //如果这一行找不到了，返回递归的上一层
        if ([nextKey isEqualToString:@""]) return array;
        [self DTSBuildArray:array andTKey:nextKey andusedSet:usedS];
    }
    
    return array;
}

-(NSString *)DTSfindNextElemInLine:(NSUInteger)lineNum andUsedSet:(NSMutableSet *)useS{
    if([graphElem [lineNum] count]==1)return @"";
    for (NSString *testKey in graphElem[lineNum]) {
        if (![useS containsObject:testKey])
            return testKey;
    }
    return @"";
}

//广度优先搜索 输出的顺序上与深度优先稍有不同
-(NSArray*)breadthFirstSearch{
    NSMutableArray *searchedKey=[[NSMutableArray alloc]init];
    NSMutableSet * useCheck=[[NSMutableSet alloc]init];
    searchedKey=[self BFSBuildArray:searchedKey andTKey:[graphElem [0]objectAtIndex:0 ] andusedSet:useCheck];
    while ([useCheck count]<[self count]){
        NSMutableSet *leaveElem=[[NSMutableSet alloc]init];
        for (NSMutableArray* keyList in graphElem) {
            [leaveElem addObject:keyList[0]];
        }
        //做与总体的差集合
        [leaveElem minusSet:useCheck];
        //然后随便取一个元素做头继续遍历
        searchedKey=[self DTSBuildArray:searchedKey andTKey:[leaveElem anyObject] andusedSet:useCheck];
    }
    return [[NSArray alloc]initWithArray:searchedKey];
}

-(NSMutableArray *)BFSBuildArray:(NSMutableArray *)array andTKey:(NSString *)inkey andusedSet:(NSMutableSet *)usedS{
    NSUInteger line=[[releationship valueForKey:inkey]unsignedIntegerValue];
    //添加当前的元素key
    for (NSString* thisKey in graphElem[line]) {
        if (![usedS containsObject:thisKey]){
            [array addObject:thisKey];
            [usedS addObject:thisKey];
        }else continue;//减枝
    }
    //寻找这层下一个的元素Key
    NSString *nextKey=[self DTSfindNextElemInLine:line andUsedSet:usedS];
    //如果这一行找不到了，返回递归的上一层
    if ([nextKey isEqualToString:@""]) return array;
     [self DTSBuildArray:array andTKey:nextKey andusedSet:usedS];
    return array;
}

@end

