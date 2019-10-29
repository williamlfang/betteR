Rcpp：提供核动力
================

`R` 最早是出于教学的目的，由两位统计学教授 Ross Ihaka 和 Robert
Gentleman 在新西兰大学共同发起创建。这就决定了 `R` 的天然基因是不具备
`CS` 的考究，即不过多的重视运行性能，而把重点放在快速验证想法。比如，`R`
属于解释型语言的范畴，不需要事先编译成机器码，只需要把需要处理的单行代码（或者单个代码块）传递给解释器（支持
`REPL`），就可以得到结果。从开发人员处理统计数据的角度看，这无疑是大大缩短了从想法到验证结果的的痛苦过程；但是，如果是重复执行某个步骤、大量调用某个函数，这就成为了一项瓶颈，毕竟边解释边运行需要消耗大量的运力，无法达到机器码那样的执行速度。

为了提升 `R` 的处理性能，我们常常绞尽脑汁，比如

-   使用向量化运算，尽量避免循环操作
-   使用并行计算，榨干机器的每一个 `cpu`
-   把执行的函数放入缓冲，避免重复调用

但是，无可避免的，以上的操作只是杯水车薪，无法从根本上解决 `R`
作为解释型语言的弱点。为了彻底解决这个问题，一个想法便是为 `R`
提供底层的代码支持，即绕开解释器、直接调用底层的 `c/c++`
执行运算，这样便可以大大的提升 `R` 的处理能力了。从开发的机制上看，`R`
本身是由 `S` 演变过来的，而最早的 `S` 语言又是使用 `c`
语言开发的，这意味着 `R`
实际上也是具备调用底层代码的能力。不过，直接编写允许调用底层 `c`
接口会比较麻烦，需要处理太多的技术细节。

为此，大牛 [Dirk Eddelbuettel](http://dirk.eddelbuettel.com/) 决定跳过
`c`，使用其高级版本——`c++` 为 `R`
提供调用底层的接口能力。这就是我们今天需要隆重介绍的主角：`Rcpp`。

<!--  -->
安装与配置
----------

### 安装软件包

直接使用 `CRAN` 安装即可

    install.packages("Rcpp")

    ## Installing package into '/home/william/R/x86_64-pc-linux-gnu-library/3.6'
    ## (as 'lib' is unspecified)

完成后，可以使用命令载入软件包

    library(Rcpp)

### 配置编译环境

通过编辑主目录文件 `~/.R/Makevars` 实现对编译环境的配置

    ## 设置编译环境：~/.R/Makevars

    CC=/opt/local/bin/gcc-mp-4.7
    CXX=/opt/local/bin/g++-mp-4.7
    CPLUS_INCLUDE_PATH=/opt/local/include:$CPLUS_INCLUDE_PATH
    LD_LIBRARY_PATH=/opt/local/lib:$LD_LIBRARY_PATH
    CXXFLAGS= -g0 -O2 -Wall
    MAKE=make -j4 

    ## for C code
    CFLAGS=               -O3 -g0 -Wall -pipe -pedantic -std=gnu99 

    ## for C++ code
    #CXXFLAGS=             -g -O3 -Wall -pipe -Wno-unused -pedantic -std=c++11
    CXXFLAGS=             -g -O3 -Wall -pipe -Wno-unused -pedantic 

    ## for Fortran code
    #FFLAGS=-g -O3 -Wall -pipe
    FFLAGS=-O3 -g0 -Wall -pipe
    ## for Fortran 95 code
    #FCFLAGS=-g -O3 -Wall -pipe
    FCFLAGS=-O3 -g0 -Wall -pipe

    # VER=-4.8
    # CC=ccache gcc$(VER)
    # CXX=ccache g++$(VER)
    # SHLIB_CXXLD=g++$(VER)
    FC=ccache gfortran
    F77=ccache gfortran
    MAKE=make -j8

开发
----

### `cppFunction`

### `sourceCpp`

对于大型的项目，我们一般不会直接使用 `cppFunction`
来内嵌代码，因为这样对长代码的支持不是特别好，而且无法接入其他的库函数。为此，需要单独在
`cpp` 的文件进行独立开发，然后使用 `sourceCpp` 完成编译后，提供给 `R`
进行调用。

一个常用的 `Rcpp.cpp` 文件格式为

    // =============================================================================
    // -------------------------
    #include <fstream>
    #include <sstream>
    #include <string>
    #include <Rcpp.h>

    using namespace std;
    using namespace Rcpp;
    // Enable C++11 via this plugin (Rcpp 0.10.3 or later)
    // [[Rcpp::plugins(cpp11)]]
    // -------------------------
     
    /* -------------------------
     * 通用的格式如下

    // [[Rcpp::export]]
    RETURN_TYPE FUNCTION_NAME(ARGUMENT_TYPE ARGUMENT){

        //do something

        return RETURN_VALUE;
    }

    */
    // =============================================================================

对比
----
