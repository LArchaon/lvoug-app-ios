#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event;

@interface Contact : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * surname;
@property (nonatomic, retain) NSString * telephone;
@property (nonatomic, retain) Event *eventContact;

@end
