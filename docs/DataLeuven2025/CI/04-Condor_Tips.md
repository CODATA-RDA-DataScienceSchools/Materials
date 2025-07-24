# A few tips and tricks

### Objective
This exercise will teach you a few nifty commands to help you use Condor more easily.

## Tips for condor_q

`condor_q` can show you your job ClassAd. Recall back to the lecture and the discussion of ClassAds. For instance, you can look at the ClassAd for a single job:

```
$ condor_q -long YOUR_JOB_CLUSTER_NUMBER

MaxHosts = 1
User = "kagross@frontal.cci.ucad.sn"
OnExitHold = false
CoreSize = 0
MachineAttrCpus0 = 1
WantRemoteSyscalls = false
MyType = "Job"
Rank = 0.0
CumulativeSuspensionTime = 0
MinHosts = 1
PeriodicHold = false
PeriodicRemove = false
Err = "simple.49.error"
ProcId = 49
EnteredCurrentStatus = 1408374244
UserLog = "/home/kagross/condor-test/s
... output trimmed ... 
```

There are some interesting parts you can check out. 

How many CPUs is the job requesting. (This can be more than one, but for the exercises we will do today it will be 1)

```
$ condor_q -long YOUR_JOB_CLUSTER_NUMBER | grep RequestCpus
RequestCpus = 1
```

Where is the user log for this job? This is helpful when you assist someone else in debugging and they're not sure.

```
$ condor_q -long YOUR_JOB_CLUSTER_NUMBER | grep UserLog
UserLog = "/home/jovyan/condor_example/simple.9.log"
```

What are the job's requirements? Condor automatically fills some in for you to make sure your job runs on a reasonable computer in our cluster, but you can override any of these. I've broken the output into multiple lines to explain it to you.

```
$ condor_q -l YOUR_JOB_CLUSTER_NUMBER | grep Requirements
Requirements =( TARGET.Arch == "X86_64" ) <em># Run on a 64-bit computer
    && ( TARGET.OpSys == "LINUX" )  <em># Make sure you run on Linux
    && ( TARGET.Disk >= RequestDisk ) <em># Make sure the default disk Condor is on has enough disk space.
    && ( TARGET.Memory >= RequestMemory )  <em># Make sure the computer has enough memory
    && ( TARGET.HasFileTransfer )  <em># Only run on a computer that can accept your files.
```

What else can you find that's interesting in the ClassAd?

## Removing jobs

If you submit a job that you realize has a problem, you can remove it with `condor_rm`. For example: 

```
$ condor_q

-- Submitter: osg-ss-submit.chtc.wisc.edu : <128.104.100.55:9618?sock=28867_10e4_2> : osg-ss-submit.chtc.wisc.edu
 ID      OWNER            SUBMITTED     RUN_TIME ST PRI SIZE CMD               
  29.0   roy             6/21 15:23   0+00:00:00 I  0   0.7  simple 60 10      

1 jobs; 0 completed, 0 removed, 2 idle, 0 running, 0 held, 0 suspended

$ condor_rm YOUR_JOB_CLUSTER_NUMBER
Job 29.0 marked for removal

$ condor_q

-- Submitter: osg-ss-submit.chtc.wisc.edu : <128.104.100.55:9618?sock=28867_10e4_2> : osg-ss-submit.chtc.wisc.edu
 ID      OWNER            SUBMITTED     RUN_TIME ST PRI SIZE CMD               

0 jobs; 0 completed, 0 removed, 1 idle, 0 running, 0 held, 0 suspended
```

A few tips:

   * You can remove all of your jobs with the `-all` option.
   * You can't remove other users jobs.
   * There are [fancy options to condor_rm](http://www.cs.wisc.edu/condor/manual/v8.4/condor_rm.html).  

## Historical information

You can see information about jobs that completed and are no longer in the queue with the <code>condor_history</code> command. It's rare that you want to see *all* the jobs, so try looking at jobs for just you:

```
$ condor_history USER
```

When using JupyterLab the USER is `jovyan`.

For example:
```
$ condor_history jovyan
 ID     OWNER          SUBMITTED   RUN_TIME     ST COMPLETED   CMD            
4.9     jovyan          8/15 08:20   0+00:00:14 C   8/15 08:20 /home/jovyan/condor_example/simple 9 4
4.8     jovyan          8/15 08:20   0+00:00:11 C   8/15 08:20 /home/jovyan/condor_example/simple 8 4
4.7     jovyan          8/15 08:20   0+00:00:11 C   8/15 08:20 /home/jovyan/condor_example/simple 7 4
4.6     jovyan          8/15 08:20   0+00:00:10 C   8/15 08:20 /home/jovyan/condor_example/simple 6 4
4.5     jovyan          8/15 08:20   0+00:00:08 C   8/15 08:20 /home/jovyan/condor_example/simple 5 4
4.4     jovyan          8/15 08:20   0+00:00:08 C   8/15 08:20 /home/jovyan/condor_example/simple 4 4
...
```
