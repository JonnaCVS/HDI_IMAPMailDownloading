//%attributes = {}
// Search in the bodyStructure if a part with the asked type is present
// If a part with the good type is present returns the corresponding body present in the boyValues 
// $1 -> email in which to search
// $2 -> type of body 
// $0 -> body content if finded, else empty string

var $1; $email : Object
var $2; $type : Text
var $0; $message : Text
var $partId : Text
var $result : Collection

$email:=$1
$type:=$2



If ($email.bodyStructure.subParts#Null:C1517)
	
	// look up for all the subparts that contain the type
	$result:=$email.bodyStructure.subParts.query("type=:1"; $type)
	
	If ($result.length>0)
		
		// we take the first subpart with the searched type
		$partId:=String:C10($result[0].partId)
		
	End if 
	
End if 

If ($partId#"")
	
	$message:=String:C10($email.bodyValues[$partId].value)
	
End if 

$0:=$message