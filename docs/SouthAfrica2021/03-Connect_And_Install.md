# Connect to Your OpenStack VM and Install Python and/or R and Jupyter Notebook

Prerequisites: 
   * The software that will allow you to connect to your VM. This is called _Terminal_ and installed by default on a Mac. If you are on a Windows based machine, you should use an appropriate terminal software. I suggest PuTTY for new users. 
   * Your OpenStack SSH Key created in lesson 2.
   * The IP Address of your VM from lesson 2. 

**Notes on syntax:**
   * If you see ```text like this``` it is a command to enter directly into your terminal (it can be cut and pasted).
   * If you see a ```%``` or ```$``` character before ```text like this``` it represents the prompt and should not be part of your text. Don't cut and paste this character!
   * If something is in brackets like ```<This_Text>``` it needs your unique text and should be replaced with the appropriate value.

**A Final Note:**
   * Hopefully the UNIX session you've completed covers most of the commands you see here. If it did not and you're curious, ask your instructor.  

## Connecting via SSH
   * Open your terminal software and navigate to the directory where you've saved your OpenStack SSH Key. 
   * Your key will not work if it's permission is not set correctly. This is a security precaution. Use this command to hide your key from anyone but yourself: <br>
   ```% chmod 400 <Your_Key_File>```
   * Connect to your VM using: <br>
   ```% ssh -i <Your_Key_File> ubuntu@<Your_IP_Address>```
   * The first time you log on you will be presented with the question: <br>
   ```Are you sure you want to continue connecting (yes/no/[fingerprint])?```
   * Answer ```yes```. 
   * You are now connected to your VM. You will see a prompt like this: <br>
   ```ubuntu@robtest4:~$```

## Preparing the OS for Software Installation
   * We created the Ubuntu Virtual Machine using a pre-packaged image. We want to be sure it has all the latest software versions. We do this by running this command: <br>
   ```$ sudo apt update && sudo apt -y upgrade```
   * This step will take about 3 minutes. You can watch all the updated packages being installed in the terminal. When it is done you will see this as the final line: <br>
   ```$ update-initramfs: Generating /boot/initrd.img-5.4.0-74-generic```

## Install Python
   * Install Python with this command: <br>
   ```$ sudo apt install python3-pip python3-dev```
   * Answer with a ```Y``` when asked if you want to continue. 

## Install R
   * Install R with this command: <br>
   ```$ sudo apt install r-base```
   * Answer with a ```Y``` when asked if you want to continue.

## Install Jupyter Notebook

**Note:** We'll use a Python Virtual Environment when running our Jupyter Notebook. Why use a virtual environment? Isolation! A virtual environment is a Python tool for dependency management and project isolation. They allow Python site packages (third party libraries) to be installed locally in an isolated directory for a particular project, as opposed to being installed globally (i.e. as part of a system-wide Python). Since we will make this notebook available remotely (and anyone could potentially find it), we don't want our notebook to install in the system-wide Python. 
   * Make sure you have the most recent version of the Python Package Manager using: <br>
   ```$ sudo -H pip3 install --upgrade pip```
   * Install the Virtual Environment package: <br>
   ```$ sudo -H pip3 install virtualenv```
   * Create a directory for the virtual environment using: <br>
   ```$ mkdir notebook```
   * Move into this directory: <br>
   ```$ cd notebook```
   * Create this Virtual Environment (on a Virtual Machine): <br>
   ```$ virtualenv jupyterenv```
   * Activate your Virtual Environment: <br>
   ```$ source jupyterenv/bin/activate```
   * You should now see ```(jupyterenv)``` at the start of your prompt.
   * Install Jupyter using: <br>
   ```pip install jupyter```
   * Add a password to your Jupyter Notebook using: <br>
   ```$ jupyter notebook password```
   * Enter and Verify a password. 
   * Start your Jupyter Notebook and Allow Remote Connections with: <br>
   ```$ jupyter notebook --no-browser --port 8888 --ip "<Your_VM_IP_Here>"```
   
##Connect to Your Notebook

   * Point your local browser at: http://<Your_VM_IP_Here>:8888/
   * Enter the notebook password you just created a few steps earlier. 
   * You should now be connected to a Jupyter Notebook on a cloud resource (at ICTP in Italy) and can use its resources from your home browser!

[Return to CI Overview](00-Hands_on_Exercise_Overview.md)
