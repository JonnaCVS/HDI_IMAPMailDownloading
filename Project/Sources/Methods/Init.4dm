//%attributes = {}
Form:C1466.mail:=New object:C1471
Form:C1466.mail.from:=""
Form:C1466.mail.to:=""
Form:C1466.mail.cc:=""
Form:C1466.mail.subject:=""

Form:C1466.IMAP:=cs:C1710.Transporter.new()

//Form.IMAP.logFile:="IMAP.log"

OBJECT SET FONT:C164(*;"Password";"%password")
OBJECT SET FONT:C164(*;"Password2";"%password")

Form:C1466.numberMails:=10

Form:C1466.loadEmails:=0

ARRAY TEXT:C222(Attachments;0)

ShowBoxInfo(False:C215)
