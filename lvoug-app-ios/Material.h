#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Material : NSManagedObject

@property (nonatomic, retain) NSNumber * event;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * url;

@end
