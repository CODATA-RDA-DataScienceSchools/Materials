# Create A New Virtual Machine on the ICTP OpenStack Cloud

## Connect to the OpenStack API
   * Point your browser at https://osc2.ictp.it
   * Log in with the credentials sent via email
      * We'll need to work out how to distribute credentials for the actual school
   * You'll be automatically presented with a pie chart visulaization of the current status of your OpenStack environment. It will looks something like the figure below, though it may differ. 
   ![OpenStack Overview](OpenStack_Overview.png)

   * Click _Instances_ in the left hand menu. This will show you all of the running instances, this may be empty if you are just starting. 
   * At the right top of the screen you will have a _Launch Instance_ button. Click this button. 
   * A new popup window will open with the _Details_ of the VM you will be creating. 
      * The _Project Name_ field will be prepopulated.
      * Add an _Instance Name_. Call this something with your name or something you can uniquely indetify as other student VMs may be listed here also. 
      * There is an optional _Description_ field. It is not necessary to add anything here, but you can.
      * The _Avaliability_ and _Count_ fields will be prepopulated. Be sure these are set to **nova** and **1** respectively. 
      * It should look similar to this:
      ![Instance_Details](Instance_Details.png)
      * Click _Next_.
   * You will be automatically moved to the next tab in the popup _Source_.
   * Choose the _Ubuntu Server 20.04_ option by clicking on the up arrow button the the right of the _Ubuntu Server 20.04_ line. <img src="Up_Arrow.png" width="50"/>


   
