; ԭ���Զ�������
; AutoHotKey�ĵ���https://wyagd001.github.io/zh-cn/docs/AutoHotkey.htm


global SleepTimePerClick 	:= 100
global SleepTimePerLoop 	:= 400
global OnLooping 			:= 0

global XClickPos     := 1440
global YClickPos1	 := 720
global YClickPos2	 := 800

global ImageA 	:= "������.jpg"
global X1	 	:= 74
global Y1 		:= 27
global X2 		:= 117
global Y2 		:= 69

global ImageB 	:= "ѡ��.jpg"
global X3 		:= 1273
global Y3 		:= 780
global X4 		:= 1317
global Y4 		:= 817


#MenuMaskKey vkFF				
; �޸�Ĭ��ģ�������������win/alt�ɿ�֮ǰ����Ĭ�ϴ���Ctrl��
; Debugʱ����ʹ��KeyCastOW�����Ծ��尴��ʲô��
; https://wyagd001.github.io/zh-cn/docs/Hotkeys.htm
; https://wyagd001.github.io/zh-cn/docs/commands/_MenuMaskKey.htm


if not A_IsAdmin
{
	MsgBox, ��ʹ�ù���ԱȨ�����б�����
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
					MsgBox ����ͼ��ʧ�ܣ���ȷ��%ImageA%�뱾������ͬһĿ¼��
					ExitApp
				}
				
				; û�ҵ�%ImageA%��ͼ�����Բ���%ImageB%
				else if (ErrorLevel = 1){		
	
					ImageSearch, FoundX, FoundY, X3, Y3, X4, Y4, *16 %ImageB%
					
					if (ErrorLevel = 2){
						MsgBox ����ͼ��ʧ�ܣ���ȷ��%ImageB%�뱾������ͬһĿ¼��
						ExitApp
					}
						
					; ͬʱҲû�ҵ�%ImageB%��ͼ��
					else if (ErrorLevel = 1){
						;			
					}
					
					; �ҵ���%ImageB%
					else
					{
						ClickWithSleep()
					}
				}
				
				; �ҵ���%ImageA%
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


; ***********��ݼ�***********

F10::
	Run()
Return

F12::
	Stop()
Return