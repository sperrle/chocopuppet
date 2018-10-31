### chocopuppet/entrypoint.ps1 #################################################
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

$script = "/entrypoint/entrypoint.ps1";
if ( $script ) {
	$loop.loop.$script = @{
		name		= 'SCRIPT: ' + $script;
		command		= 'If (Test-Path "' + $script + '") { "' + $script + '" } else { notice ( "' + $script + '" + " not found" ); br; return; }';
		description = 'Call script at ' + $script;
	}
}
	
$puppet_apply = "/entrypoint/entrypoint.pp";
if ( $puppet_apply ) {
	$loop.loop.$puppet_apply = @{
		name		= 'PUPPET APPLY: ' + $puppet_apply;
		command		= 'If (Test-Path "' + $puppet_apply + '") { puppet apply "' + $puppet_apply + '" } else { notice ( "' + $puppet_apply + '" + " not found" ); br; return; }';
		description = 'Puppet apply ' + $puppet_apply;
	}
}

$script = "$ENV:DOCKER_ENTRYPOINT";
if ( $script ) {
	$loop.loop.$script = @{
		name		= 'SCRIPT: ' + $script;
		command		= 'If (Test-Path "' + $script + '") { "' + $script + '" } else { notice ( "' + $script + '" + " not found" ); br; return; }';
		description = 'Call script at ' + $script;
	}
}

$puppet_apply = $ENV:PUPPET_APPLY;
if ( $puppet_apply ) {
	$loop.loop.$puppet_apply = @{
		name		= 'PUPPET APPLY: ' + $puppet_apply;
		command		= 'If (Test-Path "' + $puppet_apply + '") { puppet apply "' + $puppet_apply + '" } else { notice ( "' + $puppet_apply + '" + " not found" ); br; return; }';
		description = 'Puppet apply ' + $puppet_apply;
	}
}


$puppet_execute = $ENV:PUPPET_EXECUTE;
if ( $puppet_execute ) { 
	$loop.loop['puppet-execute' ] = @{
		name		= 'PUPPET EXECUTE: ' + $puppet_execute;
		command		= 'puppet execute ' + $puppet_execute;
		description = 'Puppet execute ' + $puppet_execute;
	}
};

$puppet_agent = $ENV:PUPPET_AGENT;
if ( $puppet_agent ) { 
	$loop.loop['puppet-agent'] = @{
		name		= 'PUPPET AGENT: ' + $puppet_agent;
		command		= 'puppet agent ' + $puppet_agent;
		description = 'Puppet agent ' + $puppet_agent;
	}
};

$puppet_service = $ENV:PUPPET_SERVICE;
if ( $puppet_service ) { 
	$loop.loop['puppet-service'] = @{
		name		= 'PUPPET SERVICE: ' + $puppet_service;
		command		= 'Set-Service puppet ' + $puppet_service;
		description = 'Set-Service puppet ' + $puppet_service;
	}
};

$puppet_enable = $ENV:PUPPET_enable;
if ( $puppet_enable ) { 
	$loop.loop['puppet-enable'] = @{
		name		= 'PUPPET enable: ' + $puppet_enable;
		command		= 'puppet enable ' + $puppet_enable;
		description = 'Puppet enable ' + $puppet_enable;
	}
};



# Invoke loop

Invoke-Loop $loop, " ";



#EOF