function PackageIsInstalled($packageName)
{
	$searchResult = chocolatey search -lo $packageName
	$retVal = $searchResult.Contains("No packages found.")
	return $retVal
}

function PackageInstall($packageName)
{
	$decisionMade = $false;
	while($decisionMade -eq $false)
	{
		$option = Read-Host "Do you want to install ${packageName}? [Y]es [N]o [E]Exit"
		$option = $option -replace [Environment]::NewLine, ""
		if($option -eq "Y")
		{
			chocolatey install $packageName
			$decisionMade = $true
		}
		elseif($option -eq "N")
		{
			$decisionMade = $true
			echo "$packageName was not installed" 
		}
		elseif($option -eq "E")
		{
			$decisionMade = $true;
			echo "Exiting script..."
			exit 
		}
		else
		{
			echo "You should write Y for Yes or N for No. No other options are available" 
		}
	}
}

function CategoryInstall($categoryName, $packages)
{
	$decisionMade = $false;
	while($decisionMade -eq $false)
	{
		$option = Read-Host "Do you want to install ${categoryName}? [Y]es [N]o [E]Exit"
		$option = $option -replace [Environment]::NewLine, ""
		if($option -eq "Y")
		{
			foreach($package in $packages)
			{
				$decisionMade = $true
				PackageInstall($package)
			}
		}
		elseif($option -eq "N")
		{
			$decisionMade = $true
			echo "$categoryName was not installed" 
		}
		elseif($option -eq "E")
		{
			$decisionMade = $true;
			echo "Exiting script..."
			exit 
		}
		else
		{
			echo "You should write Y for Yes or N for No. No other options are available" 
		}
	}
	
}

$databaseServers = 
@(
	"SQLite", 
	"XAMPP", 
	#"MsSqlServer2012Express" Has issues on Chocolatey
)
					
$utilities = 
@(
	"7zip",
	"javaruntime",
	"vlc",
	"skype",
	"FoxitReader",
	"MicrosoftSecurityEssentials",
	"uTorrent",
	"steam",
	"TotalCommander",
	"unitywebplayer",
	"cpu-z",
	"libreoffice",
	"wincdemu",
	"dia",
	"dosbox",
	"clementine",
	"sharpkeys"
)

$programmingLanguages = 
@(
	"ruby.devkit",
	"ruby",
	"python",
	"nodejs",
	"cygwin",
	"mingw",
	"java.jdk",
	"mysql",
	"mono",
	"typescript",
	"ActivePerl",
	"gtksharp",
	"android-sdk"
)

$developerTools = 
@(
	"ConEmu",
	"notepad2",
	"tortoisehg",
	"PowerGUI",
	"webpi",
	"githubforwindows",
	"reflector",
	"autohotkey",
	"monodevelop",
	"VisualStudioExpress2013Web",
	"sharpdevelop"
	"eazfuscator.net",
	"intellijidea"
	"markdownpad2"
	"virtualbix"
)

$browsers = 
@(
	"GoogleChrome"
	"Firefox",
	"Opera",
	"safari"
)

CategoryInstall "database/servers" $databaseServers
CategoryInstall "programming languages and frameworks" $programmingLanguages
CategoryInstall "developer tools" $developerTools
CategoryInstall "utilities" $utilities
CategoryInstall "browsers" $browsers