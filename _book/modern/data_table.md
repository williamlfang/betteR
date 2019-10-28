# data.table：像神一样操作数据

`data.table` 是目前圈内最受关注的软件包，提供了便捷的数据处理逻辑以及高效的数据运算性能，尤其是对于处理较大规模的数据，`data.table` 具有明显的优势。

这是 `data.table` 的[开发主页](https://github.com/Rdatatable/data.table)，可以看出，这个在 10 年前创建的软件包，目前依然处理十分活跃的开发与改进阶段，而且历次的更新均带来更加优秀的处理能力。我直接从项目网页摘取以下几个特征，以管窥豹

## 优秀特征

- **快速读取数据文件** 👉 fast and friendly delimited **file reader**: **?fread**, see also [convenience features for *small* data](https://github.com/Rdatatable/data.table/wiki/Convenience-features-of-fread)
- **快速写入数据文件** 👉 fast and feature rich delimited **file writer**: **?fwrite**
- **底层支持并行运算(隐式并行)** 👉 low-level **parallelism**: many common operations are internally parallelized to use multiple CPU threads
- **支持大内存数据处理** 👉 fast and scalable **aggregations**; e.g. 100GB in RAM (see [benchmarks](https://github.com/Rdatatable/data.table/wiki/Benchmarks-%3A-Grouping) on up to **two billion rows**)
- **方便使用 `join`(这点对于数据分析尤其重要)** 👉 fast and feature rich joins: **ordered joins** (e.g. rolling forwards, backwards, nearest and limited staleness), **overlapping range joins** (similar to `IRanges::findOverlaps`), **non-equi joins** (i.e. joins using operators `>, >=, <, <=`), **aggregate on join** (`by=.EACHI`), **update on join**
- **使用引用，避免在内存的拷贝消耗** 👉 fast add/update/delete columns **by reference** by group using no copies at all
- fast and feature rich **reshaping** data: **?dcast** (*pivot/wider/spread*) and **?melt** (*unpivot/longer/gather*)
- **any R function from any R package** can be used in queries not just the subset of functions made available by a database backend, also columns of type `list` are supported
- **兼容原生的 `data.frame`，因此适用所有的软件包** 👉 has **no dependencies** at all other than base R itself, for simpler production/maintenance
- the R dependency is **as old as possible for as long as possible** and we continuously test against that version; e.g. v1.11.0 released on 5 May 2018 bumped the dependency up from 5 year old R 3.0.0 to 4 year old R 3.1.0
