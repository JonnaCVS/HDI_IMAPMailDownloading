
If (FORM Event:C1606.code=On Selection Change:K2:29)
	Form:C1466.receiveMails.downloadMail(Form:C1466.mail)
	DisplayAttachments(Form:C1466.mail.attachments)
	ShowBody(DisplayEmailBody(Form:C1466.mail))
End if 