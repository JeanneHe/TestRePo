//
//  XSFontConfig.h
//  XSSPH
//
//  Created by NEW on 16/4/27.
//  Copyright © 2016年 Jeanne. All rights reserved.
//

#ifndef  XSFontConfig_h
#define  XSFontConfig_h

#define THIN  1         //是否是细字体


#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)

#if THIN

// 最细
#define  K_FONT_LIGHT(size)         ((K_SYSTEM_VERSION>=8.2)?[UIFont systemFontOfSize:AUTOSIZEIPHONE6(size) weight:UIFontWeightThin]:[UIFont systemFontOfSize:AUTOSIZEIPHONE6(size)])
// 正常体
#define  K_FONT(size)         ((K_SYSTEM_VERSION>=8.2)?[UIFont systemFontOfSize:AUTOSIZEIPHONE6(size) weight:UIFontWeightLight]:[UIFont systemFontOfSize:AUTOSIZEIPHONE6(size)])
// 粗体
#define  K_FONT_BOLD(size)     ((K_SYSTEM_VERSION>=8.2)?[UIFont systemFontOfSize:AUTOSIZEIPHONE6(size) weight:UIFontWeightRegular]:[UIFont boldSystemFontOfSize:AUTOSIZEIPHONE6(size)])
// 更粗
#define  K_FONT_BOLDER(size)         ((K_SYSTEM_VERSION>=8.2)?[UIFont systemFontOfSize:AUTOSIZEIPHONE6(size) weight:UIFontWeightHeavy]:[UIFont boldSystemFontOfSize:AUTOSIZEIPHONE6(size)])

#else

#define  K_FONT(size)           [UIFont systemFontOfSize:AUTOSIZEIPHONE6(size)]
#define  K_FONT_BOLD(size)      [UIFont boldSystemFontOfSize:AUTOSIZEIPHONE6(size)]

#endif


//普通
#define  K_FONT_36   K_FONT(18)          //用于重要级、标题、需要强调的文字信息

#define  K_FONT_34   K_FONT(17)          //用于重要级、标题、需要强调的文字信息

#define  K_FONT_32   K_FONT(16)          //用于标题性文字信息

#define  K_FONT_30   K_FONT(15)          //用于小标题文字信息

#define  K_FONT_28   K_FONT(14)          //用于普通级文字信息

#define  K_FONT_26   K_FONT(13)          //用于普通级文字信息

#define  K_FONT_24   K_FONT(12)          //用于普通级、非重要级文字信息

#define  K_FONT_22   K_FONT(11)          //用于普通级、非重要级文字信息

#define  K_FONT_20   K_FONT(10)          //用于辅助、提示文字信息

#define  K_FONT_16   K_FONT(8)          //用于普通级、非重要级文字信息

#define  K_FONT_18   K_FONT(9)          //用于普通级、非重要级文字信息

#define  K_FONT_40   K_FONT(20)          //用于辅助、提示文字信息

#define  K_FONT_44   K_FONT(22)

#define  K_FONT_48   K_FONT(24)



//加粗
#define  K_BFONT_38  K_FONT_BOLD(19)     //用于重要级、标题、需要强调的文字信息

#define  K_BFONT_36  K_FONT_BOLD(18)     //用于重要级、标题、需要强调的文字信息

#define  K_BFONT_34  K_FONT_BOLD(17)     //用于重要级、标题、需要强调的文字信息

#define  K_BFONT_32  K_FONT_BOLD(16)     //用于标题性文字信息

#define  K_BFONT_30  K_FONT_BOLD(15)     //用于小标题文字信息

#define  K_BFONT_28  K_FONT_BOLD(14)     //用于普通级文字信息

#define  K_BFONT_26  K_FONT_BOLD(13)     //用于普通级文字信息

#define  K_BFONT_24  K_FONT_BOLD(12)     //用于普通级、非重要级文字信息

#define  K_BFONT_22  K_FONT_BOLD(11)     //用于辅助、提示文字信息

#define  K_BFONT_20  K_FONT_BOLD(10)     //用于辅助、提示文字信息

#define  K_BFONT_40  K_FONT_BOLD(20)

#define  K_BFONT_42  K_FONT_BOLD(21)

#define  K_BFONT_44  K_FONT_BOLD(22)

#define  K_BFONT_46  K_FONT_BOLD(23)

#define  K_BFONT_48  K_FONT_BOLD(24)

#define  K_BFONT_52  K_FONT_BOLD(26)

#define  K_BFONT_60  K_FONT_BOLD(30)

#define  K_BFONT_62  K_FONT_BOLD(31)

#define  K_BFONT_80  K_FONT_BOLD(40)

#define  K_BFONT_96  K_FONT_BOLD(48)

#define  K_BFONT_120  K_FONT_BOLD(60)



// 特粗
#define K_BBFONT_100 K_FONT_BOLDER(50)

#define K_BBFONT_90 K_FONT_BOLDER(45)

#define K_BBFONT_60 K_FONT_BOLDER(30)

#define K_BBFONT_58 K_FONT_BOLDER(29)

#define K_BBFONT_48 K_FONT_BOLDER(24)

#define K_BBFONT_50 K_FONT_BOLDER(25)

#define K_BBFONT_46 K_FONT_BOLDER(23)

#define K_BBFONT_30 K_FONT_BOLDER(15)

#define K_BBFONT_32 K_FONT_BOLDER(16)

#define K_BBFONT_34 K_FONT_BOLDER(17)

#define K_BBFONT_36 K_FONT_BOLDER(18)

#define K_BBFONT_38 K_FONT_BOLDER(19)

#define K_BBFONT_24 K_FONT_BOLDER(12)

#define K_BBFONT_26 K_FONT_BOLDER(13)

#define K_BBFONT_28 K_FONT_BOLDER(14)

#define K_BBFONT_40 K_FONT_BOLDER(20)



#endif /* XSFontConfig_h */
