# Gas optimization

这是一个关于EVM Gas优化的案例项目

当我们用Google或者时下流行的AI工具中搜索‘如何优化智能合约燃气消耗’这样的关键字时，通常得到的结果排在前面的是【Top N Solidity Gas Optimization Techniques】这样文章，并会给出以下建议：
1. Use Mappings Instead of Arrays 尽量用MAP而不是数组；
2. Enable the Solidity Compiler Optimizer 开启编译优化设置；
3. Minimize On-Chain Data 尽量减少在链上存储数据；
4. Pack Your Variables，利用合并存储变量值机制；
5. Cache read variables in memory，在内存中缓存读变量；
6. Store Data in calldata Instead of memory，参数使用calldata标记而非memery；
7. Use Indexed Events，使用事件消息；
8. Free Up Unused Storage，释放不再使用的存储槽空间；
9. Use immutable and constant，使用常量值；
10. Use the external Visibility Modifier，使用external方法可见；
11. Use uint8 Can Increase Gas Cost，有时使用uint8会增加燃气消耗；
12. Use revert instead of require，使用 revert 代替 require；
13. Avoid loading too many data in memory，避免加载太多数据到内存；

这些建议确实很有帮助，不过不够完善，除了这些还有很多需要学习了解的地方。

合约开发是Web3开发中比较重点的部分，随着技术的发展，我们也能从网络上找到丰富的介绍合约开发的文档、视频或者书籍，但更多的内容是关于Solidity语法和合约安全相关内容，对于如何节省燃气消耗，目前还没遇到太细致的学习资料。关于Gas优化，是我之前工作的很重要的一部分（确实很多迷茫的时候），所以我尝试着去更深入的学习相关知识，同时分享给大家，希望这个项目对大家有所帮助。

了解Gas优化，首先需要了解合约是怎样在链上运行，我们会讲到从合约交易的提交到字节码调用相关知识内容，也会讲到合约存储和内存使用相关内容，还有跨合约调用等内容。

### 内容列表
1. [EVM相关基础知识](docs/Case_000.MD)；
2. [一个计数合约案例，来解释合约被执行的流程和燃气消耗](docs/Case_001.MD)；
3. [交易calldata，及优化方法](docs/Case_002.MD)；
4. [存储使用及存储合并](docs/Case_003.MD)；
5. [存储读写的燃气消耗](docs/Case_004.MD)；
6. 内存的燃气计算 TODO；
7. [日志event收费](docs/Case_006.MD);
8. 调用合约 TODO；
9. 合约编译优化设置 TODO；
10. 用汇编指令来做优化 TODO；

一些语法上带来的优化

- [+1 的四种写法](docs/Case_101.MD)；
- [revert vs require](docs/Case_102.MD)；
- [calldata和memery内存影响](docs/Case_103.MD)；
- 可见性对燃气消耗的影响 TODO；
- [缓存数组值避免多次循环读插槽](docs/Case_109.MD)；


当我开始写这个项目的时候，我自认为是比较懂燃气优化的，想把自己懂得东西分享出来，但当我真的深入到细节的时候才发现自己之前的诸多遗漏，然后是边学边写，很多时候时候通宵完成一篇，然后第二天又发现了新的细节需要补充一下。

### 推荐

#### 博客
强烈推荐 [noxx](https://noxx.substack.com/)的EVM Deep Dives系列文章,
这个博主主要在18年高频产出，而且质量很高 [programtheblockchain](https://programtheblockchain.com/posts/)

#### 文章
[EVM Deep Dives 1: Digging deep into the EVM mechanics during contract function calls](https://noxx.substack.com/p/evm-deep-dives-the-path-to-shadowy) 
NOXX 2022年2月28日

[EVM Deep Dives 2: Let's take a trip down memory lane](https://noxx.substack.com/p/evm-deep-dives-the-path-to-shadowy-d6b?s=r)
NOXX 2022年3月6日

[EVM Deep Dives 3: Demystifying Storage Slot Packing - Key Knowledge for the EVM Hackers](https://noxx.substack.com/p/evm-deep-dives-the-path-to-shadowy-3ea?s=r)
NOXX 2022年3月28日

[EVM Deep Dives 4: Under The Hood - Storage Opcodes In the Go Ethereum (Geth) Client](https://noxx.substack.com/p/evm-deep-dives-the-path-to-shadowy-5a5?s=r)
NOXX 2022年5月6日

[Understanding Ethereum Smart Contract Storage](https://programtheblockchain.com/posts/2018/03/09/understanding-ethereum-smart-contract-storage/)
2018/3/9 BY STEVE MARX

#### 网站
[EVM.codes](https://www.evm.codes/) 非常好的EVM及字节码相关

[ethervm](https://www.ethervm.io/) 内容一般
#### 视频
[B站 坡县泽宾](https://space.bilibili.com/2112923943/channel/collectiondetail?sid=1538140) 很牛，很喜欢

[B站 Web3研习舍](https://www.bilibili.com/video/BV174421c79R?p=29&vd_source=db54ffa9ac6ff13a5d5eb108632bd192) 丰富

#### 项目



