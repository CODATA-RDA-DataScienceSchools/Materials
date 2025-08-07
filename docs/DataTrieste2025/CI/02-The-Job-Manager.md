# Our Condor Installation

## Objective

This exercise should help you understand the basics of how Condor is installed, what Condor processes (a.k.a. daemons) are running, and what they do.

## Login to the Condor submit computer

Continuuing from the terminal you opened in Hands-on Exercise 1.

```
$ hostname
jupyter-eppn-3arobquick-40access-2dci-2eorg
```

You should have been given your username and password when you arrived this afternoon. If you don't know them, talk to Rob.

## Looking at our Condor installation

How do you know what version of Condor you are using? Try <code>condor_version</code>: 

```
$ condor_version
$CondorVersion: 10.6.0 2023-06-29 BuildID: 658549 PackageID: 10.6.0-1.1 $
$CondorPlatform: X86_64-Ubuntu_22.04 $
```

Note that the "CondorPlatform" reports the type of computer we built it on, _not_ the computer we're running on. It was built on CentOS_7.6, but you might notice that we're running on Ubuntu Linux 24.04.

### Extra Tip: The OS version

Do you know how to find the OS version? You can usually look in /etc/os-release to find out:

```
$ cat /etc/os-release
```

Where is Condor installed? 

```
# Show the location of the condor_q binary
$ which condor_q
/usr/bin/condor_q
```

Condor has some configuration files that it needs to find. They are in the standard location, `/etc/condor`

```
$ ls /etc/condor
condor_config  condor_config.local  config.d  ganglia.d
```

Condor has some directories that it keeps records of jobs in. Remember that each submission computer keeps track of all jobs submitted to it. That's in the local directory: 

```
$ condor_config_val -v LOCAL_DIR
LOCAL_DIR = /home/jovyan/.condor/local
 # at: /etc/condor/condor_config.local, line 2
 # raw: LOCAL_DIR = $ENV(HOME)/.condor/local
```

The spool directory is where Condor keeps the jobs you submit, while the execute directory is where Condor keeps running jobs. Since this is a submission-only computer, it should be empty.

Check if Condor is running.  Your output will differ slightly, but you should see `condor_master` with the other Condor daemons listed under it:

```
$ ps auwx --forest | grep condor_ | grep -v grep
jovyan      17  0.0  0.0  23908  7816 ?        Ss   07:04   0:00 condor_master
jovyan      18  0.0  0.0   7600  2372 ?        S    07:04   0:00  \_ condor_procd -A /home/jovyan/.condor/local/run/procd_pipe -L /h
jovyan      19  0.0  0.0  18200  8212 ?        Ss   07:04   0:00  \_ condor_shared_port
jovyan      20  0.1  0.0  20200  9484 ?        Ss   07:04   0:01  \_ condor_collector
jovyan      21  0.1  0.0  20908  9916 ?        Ss   07:04   0:01  \_ condor_negotiator
jovyan      22  0.1  0.0  21592 10112 ?        Ss   07:05   0:01  \_ condor_schedd
jovyan      23  0.0  0.0  21344 10328 ?        Ss   07:05   0:01  \_ condor_startd
```

For this version of Condor there are four processes running: the condor_master, the condor_schedd, the condor_procd, and condor_schedd. In general, you might see many different Condor processes. Here's a list of the processes:

   * *condor_master*: This program runs constantly and ensures that all other parts of Condor are running. If they hang or crash, it restarts them.
   * *condor_schedd*: If this program is running, it allows jobs to be submitted from this computer--that is, your computer is a "submit machine". This will advertise jobs to the central manager so that it knows about them. It will contact a condor_startd on other execute machines for each job that needs to be started.
   * *condor_procd:* This process helps Condor track process (from jobs) that it creates
   * *condor_collector:* This program is part of the Condor central manager. It collects information about all computers in the pool as well as which users want to run jobs. It is what normally responds to the condor_status command. At the school, it is running on a different computer, and you can figure out which one: 

Other daemons include:

   * *condor_negotiator:* This program is part of the Condor central manager. It decides what jobs should be run where. It is run on the same computer as the collector.
   * *condor_startd:* If this program is running, it allows jobs to be started up on this computer--that is, your computer is an "execute machine". This advertises your computer to the central manager so that it knows about this computer. It will start up the jobs that run.
   * *condor_shadow:* For each job that has been submitted from this computer, there is one condor_shadow running. It will watch over the job as it runs remotely. In some cases it will provide some assistance (see the standard universe later.) You may or may not see any condor_shadow processes running, depending on what is happening on the computer when you try it out. 
   * *condor_shared_port:* Used to assist Condor with networking by allowing multiple Condor processes to share a single network port. 


## condor_q

You can find out what jobs have been submitted on your computer with the condor_q command: 

```
$ condor_q
-- Schedd: user-training.osgconnect.net : <128.135.158.195:9618?... @ 08/12/18 16:10:58
OWNER BATCH_NAME      SUBMITTED   DONE   RUN    IDLE   HOLD  TOTAL JOB_IDS

0 jobs; 0 completed, 0 removed, 0 idle, 0 running, 0 held, 0 suspended
```

The output that you see will be different depending on what jobs are running. Notice what we can see from this:

   * *ID*: We can see each jobs cluster and process number. For the first job, the cluster is 60256 and the process is 0.
   * *OWNER*: We can see who owns the job.
   * *SUBMITTED*: We can see when the job was submitted
   * *RUN_TIME*: We can see how long the job has been running.
   * *ST*: We can see what the current state of the job is. I is idle, R is running.
   * *PRI*: We can see the priority of the job.
   * *SIZE*: We can see the memory consumption of the job.
   * *CMD*: We can see the program that is being executed. 

### Extra Tip

What else can you find out with condor_q? Try any one of:

   * `man condor_q`
   * `condor_q -help`
   * [condor_q from the online manual](https://htcondor.readthedocs.io/en/latest/man-pages/condor_q.html)

### Double bonus points

How do you use the `-constraint` or `-format` options to `condor_q`? When would you want them? When would you use the -l option? This might be an easier exercise to try once you submit some jobs.

## condor_status

### Extra credit

What else can you find out with condor_status? Try any one of:

   * `condor_status -help`
   * [condor_status from the online manual](https://htcondor.readthedocs.io/en/latest/man-pages/condor_status.html)

Note in particular the options like `-master` and `-schedd`. When would these be useful? When would the `-l` option be useful? 


