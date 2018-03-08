//
//  HMGraph.h
//  HMLibrary
//
//  Created by 万能的仓鼠 on 5/24/16.
//  Copyright © 2016 UryuoHamusta. All rights reserved.
//

#ifndef HMGraph_h
/*
 
 封装了一个图类
 采用将Data 与 Relation分别封装的方法
 同时引入了对Data下标和Realtion下标分别建立字典索引，增强搜索速度
 
 并实现了
 从文件初始化（现在是文件中为纯String元素）
 增删改查 一个图中的元素，同时建立相关映射
 对一个图的深度优先广度优先遍历(以及是否只深度or广度遍历一个元素)
封装了一个简单的利用Prim算法和 kruskal算法求最小代价路径的类输出
 判断一个图是否为连通图

 ps 记得使用[autorelease]
 */
#define HMGraph_h

//(这里节点就使用NSObject的kv特性来存储)
@interface HMGraph : NSObject
@property (nonatomic)BOOL isDirection; //是否为有向图
@property (nonatomic)NSUInteger count;//数据的成员数量



-(nonnull id)initStringObjectWithPath:(nonnull NSString *)path;//初始化纯String类型的图，通过文件保存

//插入数据元 和初始化的键值（键值唯一！）
-(void)addDataObject:(nonnull id)inputObject andkey:(nonnull NSString *)keyval;

//使用这个插入关系，如果两个元素但凡有一个不存在于图的数据中便会报错，适用于对已经确定插入的路径在元素中有体现的情况
-(BOOL)addRelationshipByKeySourse:(nonnull NSString *)keyS andKeyTarget:(nonnull NSString *)keyT andWeight:(NSUInteger)weight;

//这是一个万全的方法 插入是 不会报错的(除了参数有点多。。)
-(void)addRelationshipByObject:(nonnull id)source andSourceKey:(nonnull NSString*)keyS and:(nonnull id)target andTargetKey:(nonnull NSString*)keyTar andWeight:(NSUInteger)weight;//插入对应关系

//图的深度优先遍历 传出一个按序排列的结果集
-(nonnull NSArray*)deepFirstSearch;
//图的广度优先遍历 传出一个按序排列的结果集
-(nonnull NSArray*)breadthFirstSearch;
//判断一个图是否为连通图
-(BOOL) isGraphInterConnected;




//=====一些 类内需要的方法，这里予以战术隐藏=====
-(nullable NSArray *)readGraphData:(nonnull NSString *)path;
-(void)constructReadFile:(nullable NSArray *)initReadGraphArray;
-(nullable NSMutableArray*)DTSBuildArray:(nullable NSMutableArray *)array andTKey:(nonnull NSString*)inkey andusedSet:(nonnull NSMutableSet*)usedS;
-(nonnull NSString*)DTSfindNextElemInLine:(NSUInteger)lineNum andUsedSet:(nonnull NSMutableSet *)useS;
-(nullable NSMutableArray*)BFSBuildArray:(nullable NSMutableArray *)array andTKey:(nonnull NSString*)inkey andusedSet:(nonnull NSMutableSet*)usedS;
@end
#endif /* HMGraph_h */
