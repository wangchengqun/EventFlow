rem @echo off

mkdir Tools
powershell -Command "if ((Test-Path '.\Tools\NuGet.exe') -eq $false) {(New-Object System.Net.WebClient).DownloadFile('http://nuget.org/nuget.exe', '.\Tools\NuGet.exe')}"

".\Tools\NuGet.exe" "install" "FAKE.Core" "-OutputDirectory" "Tools" "-ExcludeVersion" "-version" "3.23.0"
".\Tools\NuGet.exe" "install" "NUnit.Runners" "-OutputDirectory" "Tools" "-ExcludeVersion" "-version" "2.6.4"

".\Tools\NuGet.exe" restore .\EventFlow.sln

"Tools\FAKE.Core\tools\Fake.exe" "build.fsx" "nugetApikey=%NUGET_APIKEY%" "buildVersion=%BUILD_VERSION%"

exit /b %errorlevel%