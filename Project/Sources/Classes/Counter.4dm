Class constructor
	var $1 : Integer
	
	This:C1470._value:=0
	
	If (Count parameters:C259=1)
		This:C1470._value:=$1
	End if 
	
Function value
	var $0 : Integer
	$0:=This:C1470._value
	
Function inc
	var $0 : Integer
	This:C1470._value:=This:C1470._value+1
	$0:=This:C1470._value
	
Function dec
	var $0 : Integer
	This:C1470._value:=This:C1470._value-1
	$0:=This:C1470._value
	
Function reset
	var $1 : Integer
	If (Count parameters:C259=0)
		This:C1470._value:=0
	Else 
		This:C1470._value:=$1
	End if 
	