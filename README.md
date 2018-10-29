# chocopuppet

chocopuppet is a Docker Windows Container with Chocolatey and Puppet preinstalled

LATEST VERSION:  
v0.1 - 2018-10-29

microsoft/windowsservercore:1803
Chocolatey 0.10.11
Puppet Agent 6.0.3

uncompressed size: ~300 MB (additional to windowsservercore:1803)


VOLUME 

C:\ProgramData\PuppetLabs\puppet\etc\ssl
for Puppet Agent SSL data (ONBUILD)



ENTRYPOINT

Based on the environment variables set,
the container will try to do the following in that particular order.

- Run other entrypoint script 
	if provided on location C:\entrypoint\entrypoint.ps1

- Apply a puppet manifest 
	if provided on location C:\entrypoint\entrypoint.pp

- Run other Script 
	from ENV DOCKER_ENTRYPOINT=<file>

- Apply puppet manifest 
	from ENV PUPPET_APPLY=<file>

- Execute puppet commands 
	ENV PUPPET_EXECUTE=<string>

- Run the Agent with arguments 
	ENV PUPPET_AGENT=<arguments> 
	example: "--test --onetime" = Connect to puppet server and run once
	run "puppet help agent" for arguments possible

- Config the puppet service with arguments
	ENV PUPPET_SERVICE=<arguments>
	https://docs.microsoft.com/powershell/module/microsoft.powershell.management/set-service
	example: "--State Running" = Set the puppet service to running state
	
- Enable the Puppet Agent  
	ENV PUPPET_ENABLE=<anyvalue>
	<anyvalue> = Enable the puppet agent
	<novalue> = Keep state at "manual"


CMD
no cmd set


LICENSE

Microsoft Windows Server Core (microsoft/windowsservercore)
https://hub.docker.com/r/microsoft/windowsservercore/
By using this Supplement, you accept Microsoft License & useterms
https://www.microsoft.com/en-us/useterms

Chocolatey
https://chocolatey.org/
Chocolatey is Apache 2.0 licensed
https://www.apache.org/licenses/LICENSE-2.0.html

Puppet Agent
https://puppet.com/
https://github.com/puppetlabs/puppet/
Puppet Agent is Apache 2.0 licensed
https://www.apache.org/licenses/LICENSE-2.0.html


CREDITS

Manuel Sperrle
chocopuppet@sperrle-it.de
https://www.sperrle-it.de
