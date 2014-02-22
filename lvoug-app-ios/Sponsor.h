#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event;

@interface Sponsor : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Event *eventSponsor;

@end
