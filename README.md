# SPERRLE/CHOCOPUPPET<br/>
chocopuppet is a Docker Windows Container with Chocolatey and Puppet preinstalled<br/>



## DOCKERFILE<br/>
[Dockerfile @github](https://github.com/sperrle/chocopuppet/blob/master/Dockerfile)<br/>



## LATEST VERSION<br/>
**0.1 (2018-10-29)**<br/>
* Microsoft/windowsservercore:1803<br/>
* Chocolatey 0.10.11<br/>
* Puppet Agent 6.0.3<br/>

_uncompressed size: ~300 MB (additional to windowsservercore:1803)_<br/>



## SHELL<br/>
`PowerShell.exe -NoExit -NoProfile -C`<br/>



## VOLUME<br/>

* **C:\ProgramData\PuppetLabs\puppet\etc\ssl**<br/>
ONBUILD<br/>
Puppet Agent SSL data<br/>

## ENTRYPOINT<br/>

Based on the environment variables set,<br/>
the container will try to do the following in that particular order.<br/>

* **Run other entrypoint script**<br/>
if provided on location C:\entrypoint\entrypoint.ps1<br/>

* **Apply a puppet manifest**<br/>
if provided on location C:\entrypoint\entrypoint.pp<br/>

* **Run other Script**<br/>
`ENV DOCKER_ENTRYPOINT=<file>`<br/>

* **Apply puppet manifest**<br/>
`ENV PUPPET_APPLY=<file>`<br/>

* **Execute puppet command**<br/>
`ENV PUPPET_EXECUTE=<string>`<br/>

* **Run the Agent with arguments**<br/>
`ENV PUPPET_AGENT=<arguments>`<br/>
example: "--test --onetime" = Connect to puppet server and run once<br/>
run "puppet help agent" for arguments possible<br/>

* **Config the puppet service with arguments**<br/>
`ENV PUPPET_SERVICE=<arguments>`<br/>
https://docs.microsoft.com/powershell/module/microsoft.powershell.management/set-service<br/>
example: "--State Running" = Set the puppet service to running state<br/>
	
* **Enable the Puppet Agent**<br/>
`ENV PUPPET_ENABLE=<anyvalue>`\<br/>
anyvalue = Enable the puppet agent\<br/>
novalue = Keep state at "manual"<br/>



## CMD<br/>
* **no CMD set**<br/>



## LICENSE<br/>

* **Microsoft Windows Server Core (microsoft/windowsservercore)**<br/>
https://hub.docker.com/r/microsoft/windowsservercore/<br/>
By using this Supplement, you accept Microsoft License & useterms<br/>
https://www.microsoft.com/en-us/useterms<br/>

* **Chocolatey**<br/>
https://chocolatey.org/<br/>
Chocolatey is Apache 2.0 licensed<br/>
https://www.apache.org/licenses/LICENSE-2.0.html<br/>

* **Puppet Agent**<br/>
https://puppet.com/<br/>
https://github.com/puppetlabs/puppet/<br/>
Puppet Agent is Apache 2.0 licensed<br/>
https://www.apache.org/licenses/LICENSE-2.0.html<br/>



## CREDITS<br/>

* **Manuel Sperrle**<br/>
chocopuppet@sperrle-it.de<br/>
https://www.sperrle-it.de<br/>
