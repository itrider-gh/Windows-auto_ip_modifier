If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

$x = 0

while ($true) {

	C:\"Program Files"\OpenVPN\bin\openvpn-gui.exe --command disconnect_all

	Start-Sleep -Seconds 10

	Restart-NetAdapter -Name LAN -Confirm:$false

 	Start-Sleep -Seconds 10

	if($x -eq 0){
		C:\"Program Files"\OpenVPN\bin\openvpn-gui.exe --connect openvpn1.ovpn
		echo connected to Spain
		$x = 1
	}elseif($x -eq 1){
		C:\"Program Files"\OpenVPN\bin\openvpn-gui.exe --connect openvpn2.ovpn
		$x = 2
		echo connected to United States
	}elseif($x -eq 2){
		C:\"Program Files"\OpenVPN\bin\openvpn-gui.exe --connect openvpn3.ovpn
		echo connected to Chili
		$x = 3
	}elseif($x -eq 3){
		C:\"Program Files"\OpenVPN\bin\openvpn-gui.exe --connect openvpn4.ovpn
		echo connected to Colombia
		$x = 4
	}
	elseif($x -eq 4){
		C:\"Program Files"\OpenVPN\bin\openvpn-gui.exe --connect openvpn5.ovpn
		echo connected to Argentina
		$x = 0
	}
	Start-Sleep -Seconds 1800


}



