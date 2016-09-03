  cd C:\vagrant
  ls
  vagrant ssh web1
  $argumentList = "--no-shortcuts --quiet-mode --packages openssh"
  $cygwinDir = "C:\tools\cygwin"
  $cygwinSetup = "$cygwinDir\cygwinsetup.exe"
  New-Item -ItemType Directory -Path $cygwinDir
  Remove-Item -Path $cygwinDir -Force -Recurse
  New-Item -ItemType Directory -Path $cygwinDir
  iwr -Uri "https://www.cygwin.com/setup-x86_64.exe" -OutFile $cygwinSetup
  Start-Process -FilePath $cygwinSetup -ArgumentList $argumentList -NoNewWindow -Wait
  $argumentList = "--no-shortcuts --packages openssh"
  Start-Process -FilePath $cygwinSetup -ArgumentList $argumentList -NoNewWindow -Wait
  $cygwinDir = "C:\tools\cygwin"
  $cygwinPkgDir = "$cygwinDir\Packages"
  New-Item -ItemType Directory -Path $cygwinDir
  New-Item -ItemType Directory -Path $cygwinPkgDir
  $argumentList = "--no-shortcuts --quiet-mode -P openssh -R $cygwinDir -l $cygwinPkgDir"
  $cygwinSetup = "$cygwinDir\cygwinsetup.exe"
  iwr -Uri "https://www.cygwin.com/setup-x86_64.exe" -OutFile $cygwinSetup
  Start-Process -FilePath $cygwinSetup -ArgumentList $argumentList -NoNewWindow -Wait
  vagrant ssh
  vagrant ssh web1
  $env:Path
  $env:Path += ";$cygwinDir\bin;"
  $env:Path
  vagrant ssh web1
  vagrant destroy web1 web2
 29 vagrant destroy web1 web2 db1
 30 vagrant up
