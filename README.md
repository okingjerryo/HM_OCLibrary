
# HM_OCLibrary
A Objective-C Library for myself,just want to collect my often used model in daily.Maybe such issue on my code qwq
## DataStructure
A personal library to extend OC with some basic data structure, such as "queue"、“stack”、"Tree"and "Graph".Also some basic algorithm will packet in it.
## Graph
图算法类封装了与图有关的算法
### HMGraph类
这个类是基于OC的一个图算法，封装了一些图类的基本操作和一些图论的常用算法

 采用将Data 与 Relation分别封装的方法<br>
 同时引入了对Data下标和Realtion下标分别建立hash字典索引，增强搜索速度<br>
 内部模型间通过特征字符串Key作为数据标示对象。
 
 （时间 空间期望均在O(n)左右）
##### 期望目标是实现
- 从文件初始化，将一个图结构保存至文件
- 增删改查 一个图中的元素，同时建立相关映射
- 对一个图的深度优先广度优先遍历(以及深度or广度遍历到下一个目标元素)
- 封装了一个简单的利用Prim算法和 Kruskal算法求最小代价路径的类输出
- 判断一个图是否为连通图

##### 现在其中实现了
- 根据一个纯文本文档进行图的初始化，并建立图的对应关系<br>
- 插入一个数据信息<br>
- 插入一个图的关系节点(包括权重)<br>
(上面两个方法封装了3种函数供实际使用时选择)<br>
- 图的深度优先搜索<br>
- 图的广度优先搜索<br>
- 判断一个图的连通性<br>

## Queue
队列相关的数据结构，初步构建目标是一个普通的队列和优先级队列
### HMQueue 类
这个类是基于OC的一个队列类的封装，继承自NSMutableArray。<br>
其中封装了类似C++STL的一些对队列操作的算法

##### 期望目标实现
<ul>
<li>入队出队</li>
<li>获取队头元素（元素不出队）</li>
<li>是否队空队满</li>
<li>初始化设定队列的容量[就是限制队列的最大大小]，通过一个NSArray初始化队列</li>
<li>两个以及多个队列的一次性合并</li>
</ul>

####New Bata Version 0.11
<ul>
<li>Add HMDataStructure.h to collect and tidy up all header about DS</li>
<li>Add some Basic Operation to HMGraph (Details in DataStructure's branch)</li>
<li>A Definition 'HMQueue' create in DS, and Define some basic operation in header</li>
</ul>

wish you will like this ^.^

