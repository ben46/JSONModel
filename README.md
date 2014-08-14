## JSONModel integrate with sqlite3

This is this a framework which can be easily used for *json modelling* and *sqlite CRUD*.

The whole project is base on the two famous framework in objc: [JSONModel](https://github.com/icanzilb/JSONModel) and [FMDB](https://github.com/ccgus/fmdb).

First you must know what is [JSONModel](https://github.com/icanzilb/JSONModel).

	JSONModel is a library, which allows rapid creation of smart data models. You can use it in your iOS or OSX apps.

	JSONModel automatically introspects your model classes and the structure of your JSON input and reduces drastically the amount of code you have to write.


If you want to read more about JSONModel, have a look at [this short tutorial](https://github.com/icanzilb/JSONModel).


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
@property (assign, nonatomic) NSNumber<JMPrimaryKey> *ID;
@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) float price;
@end
```


some where in your code :



```objective-c
#import "CountryModel.h"
...

NSString* json = (fetch here JSON from Internet) ... 
NSError* err = nil;

CountryModel* country = [[CountryModel alloc] initWithString:json error:&err];
 // automatically create table && save to database
[country JM_save];

// find the value matches the primary key
CountryModel* countryYouJustSaved = [CountryModel JM_find:@1]; 
NSLog(@"%@", [countryYouJustSaved toDictionary]);

```


------------------------------------
Known issue & TO-DO List
====================================

* `BOOL` properties can not be stored(please use NSInteger instead)
* store NSArray of JSONModel(batch store using block running in background thread)


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
