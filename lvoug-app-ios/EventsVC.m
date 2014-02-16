#import "EventsVC.h"
#import "APIClient.h"
#import "ImageHelper.h"

@interface EventsVC ()

@end

@implementation EventsVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSMutableArray *eventList = [[APIClient restClient] events];
    
    for (id event in eventList) {
        [self.events addObject:event];
    }
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:0.0-1.0 green:0.0-1.0 blue:0.0-1.0 alpha:0.5f]];
    // full length item delimiter hack
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
}

-(NSMutableArray*)events
{
    if (_events == nil) {
        _events = [[NSMutableArray alloc]init];
    }
    return _events;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.events count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"eventsCell"];
    
    NSDictionary *event = self.events [indexPath.row];
    
    cell.textLabel.text = [event objectForKey:@"title"];
    cell.detailTextLabel.text = [event objectForKey:@"description"];
    
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [event objectForKey:@"logo"]]];
    cell.imageView.image = [ImageHelper imageWithImage:[UIImage imageWithData: imageData] scaledToSize:CGSizeMake(40.0, 40.0)];
    
    return cell;
}

@end
