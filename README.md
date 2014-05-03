## JSONModel integrate with sqlite3

This is this a framework which can be easily used to *json modelling* and *sqlite CRUD*.

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
* **SystemConfiguration.framework**

#### via Cocoa pods

```ruby
pod 'JSONModel'
```

If you want to read more about CocoaPods, have a look at [this short tutorial](http://www.raywenderlich.com/12139/introduction-to-cocoapods).


------------------------------------
Basic usage
====================================

Consider you have a JSON like this:
```javascript
{"id":"10", "country":"Germany", "dialCode": 49, "isInEurope":true}
```

 * Create a new Objective-C class for your data model and make it inherit the JSONModel class. 
 * Declare properties in your header file with the name of the JSON keys:

```objective-c
#import "JSONModel.h"

@interface CountryModel : JSONModel

@property (assign, nonatomic) int id;
@property (strong, nonatomic) NSString* country;
@property (strong, nonatomic) NSString* dialCode;
@property (assign, nonatomic) BOOL isInEurope;

@end
```
There's no need to do anything in the **.m** file.

 * Initialize your model with data:

```objective-c
#import "CountryModel.h"
...

NSString* json = (fetch here JSON from Internet) ... 
NSError* err = nil;
CountryModel* country = [[CountryModel alloc] initWithString:json error:&err];

```

If the validation of the JSON passes you have all the corresponding properties in your model populated from the JSON. JSONModel will also try to convert as much data to the types you expect, in the example above it will:

* convert "id" from string (in the JSON) to an int for your class
* just copy country's value
* convert dialCode from number (in the JSON) to an NSString value 
* finally convert isInEurope to a BOOL for your BOOL property

And the good news is all you had to do is define the properties and their expected types.


-------
Examples
=======

#### Automatic name based mapping
<table>
<tr>
<td valign="top">
<pre>
{
  "ID": "1",
  "name": "Product name",
  "price": 12.95
}
</pre>
</td>
<td>
<pre>
@interface ProductModel : JSONModel
@property (assign, nonatomic) NSNumber<JMPrimaryKey> *ID;
@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) float price;
@end


</pre>
</td>
</tr>
</table>



```objective-c
#import "CountryModel.h"
...

NSString* json = (fetch here JSON from Internet) ... 
NSError* err = nil;
CountryModel* country = [[CountryModel alloc] initWithString:json error:&err];
[country JM_save];

CountryModel* countryYouJustSaved = [CountryModel JM_find:@1];
NSLog(@"%@", [model1 toDictionary]);

```

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
