//---------------------------------------------------------------------------

#include <vcl.h>
#include <vfw.h>
#include <math.h>
#include "IniFiles.hpp"
#include <time.h>
#pragma hdrstop

#include "programming.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "trayicon"
#pragma resource "*.dfm"
TForm1 *Form1;
AnsiString path = ExtractFilePath(Application->ExeName) + "OPTIONS.ini";
TIniFile *Ini = new TIniFile(path);
HWND hwndPreview;
bool preview = true;
bool messageExit;
bool tray = false;
int delta = 10;
int threshold = 15;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
	: TForm(Owner) {
}
//---------------------------------------------------------------------------
TModalResult CheckMessageDialog(AnsiString Message, AnsiString Caption,
                                AnsiString CheckBoxCaption, bool *Checked,
                                TMsgDlgType DlgType, TMsgDlgButtons Buttons) {
	TForm *Dialog=CreateMessageDialog(Message, DlgType, Buttons);
	if (!Caption.IsEmpty()) Dialog->Caption = Caption;

	int LeftEdge=Dialog->ClientWidth;
	int TopEdge =Dialog->ClientHeight;
	if (Dialog->ControlCount>0) {
		for (int i = 1; i < Dialog->ControlCount; i++) {
			TControl *Ctrl=Dialog->Controls[i];
			if (Ctrl->Left < LeftEdge) LeftEdge=Ctrl->Left;
			if (Ctrl->Top  < TopEdge)  TopEdge =Ctrl->Top;
		}
	} else {
		LeftEdge=10;
		TopEdge=10;
	}

	TCheckBox * CheckBox = new TCheckBox(Dialog);
	CheckBox->Parent  = Dialog;
	CheckBox->Caption = CheckBoxCaption;
	CheckBox->Checked = *Checked;
	CheckBox->Left    = LeftEdge;
	CheckBox->Top     = Dialog->ClientHeight;
	CheckBox->Width   = Dialog->Canvas->TextWidth(CheckBox->Caption)+30;

	Dialog->ClientHeight = Dialog->ClientHeight + CheckBox->Height + TopEdge;

	if (CheckBox->Width + LeftEdge*2 > Dialog->ClientWidth)
		Dialog->ClientWidth = CheckBox->Width + LeftEdge*2;

	TModalResult Result = Dialog->ShowModal();
	*Checked = CheckBox->Checked;

	delete Dialog;
	Dialog=NULL;

	return Result;
}

