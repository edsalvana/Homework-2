//
//  TableViewController.m
//  homework2
//
//  Created by Ed Salvana on 2/23/14.
//  Copyright (c) 2014 Ed Salvana. All rights reserved.
//

#import "TableViewController.h"
#import "CustomCell.h"
#import "NotificationModel.h"

@interface TableViewController ()
@property(nonatomic, assign) int cellHeight;
@property (strong, nonatomic) NSMutableArray *notifications;
@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //setup navigation bar
    [self.navigationItem setTitle:@"Notifications"];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:65.0/255.0 green:95.0/255.0 blue:156.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;  //set bar style to white
    
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],
                                    NSForegroundColorAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;  //set bar style to white
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:nil];
    NSArray *actionButtonItems = @[shareItem];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    
    
    self.cellHeight = 80;
    
    //create reference to the notifications
    self.notifications = [NotificationModel notificationDetails ];
    
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    
    //get rid of default insets
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    //use custom nib CustomCell
    UINib *customNib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
    [self.tableView registerNib:customNib forCellReuseIdentifier:@"CustomCell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.notifications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NotificationModel *notification = self.notifications[indexPath.row];
    
    //SET PROFILE IMAGE
    UIImage *profileImage = [UIImage imageNamed:notification.profileImageURL];
    [ cell.profileImage setImage:profileImage];
    
    //SET NOTIFICATION MESSAGE
    NSString *text = notification.notificationMessage;
    NSString *styledText = [self styledHTMLwithHTML:text];
    NSAttributedString *attributedText = [self attributedStringWithHTML:styledText];
    cell.notificationLabel.attributedText  = attributedText;
    
    //SET NOTIFICATION TIME
    text = notification.notificationTime;
    styledText = [self styledHTMLwithHTML:text];
    attributedText = [self attributedStringWithHTML:styledText];
    cell.timeLabel.attributedText  = attributedText;
    
    //SET ICON IMAGE
    UIImage *iconImage = [UIImage imageNamed:notification.notificationIconURL];
    [ cell.notificationIcon setImage:iconImage];
    
    //get original positions for items for reference
    int iconX = cell.notificationIcon.frame.origin.x;
    int iconY = cell.notificationIcon.frame.origin.y;
    int notificationLabelX = cell.notificationLabel.frame.origin.x;
    int notificationLabelY = cell.notificationLabel.frame.origin.y;
    int timeLabelX = cell.timeLabel.frame.origin.x;
    int timeLabelY = 52; //<--- this gets janky if we dynamically get it
    
  
    //SIZE TO FIT NOTIFICATION LABEL
    [cell.notificationLabel sizeToFit];
    [cell.timeLabel sizeToFit];
    int numLines = (int)(cell.notificationLabel.frame.size.height/16); //get the number of lines
    
    //NSLog(@"notificationTextHeight:%d", notificationTextHeight);
    //NSLog(@"numLines:%d", numLines);
    

   
    //do adjustments based on number of lines, there is some weirdness going on here
    if( numLines < 3 ){
        cell.notificationLabel.frame = CGRectMake( notificationLabelX, notificationLabelY,  225, 50);
        cell.timeLabel.frame = CGRectMake( timeLabelX, timeLabelY - 15,  225, 50);
    } else {
        cell.notificationIcon.frame  = CGRectMake( iconX, iconY + 3,  16, 16);
        cell.timeLabel.frame = CGRectMake( timeLabelX, timeLabelY - 12,  225, 50);
        cell.notificationLabel.frame = CGRectMake( notificationLabelX, notificationLabelY + 3,  225, 50);
    }
   
    return cell;
}

- (NSString *)styledHTMLwithHTML:(NSString *)HTML {
    NSString *style = @"<meta charset=\"UTF-8\"><style> body { font-family: 'HelveticaNeue'; font-size: 14px; color:#141823 } b {font-family: 'HelveticaNeue'; font-weight:bold; } small {font-family: 'HelveticaNeue'; font-size: 12px; color:#adb2bb}</style>";
    
    return [NSString stringWithFormat:@"%@%@", style, HTML];
}

- (NSAttributedString *)attributedStringWithHTML:(NSString *)HTML {
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType };
    return [[NSAttributedString alloc] initWithData:[HTML dataUsingEncoding:NSUTF8StringEncoding] options:options documentAttributes:NULL error:NULL];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
