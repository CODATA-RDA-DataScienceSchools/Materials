# Our Condor Installation

## Objective

This exercise should help you understand the basics of how Condor is installed, what Condor processes (a.k.a. daemons) are running, and what they do.

## Login to the Condor submit computer
Before you start, make sure you are logged into `training.osgconnect.net`

```
$ hostname
training.osgconnect.net
```

You should have been given your username and password when you arrived this afternoon. If you don't know them, talk to Rob.

## Looking at our Condor installation

How do you know what version of Condor you are using? Try <code>condor_version</code>: 

```
$ condor_version
$CondorVersion: 8.6.13 Jan 16 2019 $
$CondorPlatform: X86_64-CentOS_7.6 $
```

Note that the "CondorPlatform" reports the type of computer we built it on, _not_ the computer we're running on. It was built on CentOS_7.6, but you might notice that we're running on CentOS Linux release 7.3.1.

### Extra Tip: The OS version

Do you know how to find the OS version? You can usually look in /etc/os-release to find out:

```
$ cat /etc/os-release
```

Or you can run:

```
$ hostnamectl
```

Where is Condor installed? 

```
# Show the location of the condor_q binary
$ which condor_q
/usr/bin/condor_q

# Show which RPM installed Condor
$ rpm -q condor
condor-8.6.13-1.2.osg34.el7.x86_64
```

Condor has some configuration files that it needs to find. They are in the standard location, `/etc/condor`

```
$ ls /etc/condor
condor_config	     condor_ssh_to_job_sshd_config_template  ganglia.d
condor_config.local  config.d
```

Condor has some directories that it keeps records of jobs in. Remember that each submission computer keeps track of all jobs submitted to it. That's in the local directory: 

```
$ condor_config_val -v LOCAL_DIR
LOCAL_DIR = /var
 # at: /etc/condor/condor_config, line 26
 # raw: LOCAL_DIR = /var

$ ls -CF /var/lib/condor
execute/  spool/ spool.q1/ spool.q2/ spool.q3/ spool.q4/ spool.q5/
```

The spool directory is where Condor keeps the jobs you submit, while the execute directory is where Condor keeps running jobs. Since this is a submission-only computer, it should be empty.

Check if Condor is running.  Your output will differ slightly, but you should see `condor_master` with the other Condor daemons listed under it:

```
$ ps auwx --forest | grep condor_ | grep -v grep
condor   2299245  0.0  0.1  50972  7348 ?        Ss   Jul10   0:08 condor_master -pidfile /var/run/condor/condor_master.pid
root     2299287  0.0  0.1  25924  5072 ?        S    Jul10   1:54  \_ condor_procd -A /var/run/condor/procd_pipe -L /var/log/condor/ProcLog -R 1000000 -S 60 -C 499
condor   2299288  0.0  0.1  50596  7796 ?        Ss   Jul10   0:16  \_ condor_shared_port -f
condor   2299289  0.0  0.2  70020  9100 ?        Ss   Jul10   0:13  \_ condor_collector -f
condor   2299290  0.0  0.5 116132 23872 ?        Ss   Jul10   6:19  \_ condor_schedd -f
condor   2299291  0.0  0.1  51056  7956 ?        Ss   Jul10   0:59  \_ condor_negotiator -f
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
   * [condor_q from the online manual](http://www.cs.wisc.edu/condor/manual/v8.0/condor_q.html)

### Double bonus points

How do you use the `-constraint` or `-format` options to `condor_q`? When would you want them? When would you use the -l option? This might be an easier exercise to try once you submit some jobs.

## condor_status

You can find out what computers are in your Condor pool. (A pool is similar to a cluster, but it doesn't have the connotation that all computers are dedicated full-time to computation: some may be desktop computers owned by users.) To look, use condor_status:

```
$ condor_status -pool flock.opensciencegrid.org
Name                             OpSys      Arch   State     Activity LoadAv Mem    ActvtyTime

slot1@amundsen.grid.uchicago.edu LINUX      X86_64 Owner     Idle      0.000 32768  1+02:46:31
slot2@amundsen.grid.uchicago.edu LINUX      X86_64 Owner     Idle      0.000 32768  5+01:05:58
slot1@c2                         LINUX      X86_64 Unclaimed Idle      0.000 48289  3+10:04:49
slot1@dhcp-10-1-202-3            LINUX      X86_64 Unclaimed Idle      0.000  3251  0+08:10:13
slot1_1@dhcp-10-1-202-3          LINUX      X86_64 Claimed   Busy      0.990  6144  0+01:09:46
slot1_2@dhcp-10-1-202-3          LINUX      X86_64 Claimed   Busy      0.990  6144  0+00:46:46
slot1_3@dhcp-10-1-202-3          LINUX      X86_64 Claimed   Busy      0.990  2048  0+00:53:08
slot1_4@dhcp-10-1-202-3          LINUX      X86_64 Claimed   Busy      0.990  1024  0+05:48:14
slot1_5@dhcp-10-1-202-3          LINUX      X86_64 Claimed   Busy      0.000  6144  0+00:16:48
slot1_6@dhcp-10-1-202-3          LINUX      X86_64 Claimed   Busy      0.990  2816  0+13:16:34
...
```

Let's look at exactly what you can see:

   * *Name*: The name of the computer. Sometimes this gets chopped off, like above.
   * *OpSys*: The operating system, though not at the granularity you may wish: It says "Linux" instead of which distribution and version of Linux.
   * *Arch*: The architecture, such as INTEL or PPC.
   * *State*: The state is often Claimed (when it is running a Condor job) or Unclaimed (when it is not running a Condor job). It can be in a few other states as well, such as Matched.
   * *Activity*: This is usually something like Busy or Idle. Sometimes you may see a computer that is Claimed, but no job has yet begun on the computer. Then it is Claimed/Idle. Hopefully this doesn't last very long.
   * *LoadAv*: The load average on the computer.
   * *Mem*: The computers memory in megabytes.
   * *ActvtyTime*: How long the computer has been doing what it's been doing. 

### Extra credit

What else can you find out with condor_status? Try any one of:

   * `man condor_status`
   * `condor_status -help`
   * [condor_status from the online manual](http://www.cs.wisc.edu/condor/manual/v8.0/condor_status.html)

Note in particular the options like `-master` and `-schedd`. When would these be useful? When would the `-l` option be useful? 

