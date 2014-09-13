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
----

#Example #1基础教程 basics


#### Automatic name based mapping(基于变量名的自动映射)

JSON from Internet(服务器端传回的json):

```javascript
{
  "ID": "1",
  "name": "Product name",
  "price": 12.95
}
```

define your data model(定义你的数据模型):

```objective-c
@interface ProductModel : JSONModel

// JMPrimaryKey代表这个property就是主键
@property (assign, nonatomic) NSNumber<JMPrimaryKey> *ID;
@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) float price;

@end
```

some where in your code (某个你的代码处):


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

#Example #2定义model define your model
如果你有一个很长的字段`description`储存了超过100字节的内容, 你可以使用`<JMText>`定义你的`property`

if your property stores more than 100 bytes' content, you can use `<JMText>` to define your `property`

```objective-c
@interface ProductModel : JSONModel

// JMPrimaryKey代表这个property就是主键
@property (assign, nonatomic) NSNumber<JMPrimaryKey> *ID;
@property (strong, nonatomic) NSString<JMText>* description;

@end
```


诸如此类的还有很多, 比如: 
there are many more like this: 

* JMPrimaryKey(主键)
* JMNotNull(不为空)
* JMUnique(唯一值)
* JMText(长字节)
* Ignore(不存储这个变量)

**1. 特别注意**, 现在不支持`BOOL`的存储, 如果你要存储`BOOL`, 请使用NSInteger代替. 

(We do not have `BOOL` support yet, if you has `BOOL` property, please use NSInteger instead)

**2. 特别注意**, 现在不支持`NSArray`的存储, 如果你要存储`NSArray`, 以下是我的方法. 

(We do not have `NSArray ` support yet, if you has `NSArray ` property, please use the following way)

```objective-c

// 朋友圈回复
@interface MomentReply : JSONModel
@property (copy, nonatomic) NSString<JMPrimaryKey>       *ID;
@property (copy, nonatomic) NSString       *momentID;
@end

// 某一条朋友圈
@interface Moment : JSONModel
@property (nonatomic,   copy) NSNumber<JMPrimaryKey> *ID;
@property (nonatomic,   strong) NSArray<Ignore>        *replyList; // 回复列表
@end

@implementation Moment

- (NSArray *)replyList{
    if(!_replyList) {
        _replyList = [MomentReply JM_where:[NSString stringWithFormat:@"`momentID ` = %@", self.ID]];
    }
    return _replyList;
}

@end
```
**3. 特别注意**, 现在不支持`自定义类型`的存储.

(We do not have `custom class defined property` support yet)


#Example #3插入数据 insert/save record


```objective-c

NSString* json = (fetch here JSON from Internet) ... 
NSError* err = nil;
ProductModel* product = [[ProductModel alloc] initWithString:json error:&err];
// automatically create table && save to database
// 自动建数据库 & 自动建表 & 自动保存到数据库
[product JM_save];
```

#Example #4更新/修改数据 update record


```objective-c

NSString* json = (fetch here JSON from Internet) ... 
NSError* err = nil;
ProductModel* product = [[ProductModel alloc] initWithString:json error:&err];
// automatically create table && save to database
// 如果主键相同, 则会自动替代原来表中的数据
// if their primary keys are equal, the old record will be replaced
[product JM_save];
```

#Example #5查表 find records
根据主键查找单条数据

find one the record with primary key.

```objective-c
ProductModel* product = [ProductModel JM_find:@(1)];
```

根据sql条件查找单条数据

find one the record with condition.

```objective-c
ProductModel* product = [ProductModel JM_findFirstWithRaw:@"where `ID` = 1"];
```

查找该表中的全部

find the all the records.

```objective-c
NSArray *list = [ProductModel JM_all];
```

根据sql条件查找该表中多条数据

find the records which's ID is greater than 10.

```objective-c
NSArray *list = [ProductModel JM_where:@"`ID` > 10"];
```

查找表中ID比1大的数据, 按照ID倒序排列

find the records which's ID is greater than 10 and order by id descend.

```objective-c
NSArray *list = [ProductModel JM_whereCol:@"`ID`" isGreaterThan:@10 orderBy:@"`ID` DESC"];
```

查找表中ID比10大的数据, 按照ID倒序排列

find the records which's ID is greater than 10 and order by id descend.

```objective-c
NSArray *list = [ProductModel JM_findRaw:@"where `ID` > 10 ORDER BY `ID` DESC"];
```

#Example #6删除数据 delete records

删除单条数据

detele one record

```objective-c
BOOL suc = [someProduct JM_delete];
```

删除表中ID比10大的数据

delete mutiple records with conditions

```objective-c
BOOL suc = [ProductModel JM_deleteWhereRaw:@"`ID` > 10"];
```

#Example #7数据表版本控制 records table version control

如果你的model在下个版本中发生了变化, 你可以重写静态方法`+ (NSString *)tableVersion;
`, 根据`tableVersion `的不同会生成不同的表. 

If your model has been changed, the old table can not be used any more, you have to rewrite the `tableVersion` method.

```objective-c
@implementation ProductModel

+ (NSString *)tableVersion;
{
    return @"1_0_1_0";
}

@end
```


------------------------------------
Known issue & TO-DO List
====================================

* `BOOL` properties can not be stored(please use NSInteger instead)
* sql injection
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
