#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event;

@interface Material : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) Event *eventMaterial;

@end
