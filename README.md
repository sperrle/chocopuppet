# SPERRLE/CHOCOPUPPET&nbsp;
chocopuppet is a Docker Windows Container with Chocolatey and Puppet preinstalled&nbsp;



## DOCKERFILE&nbsp;
[Dockerfile @github](https://github.com/sperrle/chocopuppet/blob/master/Dockerfile)&nbsp;



## LATEST VERSION&nbsp;
**0.1 (2018-10-29)**&nbsp;
* Microsoft/windowsservercore:1803&nbsp;
* Chocolatey 0.10.11&nbsp;
* Puppet Agent 6.0.3&nbsp;

_uncompressed size: ~300 MB (additional to windowsservercore:1803)_&nbsp;



## SHELL&nbsp;
`PowerShell.exe -NoExit -NoProfile -C`&nbsp;



## VOLUME&nbsp;

* **C:\ProgramData\PuppetLabs\puppet\etc\ssl**&nbsp;
ONBUILD&nbsp;
Puppet Agent SSL data&nbsp;

## ENTRYPOINT&nbsp;

Based on the environment variables set,&nbsp;
the container will try to do the following in that particular order.&nbsp;

* **Run other entrypoint script**&nbsp;
if provided on location C:\entrypoint\entrypoint.ps1&nbsp;

* **Apply a puppet manifest**&nbsp;
if provided on location C:\entrypoint\entrypoint.pp&nbsp;

* **Run other Script**&nbsp;
`ENV DOCKER_ENTRYPOINT=<file>`&nbsp;

* **Apply puppet manifest**&nbsp;
`ENV PUPPET_APPLY=<file>`&nbsp;

* **Execute puppet command**&nbsp;
`ENV PUPPET_EXECUTE=<string>`&nbsp;

* **Run the Agent with arguments**&nbsp;
`ENV PUPPET_AGENT=<arguments>`&nbsp;
example: "--test --onetime" = Connect to puppet server and run once&nbsp;
run "puppet help agent" for arguments possible&nbsp;

* **Config the puppet service with arguments**&nbsp;
`ENV PUPPET_SERVICE=<arguments>`&nbsp;
https://docs.microsoft.com/powershell/module/microsoft.powershell.management/set-service&nbsp;
example: "--State Running" = Set the puppet service to running state&nbsp;
	
* **Enable the Puppet Agent**&nbsp;
`ENV PUPPET_ENABLE=<anyvalue>`&nbsp;
anyvalue = Enable the puppet agent&nbsp;
novalue = Keep state at "manual"&nbsp;



## CMD&nbsp;
* **no CMD set**&nbsp;



## LICENSE&nbsp;

* **Microsoft Windows Server Core (microsoft/windowsservercore)**&nbsp;
https://hub.docker.com/r/microsoft/windowsservercore/&nbsp;
By using this Supplement, you accept Microsoft License & useterms&nbsp;
https://www.microsoft.com/en-us/useterms&nbsp;

* **Chocolatey**&nbsp;
https://chocolatey.org/&nbsp;
Chocolatey is Apache 2.0 licensed&nbsp;
https://www.apache.org/licenses/LICENSE-2.0.html&nbsp;

* **Puppet Agent**&nbsp;
https://puppet.com/&nbsp;
https://github.com/puppetlabs/puppet/&nbsp;
Puppet Agent is Apache 2.0 licensed&nbsp;
https://www.apache.org/licenses/LICENSE-2.0.html&nbsp;



## CREDITS&nbsp;

* **Manuel Sperrle**&nbsp;
chocopuppet@sperrle-it.de&nbsp;
https://www.sperrle-it.de&nbsp;