void __fastcall TForm1::FormCreate(TObject *Sender) {
	hwndPreview = capCreateCaptureWindow (
	                  TEXT("My Capture Window"),
	                  WS_CHILD | WS_VISIBLE,
	                  0, 0,
	                  Panel1->Width,
	                  Panel1->Height,
	                  (HWND) Panel1->Handle, 0);

	if(hwndPreview != NULL) {
		if(!capDriverConnect(hwndPreview, 0))
			ShowMessage("Ошибка при подключении к веб-камере!");
		capPreviewScale(hwndPreview, true);
		capPreviewRate(hwndPreview, 66);
		capPreview(hwndPreview, true);
	} else {
		ShowMessage("Ошибка при создании окна вебки!");
	}
	EditPeriod->Text = Ini->ReadString("Settings", "period", "1");
	threshold = Ini->ReadInteger("Settings", "threshold", 20);
	EditThreshold->Text = threshold;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::FormCloseQuery(TObject *Sender, bool &CanClose) {
	if(!tray) {
		messageExit = Ini->ReadBool("Settings", "MessageExit", true);
		TModalResult res = Ini->ReadInteger("Settings", "OptionExit", mrYes);

		if(messageExit) {
			bool checkv=false;  //checkbox  value
			res = CheckMessageDialog(
			          "Свернуть программу в поддон?",
			          "Вопрос всей жизни",
			          "Запомнить мой ответ",
			          &checkv,
			          mtConfirmation,
			          TMsgDlgButtons() << mbYes << mbNo  << mbCancel);
			if(checkv && res != mrCancel) {
				Ini->WriteBool("Settings", "MessageExit", false);
				Ini->WriteInteger("Settings", "OptionExit", res);
				messageExit = false;
			}
		}

		switch(res) {
		case mrYes:
			CanClose = false;
			capPreview(hwndPreview, false);
			TrayIcon1->Minimize();
			break;
		case mrCancel:
			CanClose = false;
			break;
		case mrNo:
			CanClose = true;
			delete Ini;
			break;
		}
	}
}

//---------------------------------------------------------------------------

void __fastcall TForm1::ButtonSettingsClick(TObject *Sender) {
	if(preview)
		capPreview(hwndPreview, false);
	capDlgVideoFormat(hwndPreview);
	preview = true;
	capPreview(hwndPreview, true);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ButtonPreviewClick(TObject *Sender) {
	preview = preview ? false : true;
	capPreview(hwndPreview, preview);
}
//---------------------------------------------------------------------------


void __fastcall TForm1::ButtonResetClick(TObject *Sender) {
	Ini->EraseSection("Settings");
	messageExit = true;
	EditPeriod->Text = "1";
	EditThreshold->Text = "20";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ButtonScreenshotClick(TObject *Sender) {
	AnsiString name = "screen_" + FormatDateTime("ddmmmyyyy_hh_mm_ss",Now()) + ".bmp";
	AnsiString path = ExtractFilePath(Application->ExeName) + "screenshots\\" + name;
	if(!DirectoryExists("screenshots"))
		CreateDir("screenshots");
	capFileSaveDIB(hwndPreview, path.c_str());
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Timer1Timer(TObject *Sender) {
	int t = clock();

	capFileSaveDIB(hwndPreview, "temp1.bmp");
	Graphics::TBitmap* bmp1 = new Graphics::TBitmap;
	bmp1->LoadFromFile("temp1.bmp");
	Graphics::TBitmap* bmp2 = new Graphics::TBitmap;
	if(FileExists("temp2.bmp")) {
		bmp2->LoadFromFile("temp2.bmp");

		int badPixels = 0, sizeImage = bmp1->Height*bmp1->Width;
		for(int i = 0; i < bmp1->Height; i+=2)
			for(int j = 0; j < bmp1->Width; j+=2) {
				if(fabs(GetRValue(bmp1->Canvas->Pixels[i][j]) -
				        GetRValue(bmp2->Canvas->Pixels[i][j])) > delta)
					badPixels++;
				if(fabs(GetGValue(bmp1->Canvas->Pixels[i][j]) -
				        GetGValue(bmp2->Canvas->Pixels[i][j])) > delta)
					badPixels++;
				if(fabs(GetBValue(bmp1->Canvas->Pixels[i][j]) -
				        GetBValue(bmp2->Canvas->Pixels[i][j])) > delta)
					badPixels++;
			}
		float tresh = ((float)badPixels / sizeImage) * 100.;
		if(tresh > threshold) {
			AnsiString name = "attention_" + FormatDateTime("ddmmmyyyy_hh_mm_ss",Now()) + ".bmp";
			AnsiString path = ExtractFilePath(Application->ExeName) + "attention\\" + name;
			if(!DirectoryExists("attention"))
				CreateDir("attention");
			CopyFile("temp1.bmp", path.c_str(), true);
			LabelAttention->Caption = "!!!!!!!!!!!!";
		}
		LabelThreshold->Caption = tresh;
	}
	if(FileExists("temp1.bmp"))
		MoveFileEx("temp1.bmp", "temp2.bmp", MOVEFILE_REPLACE_EXISTING);

	Label4->Caption = (clock()-t)/CLOCKS_PER_SEC;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ButtonSaveClick(TObject *Sender) {
	bool q = Timer1->Enabled;
	try {
		if(q)
			Timer1->Enabled = false;
		int temp = EditPeriod->Text.ToInt();
		Timer1->Interval = temp * 1000;
		Ini->WriteInteger("Settings", "period", temp);
		if(q)
			Timer1->Enabled = true;
		Ini->WriteInteger("Settings", "threshold", EditThreshold->Text.ToInt());
	} catch(...) {
		ShowMessage("Введите значение в минутах");
	}
}
//---------------------------------------------------------------------------

void __fastcall TForm1::TrayIcon1Restore(TObject *Sender) {
	if(preview)
		capPreview(hwndPreview, true);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ButtonDirScreenClick(TObject *Sender) {
	if(!DirectoryExists("screenshots"))
		CreateDir("screenshots");
	AnsiString screenshots = ExtractFilePath(Application->ExeName)+"\\screenshots\\";
	ShellExecute(NULL, "open", screenshots.c_str(), NULL,NULL,SW_SHOWNORMAL);
}
//---------------------------------------------------------------------------


void __fastcall TForm1::N3Click(TObject *Sender) {
	tray = true;
	Form1->Close();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::N2Click(TObject *Sender) {
	Timer1->Enabled = false;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::N1Click(TObject *Sender) {
	TrayIcon1->Restore();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::N4Click(TObject *Sender) {
	if(Timer1->Enabled)
		Timer1->Enabled = false;
	Timer1->Enabled = true;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ButtonStartClick(TObject *Sender) {
	if(Timer1->Enabled)
		Timer1->Enabled = false;
	Timer1->Enabled = true;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ButtonStopClick(TObject *Sender) {
	Timer1->Enabled = false;
	LabelAttention->Caption = "";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::ButtonDirAttentionClick(TObject *Sender) {
	if(!DirectoryExists("attention"))
		CreateDir("attention");
	AnsiString screenshots = ExtractFilePath(Application->ExeName)+"\\attention\\";
	ShellExecute(NULL, "open", screenshots.c_str(), NULL,NULL,SW_SHOWNORMAL);
}
//---------------------------------------------------------------------------

