$pssnapinsPath = "C:\Program Files (x86)\Microsoft SQL Server\110\Tools\PowerShell\Modules\SQLPS\";
$psprovider = "C:\Program Files (x86)\Microsoft SQL Server\110\Tools\PowerShell\Modules\SQLPS\";
$framework=$([System.Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory())
Set-Alias installutil "$($framework)installutil.exe"
cd $pssnapinsPath
installutil Microsoft.SqlServer.Management.PSSnapins.dll
cd $psprovider
installutil Microsoft.SqlServer.Management.PSProvider.dll
Add-PSSnapin SqlServerCmdletSnapin100
Add-PSSnapin SqlServerProviderSnapin100