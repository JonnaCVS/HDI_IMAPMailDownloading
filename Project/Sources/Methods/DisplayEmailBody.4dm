//%attributes = {}
//  Determines the body to display
//  Search in first if HTML body is present.
// Else search a Text body

var $1; $email : Object
var $0 : Object
var $message; $type : Text

$email:=$1

// Looking for a HTML body
$type:="text/html"
$message:=SearchBodyByType($email; $type)

If ($message="")
	// Looking for a text body
	$type:="text/plain"
	$message:=SearchBodyByType($email; $type)
End if 

$0:=New object:C1471("message"; $message; "type"; $type)

