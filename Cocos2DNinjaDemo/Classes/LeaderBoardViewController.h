//
//  LeaderBoardViewController.h
//  Cocos2DSimpleGame
//
//  Created by shephertz technologies on 14/03/13.
//
//

#import <UIKit/UIKit.h>

@interface LeaderBoardViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UIButton *backButton;
    IBOutlet UITableView *userRecordsTableView;
    NSMutableArray *scoreList;
}
@end
