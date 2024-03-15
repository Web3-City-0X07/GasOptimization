# Gas optimization

这是一个关于EVM Gas优化的案例项目

当我们用Google或者时下流行的AI工具中搜索‘如何优化智能合约燃气消耗’这样的关键字时，通常得到的结果排在前面的是【Top N Solidity Gas Optimization Techniques】这样文章，并会给出以下建议：
1. Use Mappings Instead of Arrays 尽量用MAP而不是数组；
2. Enable the Solidity Compiler Optimizer 开启编译优化设置；
3. Minimize On-Chain Data 尽量减少在链上存储数据；
4. Pack Your Variables，利用合并存储变量值机制；
5. Cache read variables in memory，在内存中缓存读变量；
6. Store Data in calldata Instead of memory，参数使用calldata而非memery；
7. Free Up Unused Storage，释放不再使用的存储槽空间；
8. Use immutable and constant，使用常量值；
9. Use the external Visibility Modifier，使用external方法可见；
10. Use revert instead of require，使用 revert 代替 require；

这些建议确实很有帮助，不过不够完善，有的方法随着编译器的升级已经过时，有的文章的一些方法并不是总好使，可能会误导读者，更重要的是其实我们足够了解EVM基础的知识之后才能在燃气优化上做出有效的结果。

合约开发是Web3开发中比较重点的部分，随着技术的发展，我们现在可以在网络上找到丰富的学习资料，许多的文档、视频或者书籍，但大部分的内容是关于Solidity语法和合约安全相关内容，对于如何节省燃气消耗，目前还没遇到让人兴奋的学习资料。智能合约燃气优化曾是工作内容的重要的部分（确实过程中很多让人迷茫的问题）。之前一直忙着工作，没有写点什么，现在趁着有些时间，我尝试着去更深入的学习相关知识，同时分享给大家，希望这个项目对大家有所帮助。

想要掌握燃气优化，首先需要EVM的结构基础以及合约方法在链上执行过程，然后是要掌握在Solidity语言层面不同写法带来的燃气消耗的差异，最后想要极致的燃气优化，需要借助合约编译优化配置以及内联汇编带来的强大能力。所以我把整个项目的内容分为三个部分，第一部分是EVM基础结构以及合约执行相关的基础知识，第二部分是一些语言语法层面的小技巧，第三部分是深入了解编译优化设置和内联汇编的知识。

### 内容列表

#### Part1: EVM基础结构以及合约执行相关基础知识
1. [EVM相关基础知识](docs/Case_000.MD)；
2. [一个计数合约，来解释合约执行的流程和燃气消耗](docs/Case_001.MD)；
3. [Calldata及优化方法](docs/Case_002.MD)；
4. [存储使用及存储合并](docs/Case_003.MD)；
5. [存储读写的燃气消耗](docs/Case_004.MD)；
6. [内存的燃气计算](docs/Case_005.MD)；
7. [日志event收费](docs/Case_006.MD)；
8. [调用合约](docs/Case_007.MD)；
9. [合约编译优化设置简单介绍](docs/Case_008.MD)；

#### Part2: 语言语法层面的小技巧
- [+1 的四种写法](docs/Case_101.MD)；
- [revert vs require](docs/Case_102.MD)；
- [calldata和memery内存影响](docs/Case_103.MD)；
- 可见性对燃气消耗的影响 TODO；
- [缓存数组值避免多次循环读插槽](docs/Case_109.MD)；

#### Part2: 语言语法层面的小技巧
- [优化设置启用]() TODO;
- [IR-base优化设置]() TODO;

当我开始写这个项目的时候，我自认为是自己以及掌握了大部分燃气优化的知识，但当我真的深入到细节的时候才发现自己之前的诸多遗漏，然后就进入了一个个通宵的不眠夜。

很庆幸，现在第一部分基础篇已经基本完成～

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

- [Understanding event logs on the Ethereum blockchain](https://medium.com/mycrypto/understanding-event-logs-on-the-ethereum-blockchain-f4ae7ba50378) MyCrypto Mar 5, 2020

[EVM Deep Dives 5: Another Weapon in the EVM Hackers Arsenal - The Power of Delegate Call](https://noxx.substack.com/p/evm-deep-dives-the-path-to-shadowy-a5f)
NOXX 2022年5月16日

#### 网站
[EVM.codes](https://www.evm.codes/) 非常好的EVM及字节码相关

[EIPS](https://eips.ethereum.org/all) 
#### 视频
[B站 坡县泽宾](https://space.bilibili.com/2112923943/channel/collectiondetail?sid=1538140) 很牛，很喜欢

[B站 Web3研习舍](https://www.bilibili.com/video/BV174421c79R?p=29&vd_source=db54ffa9ac6ff13a5d5eb108632bd192) 丰富

#### 项目



