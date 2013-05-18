//
//  BoardViewController.h
//  ArenaBlock
//
//  Created by Clement Yerochewski on 18/05/13.
//  Copyright (c) 2013 beMyApp. All rights reserved.
//

#import "ADBGridView.h"

@interface BoardViewController : UIViewController<ADBGridViewDelegate> {
   IBOutlet ADBGridView *gridView;
}

@end
