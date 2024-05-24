# Install software for Bootcamp

## Git and command line tools

MacOS:
1. Open terminal
1. `xcode-select --install`

Windows 10:
1. Turn Windows features on and off -> check "Windows subsystem for Linux" -> ok
1. Reboot
1. Microsoft Store -> search “Ubuntu” -> Install
1. Set up Ubuntu
    1. Open Ubuntu
    1. Let it install, then set a username and password (you probably want to write this down somewhere)
    1. `sudo apt update`
    1. `sudo apt upgrade`
    1. Note that windows cannot see your root directory. If you want to get to your C drive `cd /mnt/c`. Remember this for later

Ubuntu: All the tools we need are part of a vanilla install

Alternatively, you can install a GUI that uses git. For example GitHub Desktop, or GitKrakken, ...

You should now be able to enter `git --version` and have it return "git version 2.17.1". (The version won't matter for what we're doing.)

## Other software

All OS:

Program | Link | Notes | Size
--- | --- | --- | ---
Matlab | http://laptops.eng.uci.edu/software-installation/matlab	| Install Matlab 2020. You won't need any toolboxes. | 5GB
Mathematica	| https://uci.service-now.com/kb_view.do?sysparm_article=KB0010917 | &nbsp; | 9GB
Anaconda |	https://www.anaconda.com | Install Python 3.8 | 6GB
Blender |	https://www.blender.org/ | &nbsp; | 0.4GB

Windows users:

Program | Link | Notes | Size
 --- | --- | --- | ---
Ubuntu | (Installed through in Windows 10) | &nbsp; | 0.6GB
Putty | https://www.putty.org | &nbsp; | 0.01GB

Approximate total: 22GB


## Julia for Jupyter

There are two ways to do this.

* Using conda: https://anaconda.org/conda-forge/julia

* Using JuliaLang: https://datatofish.com/add-julia-to-jupyter/




