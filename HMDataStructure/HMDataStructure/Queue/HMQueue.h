//
//  HMQueue.h
//  HMDataStructure
//
//  Created by 万能的仓鼠 on 16/6/1.
//  Copyright © 2016年 UryuoHamusta. All rights reserved.
//

#ifndef HMQueue_h
/*
 一个继承自NSMutableArray的普通队列
 具有一般的入队出队操作以及获取队头的操作
 */
#define HMQueue_h
@interface HMQueue : NSMutableArray
//大小默认不限制，如果限制队列大小则size具有相应数值
@property NSUInteger size;
//入队
-(void) insertQueue:(nonnull id)elem;
//出队
-(nullable id) extractQueue;
//队头元素
-(nullable id)topQueue;
//是否队空
-(BOOL)isQueueEmpty;
//是否队满
-(BOOL)isQueueFull;
//初始化队伍的容量
-(void)initQueueWithCapacity:(NSUInteger)numItems;
//通过一个Array初始化队列
-(void)initQueueWithArray:(nonnull NSArray *)initArray;
//清空队列
-(void)clearQueue;
//两个队列合并
-(nonnull HMQueue *)mergeQueue:(nonnull HMQueue *)queueF andAnother:(nonnull HMQueue *)queueS;
//多个队列合并
-(nonnull HMQueue *)mergeMutableQueue:(nonnull NSMutableArray <HMQueue *>*) QueueList;
@end

#endif /* HMQueue_h */