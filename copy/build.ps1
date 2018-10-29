### chocopuppet/build.ps1 ######################################################
#
# Project        : chocopuppet
#
# Description    : chocopuppet is a Docker Microsoft Windows Container
#                  with Chocolatey & Puppet preinstalled
#
# URL            : https://hub.docker.com/r/sperrle/chocopuppet/
#
# Version        : v0.1 - 2018-10-29
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
. ( Join-Path -Path $PSScriptRoot -ChildPath '\_common.ps1' );



#--------------------------------------------------------------------------------
# DO IT !
#--------------------------------------------------------------------------------



# Define loop

$loop = @{
	name = "CHOCOPUPPET BUILD";
}

$loop.loop = [ordered]@{

	'chocolatey' = @{
		name 		= 'Chocolatey';
		command		= 'iex ( ( New-Object System.Net.WebClient ).DownloadString("https://chocolatey.org/install.ps1") )';
		description = "Install Chocolatey via PowerShell Script https://chocolatey.org/install.ps1 `nInfo: https://chocolatey.org/docs `n`nChocolatey is a software management solution unlike anything else you've ever `nexperienced on Windows. It focuses on simplicity, security, and scalability.";
	}
	
	'chocolatey-verify' = @{
		name		= 'Chocolatey: Verify';
		command		= 'choco --version';
		description = 'Verify Installation: Is Chocolatey installed and reachable from path ?';
	}
	
	'puppet-agent' = @{
		name		= 'Puppet Agent (PUPPET_AGENT_STARTUP_MODE=Manual)';
		command		= 'choco install puppet-agent -y -InstallArgs "PUPPET_AGENT_STARTUP_MODE=Manual"';
		description = "Install Puppet Agent via Chocolatey `nInfo: https://puppet.com/docs/puppet/latest `n`nPuppet provides tools to automate managing your infrastructure. `n`nSet to manual start up mode - we dont want automatic mode at this moment: `nThe client would immediately start connecting in automatic mode ! `n`nBest Practices: `n-Docker: Call the agent via CMD `n-Docker: Build a new image and start agent there `n-PowerShell: Call this script in another script and call agent afterwards";
	}
	
	'puppet-agent-verify' = @{
		name		= 'Puppet-Agent: Verify';
		command		= 'puppet --version';
		description = 'Verify Installation: Is Puppet Agent installed and reachable from path ?';
	}
	
	'puppet-agent-verify-service' = @{
		name		= 'Puppet-Agent: Verify Service Status';
		command		= 'Get-Service puppet | findstr "Stopped"';
		description = 'Verify Installation: Is Puppet Agent installed and state to stopped ?';
	}
	
	'puppet-agent-config-deprecations' = @{
		name		= 'Puppet Agent: Config: Disable Deprecation Warning';
		command		= 'Add-Content -Path ( Join-Path $ENV:PROGRAMDATA -ChildPath "/puppetlabs/puppet/etc/puppet.conf" ) -Value "disable_warnings=deprecations"';
		description = 'Add configuration to puppet.conf: disable_warnings=deprecations';
	}	

	'puppet-agent-config-deprecations-verify' = @{
		name		= 'Puppet Agent: Config: Disable Deprecation Warning: Verify';
		command		= 'Get-Content -Path ( Join-Path -Path "$ENV:PROGRAMDATA" -Childpath "/puppetlabs/puppet/etc/puppet.conf" ) | findstr "disable_warnings=deprecations"';
		description = 'Verify: Is the configuration disable_warnings=deprecations set ?';
	}
	
	'puppet-module-puppetlabs-chocolatey' = @{
		name		= 'Puppet Module: puppetlabs-chocolatey';
		command		= 'puppet module install puppetlabs-chocolatey';
		description = "Install Puppet Module puppetlabs-chocolatey `nInfo: https://forge.puppet.com/puppetlabs/chocolatey `n`nChocolatey package provider for Puppet";
	}
	
	'puppet-module-puppetlabs-chocolatey-verify' = @{
		name 		= 'Puppet Module: puppetlabs-chocolatey: Verify'; 
		command		= 'puppet module list | findstr "puppetlabs-chocolatey"';
		description = 'Verify Installation: Is puppetlabs-chocolatey installed ?';
	}
	
	'puppet-module-puppetlabs-puppet_agent' = @{
		name		= 'Puppet Module: puppetlabs-puppet_agent';
		command		= 'puppet module install puppetlabs-puppet_agent';
		description = "Install Puppet Module puppetlabs-puppet_agent `nInfo: https://forge.puppet.com/puppetlabs/puppet_agent `n`nUpgrades Puppet 3.7+ and All-In-One Puppet Agents";
	}
	
	'puppet-module-puppetlabs-puppet_agent-verify' = @{
		name 		= 'Puppet Module: puppetlabs-puppet_agent: Verify'; 
		command		= 'puppet module list | findstr "puppetlabs-puppet_agent"';
		description = 'Verify Installation: Is puppetlabs-puppet_agent installed ?';
	}
	
	'remove-chocolatey-temp' = @{
		name		= 'Remove: Chocolatey: Cache Directory';
		command		= 'Remove-Item -Path ( Join-Path -Path "$ENV:TEMP" -Childpath "chocolatey" ) -Recurse -Force';
		description = 'Remove Chocolatey cache directory';
	}
	
	'remove-chocolatey-temp-verify' = @{
		name		= 'Remove: Chocolatey: Cache Directory: Verify';
		command		= 'if ( Test-Path ( Join-Path -Path "$ENV:TEMP" -Childpath "chocolatey" ) ) { exit 1 }';
		description = 'Is the Chocolatey cache directory removed ?';
	}
	
	'remove-chocolatey-log' = @{
		name		= 'Remove: Chocolatey: Log Directory';
		command		= 'Remove-Item -Path ( Join-Path -Path "$ENV:ChocolateyInstall" -Childpath "logs" ) -Recurse -Force';
		description = 'Remove Chocolatey log directory';	
	}
	
	'remove-chocolatey-log-verify' = @{
		name		= 'Remove: Chocolatey: Log Directory: Verify';
		command		= 'if ( Test-Path ( Join-Path -Path "$ENV:ChocolateyInstall" -Childpath "logs" ) ) { exit 1 }';
		description = 'Is the Chocolatey log directory removed ?';	
	}
	
}



# Invoke loop

Invoke-Loop $loop;



#EOF