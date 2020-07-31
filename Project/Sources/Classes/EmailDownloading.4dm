Class constructor
	var $1 : Object
	var $2 : Integer
	var $3 : Object
	
	This:C1470._transporter:=$1
	This:C1470._numberMails:=$2
	This:C1470._selectedBox:=$3
	This:C1470.mails:=Null:C1517
	
Function startTimer
	// Show the download message
	OBJECT SET VISIBLE:C603(*; "Download"; True:C214)
	
	// Set the timer to 1 to show the download message and start the receiving just after
	SET TIMER:C645(1)
	
	// Start receiving of the mail list according to the number of mail defined by Form.numberMails
Function startDownload
	// Stop the timer
	SET TIMER:C645(0)
	
	// Fills the mails collection with the list of the last "numberMails" emails received
	// Fills the list of attachements and the body if necessary of the first email of the list
	// Creation of the mail list. It contains just the mail header 
	This:C1470.receiveMails(This:C1470._transporter; This:C1470._numberMails)
	
	// Filled the list of attachements and the body if necessary of the first email of the list
	If (This:C1470.mails.length>0)
		Form:C1466.mail:=This:C1470.mails[0]
		// download the full mail to display the body
		This:C1470.downloadMail(Form:C1466.mail)
		
		// creation of the attachment list
		DisplayAttachments(Form:C1466.mail.attachments)
		LISTBOX SELECT ROW:C912(*; "List Box"; 1)
		// Display the text of html body
		ShowBody(DisplayEmailBody(Form:C1466.mail))
		
	End if 
	
	OBJECT SET VISIBLE:C603(*; "Download"; False:C215)
	
	// Receives the number of last mails asked by the user
Function receiveMails
	
	var $min; $i : Integer
	var $mail : Object
	
	// Search the list of emails and the information for each emails
	This:C1470.mails:=New collection:C1472
	If (This:C1470._selectedBox.mailCount>0)
		
		// calculation of the position of the first email to download
		$min:=This:C1470._selectedBox.mailCount-This:C1470._numberMails
		If ($min<=0)
			$min:=1
		End if 
		
		// Download of the last emails
		For ($i; $min; This:C1470._selectedBox.mailCount)
			// Download the email header. (it doesn't mark the email as read on the server)
			$mail:=This:C1470._transporter.getMail($i; New object:C1471("withBody"; False:C215; "updateSeen"; False:C215))
			// add the emal to the collection
			If ($mail#Null:C1517)
				This:C1470.mails.unshift($mail)
			End if 
		End for 
		
	End if 
	
	// download the full email
Function downloadMail
	
	var $mailTmp : Object
	var $mail; $1 : Object
	
	$mail:=$1
	
	// if the email has no body yet, we download it
	If ($mail.bodyValues=Null:C1517)
		$mailTmp:=This:C1470._transporter.getMail($mail.id; New object:C1471("updateSeen"; False:C215))
		// update of the mail object with the body information and attachments
		$mail.bodyValues:=$mailTmp.bodyValues
		$mail.bodyStructure:=$mailTmp.bodyStructure
		$mail.attachments:=$mailTmp.attachments
	End if 
	
	
	