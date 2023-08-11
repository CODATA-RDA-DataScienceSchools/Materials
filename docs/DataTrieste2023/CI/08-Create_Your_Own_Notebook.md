# Instructions for creating a *Jupyter Notebook Server* in a *IaaS* system

### Installing `conda` environment manager

<img src="img/03.png" width="200px"/>

For this hands-on we are going to use the [conda environment manager](https://docs.conda.io/en/latest/). This is a dependency and environment management for any language—Python, R, Ruby, Lua, Scala, Java, JavaScript, C/ C++, FORTRAN, and more.

The first thing that we need to make sure before installing the *conda environment manager* is that we are connected to our VM. So, your command line prompt should look like what was shown in the previous section.

#### 1. Download the ***miniconda*** distribution of conda

The *conda environment management* tool only allows us to create virtual environments completely separated from the operating system.
The tool is available for downloading in two flavors:
* ***Miniconda***: Minimal package containing only the basic softwares/packages. This will be the version that we are going to use during this hands-on; 
* ***Anaconda***: Maximal package containing most of the libraries/software used for doing data analysis;


We are going to use the *unix-shell* `wget` command for downloading stuff from the web. From the conda webpage we copied the download link  for the [latest version for linux](https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh):

```bash=
$ wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

When the download is finished you should see the message:

```
2021-07-01 18:06:28 (19.9 MB/s) - ‘Miniconda3-latest-Linux-x86_64.sh’ saved [94235922/94235922]
```

#### 2. Change permissions and run the ***miniconda installer***

The unix file system allows us to define access permissions in 3 levels for files, the **owner**, the **group the owner belongs to**, and **every other users**. We are going to add permissions to the owner to execute the installer (using the `chmod` command). For more details on linux permissions please refer to [this link](https://wiki.archlinux.org/title/File_permissions_and_attributes).

```bash=
$ chmod 764 Miniconda3-latest-Linux-x86_64.sh
```

After changing the file permissions we can move on to the installation process itself. To run the installer we just need to use the command:

```bash=
$ ./Miniconda3-latest-Linux-x86_64.sh
```

The installer will ask you to access the license terms and afterwards will ask where the *miniconda* will be installed. We can accept the default value: `/home/ubuntu/miniconda3`. 

At the end of the installation you will be asked if you want to perform the `conda init` operation. This is responsible for adding the `conda` command line tool to our VM path. We should answer `yes` to this question. Now we have to log out and log in again before using the `conda` command.
To exit our VM we use the `exit` command. After disconnecting from the machine, we need to run the `ssh` command to access it again:

```bash=
$ exit
$ ssh -i ~/Desktop/id_rsa ubuntu@xxx.xxx.xxx.xxx
```

If the installation was successful then you should see the new prompt:

```bash=
(base) ubuntu@jupyter:~$
```


### Creating the virtual environment using the `conda` command

Now we need to create our virtual environment to install the *jupyter server*. We are going to call this environment `jupyter`:

```bash=
$ conda create -n jupyter
```

We can list the environment by typing the `conda env list` command:

```bash=
$ conda env list
```
The output should look like this: 
```
# conda environments:
#
base                  *  /home/ubuntu/miniconda3
jupyter                  /home/ubuntu/miniconda3/envs/jupyter
```

Now we are going to *activate* the `jupyter` environment:
```bash=
$ conda activate jupyter
```
The prompt should change to:
```bash=
(jupyter) ubuntu@jupyter:~$
```
If your prompt changed then the environment was correctly created and it is activated.

### Installing the *Jupyter Notebook Server*, the *R Kernel*, and extra libraries

Now that we are inside our `jupyter` environment we need to install the *notebook server* and also the [jupyter R kernel](https://github.com/IRkernel/IRkernel).

After activating the *jupyter* environment we are going to use the `conda install` command to install the *jupyter server*. The packages needed are 

1. `notebook`
2. `r`
3. `r-irkernel`

We can install all the needed software at once by performing the command:

```bash=
$ conda install r-irkernel
$ conda install notebook
```
We can check if the notebook was correctly installed by using the `conda list` command combined with the `grep` command:

```bash=
$ conda list | grep notebook
```
The result should be:

```
notebook                  6.4.0            py39h06a4308_0  
```

### Launching the *Jupyter Notebook Server* and accessing its web interface

Now we are finally ready to launch the *Jupyter server*, but before running it we need to address a bug with the `irkernel` package and the Ubuntu 20.04. We need to install the the `libxrender1` library. We do that by using the `apt` command together with the `sudo` command that allows us to run commands as the system administrator:

```bash=
$ sudo apt install libxrender1
```

After installing the library we can start our *jupyter server*. One of the parameter needed for starting the server is the the IP address of the VM. That address is the same we used in the `ssh` command and has the format: `xxx.xxx.xxx.xxx`. That information is available inside the ***Instances*** tab at the *openstack* webpage. The command to start the server then should be:

```bash=
$ jupyter notebook --ip=<VM_IP_HERE> --port 8888
```

If you can see the following message, it means that the installation worked:

```
 To access the notebook, open this file in a browser:
     file:///home/ubuntu/.local/share/jupyter/runtime/nbserver-19589-open.html
 Or copy and paste one of these URLs:
  or http://127.0.0.1:8083/?token=2a3df1887c3a9acc7aa81673c348d3d205d220a81ec99788

```
In order to access the jupyter server we should user a web browser and access the address `http://Your_IP_Address:8083`. The `Your_IP_Address` address is listed at the openstack instances tab and should start with `154.114` and have the format `xxx.xxx.xxx.xxx`.

### Exercise

Can you recreate the Linear Regression Exercise we did yesterday in Colab?



### Cleaning up

If you want to remove all the software that we've installed we should first stop the *jupyter notebook server* by hitting `Control+c` and answering yes (`y`) when asked if you want to stop the server.

After that we need to deactivate the virtual environment `jupyter` before removing it:
```bash=
$ conda deactivate
```
The prompt should switch its prefix to `(base)`. Now we can use the `conda env remove` with the `-n` option to specify which environment should be deleted:

```bash=
$ conda env remove -n jupyter
```
