# Connect to Your OpenStack VM and prepare it for installing the Jupyter Notebook

Prerequisites: 
   * The software that will allow you to connect to your VM. This is called _Terminal_ and installed by default on a Mac. If you are on a Windows based machine, you should use an appropriate terminal software. I suggest [Git Bash](https://git-scm.com/downloads) for new users. 
   * Your OpenStack SSH Key created in lesson 6.
   * The IP Address of your VM from lesson 6. 

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

