## JSONModel parsing & sqlite CRUD

Coredata 太难用了, 于是我写了这个框架, 搞定 json 解析&数据的增删改查

这个库是在JSONModel基础之上做的.

JSONModel是用来解析json的一个库, 解析json完成之后, 我们需要做数据存储, 怎么办?

* 方法1. 存储返回的json到NSUserDefaults里面, 但是这样做update或者select的时候就蛋疼了

* 方法2. 自己用sqlite存起来, 但是这样需要自己把每个字段先建好, 每个参数insert的时候, 都需要写一段sql, 太麻烦!

* 方法3. 使用coredata, 但是coredata却又有众所周知超难用的地方, 并且不适合数据量大了之后使用.

**这些方法都糟糕透了!**

于是我写了这个框架, 融合了json解析, 巨简单的sqlite增删改查.

###包含几个功能

* 根据json里面的key的名字来命名oc中property的名字, 这样就能根据json自动解析成oc model
* 无需手动建立数据库, 自动根据model的property的名字建表.
* 插入一条数据只需一行代码
* 查表的时候只用一行代码
* 如有model更新, 只需在model中重写tableVersion方法即可.

----

This is this a framework which can be easily used for *json modelling* and *sqlite CRUD*.

The whole project is base on the two famous framework in objc: [JSONModel](https://github.com/icanzilb/JSONModel) and [FMDB](https://github.com/ccgus/fmdb).

First you must know what is [JSONModel](https://github.com/icanzilb/JSONModel).

	JSONModel is a library, which allows rapid creation of smart data models. You can use it in your iOS or OSX apps.

	JSONModel automatically introspects your model classes and the structure of your JSON input and reduces drastically the amount of code you have to write.


If you want to read more about JSONModel, have a look at [this short tutorial](https://github.com/icanzilb/JSONModel).

After we parsed the json, we needs to store data in the model: 

* solution 1. store the json string to the NSUserDefaults, but in this way, it's impossible when you need to update the model or select the data you want.

* solution 2. saving the data using sql, but you have to write all the sql, specially when you have too many columns, and also you have to create the database & table on your own!

* solution 3. use coredata, but as we all known, coredata is very difficult to use, and it gets very slow when you are dealing with massive data.

------------------------------------
Adding JSONModel to your project
====================================

#### Requirements

* ARC only; iOS 5.0+ 

#### via Cocoa pods

```ruby
pod 'JSONModel', :git => 'https://github.com/ben46/JSONModel.git'
```

If you want to read more about CocoaPods, have a look at [this short tutorial](http://www.raywenderlich.com/12139/introduction-to-cocoapods).


------------------------------------


Examples
=======

#### Automatic name based mapping

JSON from Internet:

```javascript
{
  "ID": "1",
  "name": "Product name",
  "price": 12.95
}
```

define your data model:

```objective-c
@interface ProductModel : JSONModel

// JMPrimaryKey代表这个property就是主键
@property (assign, nonatomic) NSNumber<JMPrimaryKey> *ID;
@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) float price;

@end
```


some where in your code :



```objective-c
#import "ProductModel.h"
...

NSString* json = (fetch here JSON from Internet) ... 
NSError* err = nil;

ProductModel* product = [[ProductModel alloc] initWithString:json error:&err];
// automatically create table && save to database
// 自动建数据库 & 自动建表 & 自动保存到数据库
[product JM_save];

// find the value matches the primary key
// 根据主键查表
ProductModel* productYouJustSaved = [ProductModel JM_find:@1]; 
NSLog(@"%@", [countryYouJustSaved toDictionary]);

// 根据条件查表
ProductModel* productYouJustSaved = [ProductModel JM_whereCol:@"name" isEqualTo:@"Product name"];

// 以及排序等等诸多功能...


```


------------------------------------
Known issue & TO-DO List
====================================

* `BOOL` properties can not be stored(please use NSInteger instead)
* `BOOL` 类型暂时无法储存, 请使用NSInteger代替
* 防止sql注入


-------

Misc
=======

Author: `Zhuoqian Zhou`


-------
#### License
This code is distributed under the terms and conditions of the MIT license. 

-------
#### Contribution guidelines

**NB!** If you are fixing a bug you discovered, please add also a unit test so I know how exactly to reproduce the bug before merging.

-------
