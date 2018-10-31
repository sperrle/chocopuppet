### chocopuppet/_common.ps1 ####################################################
#
# Project        : chocopuppet
#
# Description    : chocopuppet is a Docker Microsoft Windows Container
#                  with Chocolatey & Puppet preinstalled
#
# URL            : https://hub.docker.com/r/sperrle/chocopuppet/
#
# Version        : v0.2 - 2018-10-31
#
################################################################################
#
# Author         : Manuel Sperrle
# URL            : https://sperrle-it.de
#
# Mail           : chocopuppet@sperrle-it.de
#
################################################################################



# include _common.ps1
#. ( Join-Path -Path $PSScriptRoot -ChildPath '\_common.ps1' );



# ENV_PATH_MACHINE: Get Path from Machine to Environment
function env_path_machine {
	$ENV:Path = [System.Environment]::GetEnvironmentVariable( "Path", "Machine" );
}



# PSEUDO-HTML

function br {
	Write-Host "`n";
}

function hr ( $color = (Get-Host).UI.RawUI.ForegroundColor, $character = "-", $length = (Get-Host).UI.RawUI.WindowSize.Width ) {
	Write-Host ( $character * $length ) -ForegroundColor $color;
}

function h1 ( $object, $color = (Get-Host).UI.RawUI.ForegroundColor ) {
	Write-Host -Object $object -ForegroundColor $color;;
	hr;
	br;
}

function header ( $object, $color = (Get-Host).UI.RawUI.ForegroundColor ) {
	br;
	hr;
	Write-Host -Object $object -ForegroundColor $color;;
	hr;
	br;
}



# VERIFY
# depends on: PSEUDO-HTML

function done ( $object ) {
	$color = "green"
	br;
	hr $color;
	Write-Host "Done: " -NoNewLine -ForegroundColor $color;
	Write-Host -Object $object -ForegroundColor $color;
	br;
}

function notice ( $object ) {
	$color = "yellow"
	Write-Host "Notice: " -NoNewLine -ForegroundColor $color;
	Write-Host -Object $object -ForegroundColor $color;
}

function error ( $object ) {
	$color = "red"
	br;
	hr $color;
	Write-Host "Error: " -NoNewLine -ForegroundColor $color;
	Write-Host -Object $object -ForegroundColor $color;
	br;
}

function verify ( $object ) {

	$success = $?;

	if ( $success ) { 
		done $object; 
	} 
	else { 
		error $object; 
	};

}



# LOOP
# depends on: VERIFY

function Invoke-Loop ( $loop , $erroraction = "throw" ) {
#example:
#
#$loop = @{};
#
#$loop.name = "Loop";
#$loop.description = "Description";
#$loop.color = "blue";
#
#$loop = [ordered]@{
#	'chocolatey' = @{
#		name 		= 'Chocolatey: Install';
#		description = 'Install Chocolatey via PowerShell Script from https://chocolatey.org/install.ps1';
#		command		= 'iex ( ( New-Object System.Net.WebClient ).DownloadString("https://chocolatey.org/install.ps1") )';
#	}
#}

	if ( ! ( $loop.name ) ) { $loop.name = "Loop"; }
	if ( ! ( $color = $loop.color ) ) { $color = "yellow"; }

	hr $color;
	Write-Host ( $loop.name ) -ForegroundColor $color;
	hr $color;
	
	if ( $loop.description ) { 
		Write-Host $loop.description; 
	}
	
	br;
	
	foreach ( $key in $loop.loop.Keys ) {
		
		# get the item
		$item = $loop.loop.Item( $key );
		
		# easy var
		$name = $item.name;
		$description = $item.description;
		$command = $item.command;
		
		# name
		if ( $name ) {
			hr $color;
			Write-Host ( $name ) -ForegroundColor $color;
		}
		
		# description
		if ( $description ) {
			hr $color;
			Write-Host ( $description ) -ForegroundColor $color;
		}
		
		# command
		if ( $command ) {
			hr $color;
			Write-Host ( $command ) -ForegroundColor $color;
			br;

			# update path before
			env_path_machine;

			# invoke command and verify
			$command = ( $command ) + '; verify ( ( $name ) );';
			iex $command;
			
			# update path after
			env_path_machine;
		}
		
		br;
		
	}

	done $loop.name;
	
}



#EOF