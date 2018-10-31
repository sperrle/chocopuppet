# SPERRLE/CHOCOPUPPET  
chocopuppet is a Docker Windows Container with Chocolatey and Puppet preinstalled  
  
  
  
## DOCKER
[sperrle/chocopuppet @DockerHub](https://hub.docker.com/r/sperrle/chocopuppet/)
`docker pull sperrle/chocopuppet`  
  
  
  
## DOCKERFILE  
[Dockerfile @GitHub](https://github.com/sperrle/chocopuppet/blob/master/Dockerfile)  
[sperrle/chocopuppet @GitHub](https://github.com/sperrle/chocopuppet)  
  
  
  
## LATEST VERSION  
**0.1 (2018-10-29)**  
* Microsoft/windowsservercore:1803  
* Chocolatey 0.10.11  
* Puppet Agent 6.0.3  
  
_uncompressed size: ~300 MB (additional to windowsservercore:1803)_  
  
  
  
## SHELL  
`PowerShell.exe -NoExit -NoProfile -C`  
  
  
  
## VOLUME  
  
* **C:\ProgramData\PuppetLabs\puppet\etc\ssl**  
ONBUILD  
Puppet Agent SSL data  
  
## ENTRYPOINT  
  
Based on the environment variables set,  
the container will try to do the following in that particular order.  
  
* **Run other entrypoint script**  
if provided on location C:\entrypoint\entrypoint.ps1  
  
* **Apply a puppet manifest**  
if provided on location C:\entrypoint\entrypoint.pp  
  
* **Run other Script**  
`ENV DOCKER_ENTRYPOINT=<file>`  
  
* **Apply puppet manifest**  
`ENV PUPPET_APPLY=<file>`  
  
* **Execute puppet command**  
`ENV PUPPET_EXECUTE=<string>`  
  
* **Run the Agent with arguments**  
`ENV PUPPET_AGENT=<arguments>`  
example: "--test --onetime" = Connect to puppet server and run once  
run "puppet help agent" for arguments possible  
  
* **Config the puppet service with arguments**  
`ENV PUPPET_SERVICE=<arguments>`  
[Set-Service @MicrosoftDocs](https://docs.microsoft.com/powershell/module/microsoft.powershell.management/set-service)  
example: "--State Running" = Set the puppet service to running state  
  	
* **Enable the Puppet Agent**  
`ENV PUPPET_ENABLE=<anyvalue>`  
anyvalue = Enable the puppet agent  
novalue = Keep state at "manual"  
  
  
  
## CMD  
* **no CMD set**  
  
  
  
## LICENSE  
  
* **Microsoft Windows Server Core (microsoft/windowsservercore)**  
https://hub.docker.com/r/microsoft/windowsservercore/  
[Microsoft License & useterms](https://www.microsoft.com/en-us/useterms)  
  
* **Chocolatey**  
https://chocolatey.org/  
[chocolatey @GitHub](https://github.com/chocolatey)  
[Apache 2.0 Licsense](https://www.apache.org/licenses/LICENSE-2.0.html)  
  
* **Puppet Agent**  
https://puppet.com/  
[puppetlabs/puppet @GitHub](https://github.com/puppetlabs/puppet)  
[Apache 2.0 Licsense](https://www.apache.org/licenses/LICENSE-2.0.html)  
  
  
  
## CREDITS  
  
* **Manuel Sperrle**  
chocopuppet@sperrle-it.de  
https://www.sperrle-it.de  
  
