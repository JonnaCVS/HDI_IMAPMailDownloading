Class constructor
	var $1 : Object
	
	This:C1470._transporter:=$1
	// List of mailboxes returned by the server
	This:C1470._mailboxes:=This:C1470._transporter.getBoxList()
	// delimiter used by the server to separate mailboxe name
	This:C1470._separator:=This:C1470._transporter.getDelimiter()
	// id used to identify a mailbox name in the list
	This:C1470._UID:=cs:C1710.Counter.new()
	
	This:C1470._count:=cs:C1710.Counter.new()
	This:C1470._lvl:=1
	
	// Creation of a list to display the mailbox name in a hierarchical list
Function createList
	var $1; $lvl : Integer
	var $countTmp; $ref : Integer
	var $names : Collection
	var $mailCount : Text
	var $info : Object
	var $0; $listRef : Integer
	
	
	If (Count parameters:C259>0)
		$lvl:=$1
	Else 
		$lvl:=This:C1470._lvl
	End if 
	
	$listRef:=New list:C375
	
	$names:=Split string:C1554(This:C1470._mailboxes[This:C1470._count.value()].name; This:C1470._separator)
	
	// loop on all the mailboxes
	While (($names.length>=$lvl) & (This:C1470._mailboxes.length>This:C1470._count.value()))
		// test if it is necessary to create a new hierarchy
		If ($names.length>$lvl)
			$countTmp:=This:C1470._count.value()
			$ref:=This:C1470.createList($names.length)
			DELETE FROM LIST:C624(This:C1470._mailboxes[$countTmp-1].listRef; This:C1470._mailboxes[$countTmp-1].listId)
			$mailCount:=" ("+String:C10($info.mailCount)+")"
			// create a new hierarchy with the mailbox information 
			APPEND TO LIST:C376($listRef; $names[$names.length-2]+$mailCount; This:C1470._UID.inc(); $ref; False:C215)
			// add utils information in _mailboxes collection for the search
			This:C1470._mailboxes[$countTmp-1].listRef:=$listRef
			This:C1470._mailboxes[$countTmp-1].listId:=This:C1470._UID.value(); 
		Else   // add to the current hierarchy
			// Search the number of email in the mailbox
			$info:=This:C1470._transporter.getBoxInfo(This:C1470._mailboxes[This:C1470._count.value()].name)
			$mailCount:=" ("+String:C10($info.mailCount)+")"
			// add the mailbox information to the current hierachy
			APPEND TO LIST:C376($listRef; $names[$names.length-1]+$mailCount; This:C1470._UID.inc())
			// add utils information in _mailboxes collection for the search
			This:C1470._mailboxes[This:C1470._count.value()].listRef:=$listRef
			This:C1470._mailboxes[This:C1470._count.value()].listId:=This:C1470._UID.value(); 
		End if 
		
		If (This:C1470._count.inc()<This:C1470._mailboxes.length)
			$names:=Split string:C1554(This:C1470._mailboxes[This:C1470._count.value()].name; This:C1470._separator)
		End if 
		
	End while 
	
	This:C1470._count.dec()
	
	$0:=$listRef
	
	// Search mailbox information according to the hierarchical list Id
Function search
	
	var $mailbox : Collection
	var $listId; $1 : Integer
	var $0 : Object
	
	$listId:=$1
	
	// search bi listId in the _mailboxes collection
	$mailbox:=This:C1470._mailboxes.query("listId=:1"; $listId)
	
	If ($mailbox.length=0)
		$0:=Null:C1517
	Else 
		$0:=$mailbox[0]
	End if 
	
	
	
	