<?php
function makePass ($pass){
	$str  = array_merge(range('a', 'z'), range('0', '9'), range('A', 'Z'),array(".","/"));
	$salt = "$2y$10$";
	for($i=0; $i<22; $i++){
		$salt .= $str[rand(0,count($str)-1)];
	}
	$salt .= "$";
	$hash = crypt($password, $salt);

  return $hash;
}
?>
