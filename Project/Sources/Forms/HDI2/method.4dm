Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		InitInfo
		
		Init
	: (FORM Event:C1606.code=On Page Change:K2:54)
		
		If (FORM Get current page:C276=3)
			
			If ((Form:C1466.mails=Null:C1517) & (Form:C1466.IMAP.transporter#Null:C1517))
				Form:C1466.IMAP.selectBox("INBOX")
				Form:C1466.receiveMails:=cs:C1710.EmailDownloading.new(Form:C1466.IMAP.transporter;Form:C1466.numberMails;Form:C1466.IMAP.selectedBox)
				Form:C1466.receiveMails.startTimer()
			End if 
			
		End if 
		
	: (Form event code:C388=On Timer:K2:25)
		
		Form:C1466.receiveMails.startDownload()
		
End case 

