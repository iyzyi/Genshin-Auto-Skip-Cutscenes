; 原神自动过剧情
; AutoHotKey文档：https://wyagd001.github.io/zh-cn/docs/AutoHotkey.htm


global SleepTimePerClick 	:= 100
global SleepTimePerLoop 	:= 400
global OnLooping 			:= 0

global XClickPos     := 1440
global YClickPos1	 := 720
global YClickPos2	 := 800

global ImageA 	:= "播放中.jpg"
global X1	 	:= 74
global Y1 		:= 27
global X2 		:= 117
global Y2 		:= 69

global ImageB 	:= "选项.jpg"
global X3 		:= 1273
global Y3 		:= 780
global X4 		:= 1317
global Y4 		:= 817


#MenuMaskKey vkFF				
; 修改默认模拟击键，否则按下win/alt松开之前，会默认触发Ctrl键
; Debug时可以使用KeyCastOW来测试具体按下什么键
; https://wyagd001.github.io/zh-cn/docs/Hotkeys.htm
; https://wyagd001.github.io/zh-cn/docs/commands/_MenuMaskKey.htm


if not A_IsAdmin
{
	MsgBox, 请使用管理员权限运行本程序。
	ExitApp
}


ClickWithSleep()
{
	MouseClick, , %XClickPos%, %YClickPos1%
	Sleep, %SleepTimePerClick%
	MouseClick, , %XClickPos%, %YClickPos2%
			
	Sleep, %SleepTimePerLoop%
}


Run()
{
	OnLooping = 1
	Loop
	{
		if (OnLooping = 0)
		{
			Return
		}
		else
		{
			pid := WinActive("ahk_exe YuanShen.exe")
			if (pid){
			
				ImageSearch, FoundX, FoundY, X1, Y1, X2, Y2, *64 %ImageA%
				
				if (ErrorLevel = 2){
					MsgBox 查找图像失败，请确保%ImageA%与本程序在同一目录下
					ExitApp
				}
				
				; 没找到%ImageA%的图像，则尝试查找%ImageB%
				else if (ErrorLevel = 1){		
	
					ImageSearch, FoundX, FoundY, X3, Y3, X4, Y4, *16 %ImageB%
					
					if (ErrorLevel = 2){
						MsgBox 查找图像失败，请确保%ImageB%与本程序在同一目录下
						ExitApp
					}
						
					; 同时也没找到%ImageB%的图像
					else if (ErrorLevel = 1){
						;			
					}
					
					; 找到了%ImageB%
					else
					{
						ClickWithSleep()
					}
				}
				
				; 找到了%ImageA%
				else
				{
					ClickWithSleep()
				}
			}
		}
	}
}


Stop()
{
	OnLooping = 0
}


; ***********快捷键***********

F10::
	Run()
Return

F12::
	Stop()
Return