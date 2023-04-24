param(
$path, # the Path of the Solution.xml file
$buildversion, # use this build version number to update
$workspacePath # the path where we save Power Platform Cli installation file
)

# Download  Power Platform CLI and save it in $workspacePath
Invoke-WebRequest -Uri https://aka.ms/PowerAppsCLI  -OutFile $workspacePath\PACInstaller.msi
dir 

# Runn the .msi file
$argementList = "/I "+$workspacePath+"\PACInstaller.msi /quiet"
$p = Start-Process msiexec.exe -Wait -NoNewWindow  -Passthru -ArgumentList $argementList -RedirectStandardOutput stdout.txt -RedirectStandardError stderr.txt
dir

# Reload the new envrionment Path to bring pac command available
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# update solution build version
pac solution version --buildversion $buildversion --solutionPath $path
