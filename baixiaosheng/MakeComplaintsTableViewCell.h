//
//  MakeComplaintsTableViewCell.h
//  baixiaosheng
//
//  Created by 薛泽军 on 15/10/19.
//  Copyright © 2015年 薛泽军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakeComplaintsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *downView;
@property (strong,nonatomic)void (^myBtuSelect)(NSInteger tag);
@end
