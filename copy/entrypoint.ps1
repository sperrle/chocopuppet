### chocopuppet/entrypoint.ps1 #################################################
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
	name = "CHOCOPUPPET ENTRYPOINT";
}

$loop.loop = [ordered]@{}



# Conditional loop

if ( Test-Path "/entrypoint/entrypoint.ps1" ) {
	$loop.loop['entrypoint'] = @{
		name		= 'ENTRYPOINT (LOCAL): /entrypoint/entrypoint.ps1';
		command		= '/entrypoint/entrypoint.ps1';
		description = 'Call entrypoint script at /entrypoint/entrypoint.ps1';
	}
}
	
if ( Test-Path "/entrypoint/entrypoint.pp" ) { 
	$loop.loop['manifest'] = @{
		name		= 'MANIFEST (LOCAL): /entrypoint/entrypoint.pp';
		command		= 'puppet apply /entrypoint/entrypoint.pp';
		description = 'Apply manifest from /entrypoint/entrypoint.pp';
	}
}

if ( $ENV:DOCKER_ENTRYPOINT ) { 
	$loop.loop['entrypoint-env'] = @{
		name		= 'DOCKER ENTRYPOINT (ENV)';
		command		= 'if ( Test-Path "$ENV:DOCKER_ENTRYPOINT" ) { $ENV:DOCKER_ENTRYPOINT } else { error ("$ENV:DOCKER_ENTRYPOINT not found"); }';
		description = 'Call entrypoint script at $ENV:DOCKER_ENTRYPOINT: ' + "`n" + $ENV:DOCKER_ENTRYPOINT;
	}
}

if ( $ENV:PUPPET_APPLY ) { 
	$loop.loop['puppet-apply'] = @{
		name		= 'PUPPET APPLY (ENV)';
		command		= 'if ( Test-Path "$ENV:PUPPET_APPLY" ) { puppet apply $ENV:PUPPET_APPLY } else { error ("$ENV:PUPPET_APPLY not found"); }';
		description = 'Apply manifest from $ENV:PUPPET_APPLY: ' + "`n" + $ENV:PUPPET_APPLY;
	}
}

if ( $ENV:PUPPET_EXECUTE ) { 
	$command = 'puppet apply ' + $ENV:PUPPET_EXECUTE;
	$loop.loop['puppet-exec'] = @{
		name		= 'PUPPET EXECUTE (ENV)';
		command		= $command;
		description = 'Run puppet apply --execute using arguments from $ENV:PUPPET_EXECUTE: ' + "`n" + $ENV:PUPPET_EXECUTE;
	}
}

if ( $ENV:PUPPET_AGENT ) { 
	$command = 'puppet agent ' + $ENV:PUPPET_AGENT;
	$loop.loop['puppet-agent'] = @{
		name		= 'PUPPET AGENT (ENV)';
		command		= $command;
		description = 'Run puppet agent using arguments from $ENV:PUPPET_AGENT: ' + "`n" + $ENV:PUPPET_AGENT;
	}
}

if ( $ENV:PUPPET_SERVICE ) { 
	$command = 'Set-Service -Name puppet ' + $ENV:PUPPET_SERVICE;
	$loop.loop['puppet-service'] = @{
		name		= 'PUPPET SERVICE (ENV)';
		command		= $command;
		description = 'Run Set-Service using arguments from $ENV:PUPPET_SERVICE: ' + "`n" + $ENV:PUPPET_SERVICE;
	}
}

if ( $ENV:PUPPET_ENABLE ) { 
	$command = 'puppet agent --enable';
	$loop.loop['puppet-enable'] = @{
		name		= 'PUPPET ENABLE (ENV)';
		command		= $command;
		description = 'Enable puppet agent ($ENV:PUPPET_ENABLE is present)';
	}
}



# Invoke loop

Invoke-Loop $loop;



#EOF