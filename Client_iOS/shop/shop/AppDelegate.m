//
//                       __
//                      /\ \   _
//    ____    ____   ___\ \ \_/ \           _____    ___     ___
//   / _  \  / __ \ / __ \ \    <     __   /\__  \  / __ \  / __ \
//  /\ \_\ \/\  __//\  __/\ \ \\ \   /\_\  \/_/  / /\ \_\ \/\ \_\ \
//  \ \____ \ \____\ \____\\ \_\\_\  \/_/   /\____\\ \____/\ \____/
//   \/____\ \/____/\/____/ \/_//_/         \/____/ \/___/  \/___/
//     /\____/
//     \/___/
//
//	Powered by BeeFramework
//

#import "AppDelegate.h"
#import "AppBoard_iPad.h"
#import "AppBoard_iPhone.h"

#import "controller.h"
#import "model.h"
#import "ecmobile.h"
#import "MobClick.h"

#import "bee.services.alipay.h"
#import "bee.services.location.h"
#import "bee.services.share.weixin.h"
#import "bee.services.share.sinaweibo.h"
#import "bee.services.share.tencentweibo.h"
#import "bee.services.wizard.h"
#import "bee.services.siri.h"
#import "bee.services.push.h"

@implementation AppDelegate

#pragma mark -

- (void)load
{
	[[UIApplication sharedApplication] setStatusBarHidden:NO];
	
	bee.ui.config.ASR = YES;		// Signal自动路由
	bee.ui.config.iOS6Mode = YES;	// iOS6.0界面布局
	
	[[BeeUITemplateManager sharedInstance] preloadResources];
	[[BeeUITemplateManager sharedInstance] preloadPackages];

//	[AddressListModel	sharedInstance];
	[ArticleGroupModel	sharedInstance];
	[BannerModel		sharedInstance];
	[CartModel			sharedInstance];
	[CategoryModel		sharedInstance];
	[ConfigModel		sharedInstance];
	[UserModel			sharedInstance];

	// 配置ECSHOP
	[ServerConfig sharedInstance].url = @"http://eg.weixini.net/ecmobile/?url=";

//	// 配置自动刷新
//	[bee.services.liveload.class setDefaultStyleFile:LIVE_UI_ABSOLUTE_PATH(@"view_iPhone/resource/css/default.css")];

	// 配置闪屏
	bee.services.wizard.config.showBackground = YES;
	bee.services.wizard.config.showPageControl = YES;
	bee.services.wizard.config.backgroundImage = [UIImage imageNamed:@"tuitional_bg.jpg"];
	bee.services.wizard.config.pageDotSize = CGSizeMake( 11.0f, 11.0f );
	bee.services.wizard.config.pageDotNormal = [UIImage imageNamed:@"tuitional-carousel-active-btn.png"];
	bee.services.wizard.config.pageDotHighlighted = [UIImage imageNamed:@"tuitional-carousel-btn.png"];
	bee.services.wizard.config.pageDotLast = [UIImage imageNamed:@"tuitional-carousel-btn-last.png"];

	bee.services.wizard.config.splashes[0] = @"wizard_1.xml";
	bee.services.wizard.config.splashes[1] = @"wizard_2.xml";
	bee.services.wizard.config.splashes[2] = @"wizard_3.xml";
	bee.services.wizard.config.splashes[3] = @"wizard_4.xml";
	bee.services.wizard.config.splashes[4] = @"wizard_5.xml";
	
	// 配置提示框
	{
		[BeeUITipsCenter setDefaultContainerView:self.window];
		[BeeUITipsCenter setDefaultBubble:[UIImage imageNamed:@"alertBox.png"]];
		[BeeUITipsCenter setDefaultMessageIcon:[UIImage imageNamed:@"icon.png"]];
		[BeeUITipsCenter setDefaultSuccessIcon:[UIImage imageNamed:@"icon.png"]];
		[BeeUITipsCenter setDefaultFailureIcon:[UIImage imageNamed:@"icon.png"]];
	}

	// 配置导航条
	{
		[BeeUINavigationBar setTitleColor:[UIColor whiteColor]];
		[BeeUINavigationBar setBackgroundColor:[UIColor blackColor]];
		
		if ( IOS7_OR_LATER )
		{
			[BeeUINavigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_iphone5.png"]];
		}
		else
		{
			[BeeUINavigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"]];
		}
	}
	
	[self updateConfig];
	
	self.window.rootViewController = [AppBoard_iPhone sharedInstance];
	
	[MobClick appLaunched];
}

- (void)unload
{
	[self unobserveAllNotifications];
	
	[MobClick appTerminated];
}

#pragma mark -

- (void)updateConfig
{
	ALIAS( bee.services.share.weixin,		weixin );//初始化 weixin类对象
	ALIAS( bee.services.share.tencentweibo,	tweibo );
	ALIAS( bee.services.share.sinaweibo,	sweibo );
	ALIAS( bee.services.alipay,				alipay );
	ALIAS( bee.services.siri,				siri );
	ALIAS( bee.services.location,			lbs );
	
	// 配置微信
	weixin.config.appId			= @"<Your information>";
	weixin.config.appKey		= @"<Your information>";
	
	// 配置新浪
	sweibo.config.appKey		= @"<Your information>";
	sweibo.config.appSecret		= @"<Your information>";
	sweibo.config.redirectURI	= @"<Your information>";
	
	// 配置腾讯
	tweibo.config.appKey		= @"<Your information>";
	tweibo.config.appSecret		= @"<Your information>";
	tweibo.config.redirectURI	= @"<Your information>";
	
	// 配置支付宝
	alipay.config.parnter		= @"<Your information>";
	alipay.config.seller		= @"<Your information>";
	alipay.config.privateKey	= @"<Your information>";
	alipay.config.publicKey		= @"<Your information>";
	alipay.config.notifyURL		= @"<Your information>";
	
	// 配置语音识别
	siri.config.showUI			= NO;
	siri.config.appID			= @"<Your information>";
	
	// 配置友盟
	[MobClick setAppVersion:[BeeSystemInfo appShortVersion]];
	[MobClick setCrashReportEnabled:YES];
	[MobClick setLatitude:lbs.location.coordinate.latitude longitude:lbs.location.coordinate.longitude];
	[MobClick setLocation:lbs.location];
	[MobClick startWithAppkey:@"<Your information>"
				 reportPolicy:BATCH
					channelId:[BeeSystemInfo appIdentifier]];
}

@end
