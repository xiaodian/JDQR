//
//  QRController.m
//  JDQR
//
//  Created by raoyuanjie on 14-10-14.
//  Copyright (c) 2014年 raoyuanjie. All rights reserved.
//

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


#define BOUNDS          self.view.bounds
#define SCREENBOUNDS    [UIScreen mainScreen].bounds
#define VIEW_X          CGRectGetMinX(self.frame)
#define VIEW_Y          CGRectGetMinY(self.frame)
#define VIEW_WIDTH      CGRectGetWidth(self.frame)
#define VIEW_HEIGHT     CGRectGetHeight(self.frame)
#define SCREEN_WIDTH    CGRectGetWidth([[UIScreen mainScreen] bounds])
#define SCREEN_HEIGHT   CGRectGetHeight([[UIScreen mainScreen] bounds])

#define NavigationBarHeight 44.
#define statusBar   20.

#define Degrees2Radians(degrees) ((degrees) * M_PI / 180)

#define NavigationBarColor [UIColor colorWithRed:156 /255.0 green:219 /255.0 blue:214 / 255.0 alpha:1]
#define CellBlueTextColor [UIColor colorWithRed:22 /255. green:126 /255. blue:255 / 255. alpha:1]
#define CellGrayTextColor [UIColor colorWithRed:78 /255. green:78 /255. blue:78 /255. alpha:1]
#define CellOrangeTextColor [UIColor colorWithRed:250 /255. green:135 /255. blue:0 alpha:1]
//得到视图的left top的X,Y坐标点
#define VIEW_TX(view) (view.frame.origin.x)
#define VIEW_TY(view) (view.frame.origin.y)
//得到视图的right bottom的X,Y坐标点
#define VIEW_BX(view) (view.frame.origin.x + view.frame.size.width)
#define VIEW_BY(view) (view.frame.origin.y + view.frame.size.height )

//得到视图的尺寸:宽度、高度
#define VIEW_W(view)  (view.frame.size.width)
#define VIEW_H(view)  (view.frame.size.height)
//得到frame的X,Y坐标点
#define FRAME_TX(frame)  (frame.origin.x)
#define FRAME_TY(frame)  (frame.origin.y)
//得到frame的宽度、高度
#define FRAME_W(frame)  (frame.size.width)
#define FRAME_H(frame)  (frame.size.height)