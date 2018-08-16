# LandscapeDemo
觉得有帮助的同学可以点个star,支持某个页面横竖屏在HomePageController与HoneSecondController中，强制横屏在ListViewController中

Swift 支持某个页面横竖屏与强制横屏

首先需要清晰几个概念

* UIDeviceOrientation 设备的物理方向 

	* UIDeviceOrientation即我们手持的移动设备的Orientation，是一个三围空间，有六个方向

```
public enum UIDeviceOrientation : Int {

    case unknown

    case portrait // Device oriented vertically, home button on the bottom

    case portraitUpsideDown // Device oriented vertically, home button on the top

    case landscapeLeft // Device oriented horizontally, home button on the right

    case landscapeRight // Device oriented horizontally, home button on the left

    case faceUp // Device oriented flat, face up

    case faceDown // Device oriented flat, face down
}
```
* UIInterfaceOrientation 界面的显示方向
	* UIInterfaceOrientation即我们看到的视图的Orientation，可以理解为statusBar所在的方向，是一个二维空间，有四个方向

```
public enum UIInterfaceOrientation : Int {

    case unknown

    case portrait

    case portraitUpsideDown

    case landscapeLeft

    case landscapeRight
}
```



## 支持某个页面横竖屏切换
项目要求是要某个界面能够横竖屏显示，其他界面要竖屏显示
### 1.打开 General 中的 Device orientation 中的 landscapeLeft 与 landscapeRight
![avatar](https://upload-images.jianshu.io/upload_images/8042403-66f6bdc02757d4fb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/412)

<!-- more -->
### 2.在AppDelegate中设置app支持的方法
这里要设置一个全局变量，判断支持的方向

```
var blockRotation = Bool()

func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if blockRotation {
            return .allButUpsideDown
        }
        return .portrait
        
}
```

### 3.在需要支持横竖屏的控制器中

```
 let appDelegate = UIApplication.shared.delegate as! AppDelegate

```
在viewDidLoad或viewWillAppear中

```
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    appDelegate.blockRotation = true
 }
```
在viewWillDisAppear中

```
override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    appDelegate.blockRotation = false
    
    //判断退出时是否是横屏
    if UIApplication.shared.statusBarOrientation.isLandscape {
        //是横屏让变回竖屏
        setNewOrientation(fullScreen: false)
    }
    
}
```
退出时需要回到竖屏的状态

```
//横竖屏
    func setNewOrientation(fullScreen: Bool) {
        if fullScreen { //横屏
            let resetOrientationTargert = NSNumber(integerLiteral: UIInterfaceOrientation.unknown.rawValue)
            UIDevice.current.setValue(resetOrientationTargert, forKey: "orientation")
            
            let orientationTarget = NSNumber(integerLiteral: UIInterfaceOrientation.landscapeLeft.rawValue)
            UIDevice.current.setValue(orientationTarget, forKey: "orientation")
            
        }else { //竖屏
            let resetOrientationTargert = NSNumber(integerLiteral: UIInterfaceOrientation.unknown.rawValue)
            UIDevice.current.setValue(resetOrientationTargert, forKey: "orientation")
            
            let orientationTarget = NSNumber(integerLiteral: UIInterfaceOrientation.portrait.rawValue)
            UIDevice.current.setValue(orientationTarget, forKey: "orientation")
        }
    }
```

### 4.判断页面方向
横竖屏这里已经实现了，难处理的是横竖屏后界面视图的适配
用snapKit布局会方便很多，但有些布局，需要判断当前界面时竖屏还是横屏

```
//statusBar的朝向
UIApplication.shared.statusBarOrientation.isLandscape
```
* statusBarOrientation 有两个属性，isLandscape、isPortrait 用来判断是横屏还是竖屏，这是对页面的判断

在有弹出窗的时候，在窗口弹出时判断是横屏还是竖屏，分别做不同的布局

### 5.判断设备物理方便改变

```
//注册通知
        if !UIDevice.current.isGeneratingDeviceOrientationNotifications {
            //生成通知
            UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(handleDeviceOrientationChange(notification:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
```
实现通知的方法

```
@objc private func handleDeviceOrientationChange(notification: Notification) {
        
        let orientation = UIDevice.current.orientation
        
        switch orientation {
            
        case .portrait:
            
            /* iOS8之后,横屏UIScreen.main.bounds.width等于竖屏时的UIScreen.main.bounds.height
            
             let ScreenW = UIApplication.shared.statusBarOrientation.isLandscape ? UIScreen.main.bounds.size.height : UIScreen.main.bounds.size.width
             let ScreenH = UIApplication.shared.statusBarOrientation.isLandscape ? UIScreen.main.bounds.size.width : UIScreen.main.bounds.size.height
             
            ScreenW 记录的是屏幕短边的长度
            ScreenH 记录的是屏幕长边的长度
            */
            showLabel.frame = CGRect(x: 0, y: 0, width: ScreenW, height: 20)

        case .landscapeLeft:
            showLabel.frame = CGRect(x: 0, y: 0, width: ScreenW, height: 20)

            
        case .landscapeRight:
            //横屏后做界面的调整的代码
            showLabel.frame = CGRect(x: 200, y: 200, width: 80, height: 20)

            
        default:
            
            break
            
            
        }
    }
```
最后移除通知

```
deinit {
        //移除通知
        NotificationCenter.default.removeObserver(self)
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
```

* 这里用了两个判断：

	1. 判断当前页面是横屏还是竖屏  UIApplication.shared.statusBarOrientation.isLandscape  (页面方向)

	2. 判断当前手机发生了横屏切换还是竖屏切换：  通知的方法 let orientation =UIDevice.current.orientation （设备的方向） 在通知的方法里完成布局

项目中比demo中布局复杂，使用这两个判断结合的方式进行布局


## 强制横屏

### 1.关闭 General 中的 Device orientation 中的 landscapeLeft 与 landscapeRight
![avatar](https://upload-images.jianshu.io/upload_images/8042403-a4de37a2f441a945.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/286)

### 2.在AppDelegate中设置app支持的方法
这里要设置一个全局变量，判断支持的方向，这里支持一个方向

```
var blockRotation = Bool()

func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if blockRotation {
            return .landscapeLeft
        }
        return .portrait
        
}
```
### 3. 强制横屏方法
swift移除了NSInvocation, 只能桥接，需要创建桥接文件，注意桥接文件路径

```
// h文件
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DeviceTool : NSObject

+ (void)interfaceOrientation:(UIInterfaceOrientation )orientation;

@end


//m文件
#import "DeviceTool.h"

@interface DeviceTool ()

@end

@implementation DeviceTool

+ (void)interfaceOrientation:(UIInterfaceOrientation)orientation{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val  = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

@end

```

### 4.实现横屏
实现的是强制转landscapeLeft方向，与appDelegate中支持的方向一致，这样是否打开系统竖排方向锁定不影响强转方向

```
@objc func buttonClick(btn:UIButton) {
        btn.isSelected = !btn.isSelected
        if btn.isSelected {
            appDelegate.blockRotation = true
            DeviceTool.interfaceOrientation(.landscapeLeft)

        }else{
            appDelegate.blockRotation = false
            DeviceTool.interfaceOrientation(.portrait)
        }
    }

```
