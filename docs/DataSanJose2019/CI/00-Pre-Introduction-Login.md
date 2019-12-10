# 

## Install an SSH-Cleint

Download and install a SSH Client. We recommend PuTTY, but any ssh client is acceptable. 

https://www.putty.org/ 

## Authentication for CI Exercises

You will receive login credentials at the beginning of this session. To authenticate (prove you who you say you are and establish what you are authorized to do) the bridgekeeper (login nodes) requires three bits of information: 

From Monty Python and the Holy Grail: 

BRIDGEKEEPER: Hee hee heh. Stop! What... is your name?\
ARTHUR: It is 'Arthur', King of the Britons.\
BRIDGEKEEPER: What... is your quest?\
ARTHUR: To seek the Holy Grail.\
BRIDGEKEEPER: What... is the air-speed velocity of an unladen swallow?\
ARTHUR: What do you mean? An African or European swallow?\
BRIDGEKEEPER: Huh? I-- I don't know that. Auuuuuuuugh!\
BEDEVERE: How do know so much about swallows?\
ARTHUR: Well, you have to know these things when you're a king, you know. 

or... 

1) Tell me who you are. 
2) Tell me something only you know.
3) Show me someething only you have.  

Why do you need both a password and a key? What is the role of the password in the public-private key scheme? 

## Where you will work

You will be logging into training.osgconnect.net for the CyberInfrastructure exercises. To confirm you have the proper authentication and authorization to do the exercises tomorrow and Friday we will test logins today. 

Due to the local network firewall setup (another security mechanism) and key installation, we will go to Brazil first (thanks to Raphael for setting up temporary VM). First be sure you are on the wireless network *Eventos CeNET*. Replace XX with your osguser ID and use the password you have been supplied with the following command. 

```
ssh -o PreferredAuthentications=password osguserXX@200.145.46.31
```

Login on our submission node using the following command along with the password you have been supplied. 

```
$ ssh training.osgconnect.net

The authenticity of host 'training.osgconnect.net (128.135.158.220)' can't be established.
ECDSA key fingerprint is SHA256:gielJSpIiZisxGna5ocHtiK+0zAqFTdcEkLBOgnDUsg.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'training.osgconnect.net,128.135.158.220' (ECDSA) to the list of known hosts.
Enter passphrase for key '/home/osguser01/.ssh/id_rsa':
```

You may get a message asking you to establish the authenticity of this connection. Answer "yes". 

When you login to the machine you will be in your "home directory".  We recommend that you work in this directory as nobody else can modify the files here (what security concept we covered today does this recommendation satisfy?).
