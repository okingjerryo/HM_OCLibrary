# DataStructure
欢迎来到数据结构分支w，这里存放着这边写的一些数据结构的扩展类
##Graph
图算法类封装了与图有关的算法【谜之声：废话】
###HMGraph类
这个类是基于OC的一个图算法，封装了一些图类的基本操作和一些图论的常用算法

 采用将Data 与 Relation分别封装的方法
 同时引入了对Data下标和Realtion下标分别建立字典索引，增强搜索速度
 （时间期望在O(1)左右，空间期望在O(n)附近）

期望目标是实现：

从文件初始化（现在是文件中为纯String元素）

增删改查 一个图中的元素，同时建立相关映射

对一个图的深度优先广度优先遍历(以及是否只深度or广度遍历一个元素)

封装了一个简单的利用Prim算法和 kruskal算法求最小代价路径的类输出

判断一个图是否为连通图

现在其中实现了对图的建立的相关算法。
 
