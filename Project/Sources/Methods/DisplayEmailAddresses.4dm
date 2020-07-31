//%attributes = {}
// Transform a collection of email address to a string to display it in the UI
// all the emails are converted as "name <emailAddress>" separated by ","
// $1 -> collection of email address object
// $0 -> string containing all the addresses as string

var $1; $addresses : Collection
var $0; $result : Text
var $address : Object

$addresses:=$1

If ($addresses=Null:C1517)
	$result:=""
Else 
	
	// string construction
	For each ($address; $addresses)
		
		If ($result#"")
			$result:=$result+", "
		End if 
		
		$result:=$result+String:C10($address.name)+" <"+String:C10($address.email)+">"
		
	End for each 
	
End if 
$0:=$result