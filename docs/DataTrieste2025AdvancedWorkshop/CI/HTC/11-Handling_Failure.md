# Handling a DAG that fails

### Objective
The objective of this exercise is to help you learn how DAGMan deals with job failures. DAGMan is built to help you recover from such failures.

DAGMan can handle a situation where some of the nodes in a DAG fails. DAGMan will run as many nodes as possible, then create a "rescue DAG".  A rescue DAG allows you to fix the problem and then resume your job where it left off.

Recall that DAGMan decides that a jobs fails if its exit code is non-zero. Let's modify our montage job so that it fails. Work in the same directory where you did the last DAG. Edit montage.sub to add a `-h` to the arguments. It will look like this (the change is bolded):

```
universe                = vanilla
executable              = ~/opt/bin/montage
arguments               = -h tile_0_0.ppm tile_0_1.ppm tile_1_0.ppm tile_1_1.ppm -mode Concatenate -tile 2x2 mandle.jpg
should_transfer_files   = YES
when_to_transfer_output = ONEXIT
transfer_input_files    = tile_0_0.ppm,tile_0_1.ppm,tile_1_0.ppm,tile_1_1.ppm
transfer_executable     = true
output                  = montage.out
error                   = montage.err
log                     = goat.log
queue
```

Submit the DAG again: 

```
$ condor_submit_dag goatbrot.dag
-----------------------------------------------------------------------
File for submitting this DAG to Condor           : goatbrot.dag.condor.sub
Log of DAGMan debugging messages                 : goatbrot.dag.dagman.out
Log of Condor library output                     : goatbrot.dag.lib.out
Log of Condor library error messages             : goatbrot.dag.lib.err
Log of the life of condor_dagman itself          : goatbrot.dag.dagman.log

Submitting job(s).
1 job(s) submitted to cluster 77.
-----------------------------------------------------------------------
```


Use `condor_watch_q` to watch the jobs until they finish.

In a separate window, use `tail --lines=500 -f goatbrot.dag.dagman.out` to watch what DAGMan does. 

```
06/22/12 17:57:41 Setting maximum accepts per cycle 8.
06/22/12 17:57:41 ******************************************************
06/22/12 17:57:41 ** condor_scheduniv_exec.77.0 (CONDOR_DAGMAN) STARTING UP
06/22/12 17:57:41 ** /usr/bin/condor_dagman
06/22/12 17:57:41 ** SubsystemInfo: name=DAGMAN type=DAGMAN(10) class=DAEMON(1)
06/22/12 17:57:41 ** Configuration: subsystem:DAGMAN local:<NONE> class:DAEMON
06/22/12 17:57:41 ** $CondorVersion: 7.7.6 Apr 16 2012 BuildID: 34175 PRE-RELEASE-UWCS $
06/22/12 17:57:41 ** $CondorPlatform: x86_64_rhap_5.7 $
06/22/12 17:57:41 ** PID = 26867
06/22/12 17:57:41 ** Log last touched time unavailable (No such file or directory)
06/22/12 17:57:41 ******************************************************
06/22/12 17:57:41 Using config source: /etc/condor/condor_config
06/22/12 17:57:41 Using local config sources: 
06/22/12 17:57:41    /etc/condor/config.d/00-chtc-global.conf
06/22/12 17:57:41    /etc/condor/config.d/01-chtc-submit.conf
06/22/12 17:57:41    /etc/condor/config.d/02-chtc-flocking.conf
06/22/12 17:57:41    /etc/condor/config.d/03-chtc-jobrouter.conf
06/22/12 17:57:41    /etc/condor/config.d/04-chtc-blacklist.conf
06/22/12 17:57:41    /etc/condor/config.d/99-osg-ss-group.conf
06/22/12 17:57:41    /etc/condor/config.d/99-roy-extras.conf
06/22/12 17:57:41    /etc/condor/condor_config.local

... output trimmed ...

06/22/12 18:08:42 Event: ULOG_EXECUTE for Condor Node montage (82.0.0)
06/22/12 18:08:42 Number of idle job procs: 0
06/22/12 18:08:42 Event: ULOG_IMAGE_SIZE for Condor Node montage (82.0.0)
06/22/12 18:08:42 Event: ULOG_JOB_TERMINATED for Condor Node montage (82.0.0)
06/22/12 18:08:42 Node montage job proc (82.0.0) failed with status 1.
06/22/12 18:08:42 Number of idle job procs: 0
06/22/12 18:08:42 Of 5 nodes total:
06/22/12 18:08:42  Done     Pre   Queued    Post   Ready   Un-Ready   Failed
06/22/12 18:08:42   ===     ===      ===     ===     ===        ===      ===
06/22/12 18:08:42     4       0        0       0       0          0        1
06/22/12 18:08:42 0 job proc(s) currently held
06/22/12 18:08:42 Aborting DAG...
06/22/12 18:08:42 Writing Rescue DAG to goatbrot.dag.rescue001...
06/22/12 18:08:42 Note: 0 total job deferrals because of -MaxJobs limit (0)
06/22/12 18:08:42 Note: 0 total job deferrals because of -MaxIdle limit (0)
06/22/12 18:08:42 Note: 0 total job deferrals because of node category throttles
06/22/12 18:08:42 Note: 0 total PRE script deferrals because of -MaxPre limit (0)
06/22/12 18:08:42 Note: 0 total POST script deferrals because of -MaxPost limit (0)
06/22/12 18:08:42 **** condor_scheduniv_exec.77.0 (condor_DAGMAN) pid 26867 EXITING WITH STATUS 1
```

DAGMan notices that one of the jobs failed because it's exit code was non-zero. DAGMan ran as much of the DAG as possible and logged enough information to continue the run when the situation is resolved. Do you see the part where it wrote the resuce DAG?

Look at the rescue DAG. It's called a partial DAG: it indicates what part of the DAG has already been completed. When you re-submit the original DAG, DAGMan will notice the rescue DAG and use it in combination with the original DAG. (The rescue DAG used to be the full DAG with nodes marked as done and you would ask DAGMan to run the new rescue DAG. For your simplicity DAGMan lets you resubmit the original DAG and it reads both files.)

```
$ cat goatbrot.dag.rescue001
# Rescue DAG file, created after running
#   the goatbrot.dag DAG file
# Created 6/22/2012 23:08:42 UTC
# Rescue DAG version: 2.0.1 (partial)
#
# Total number of Nodes: 5
# Nodes premarked DONE: 4
# Nodes that failed: 1
#   montage,<ENDLIST>

DONE g1
DONE g2
DONE g3
DONE g4
```

From the comment near the top, we know that the montage node failed. Let's fix it by getting rid of the offending `-h` argument. Change `montage.sub` to look like:

```
universe                = vanilla
executable              = ~/opt/bin/montage
arguments               = tile_0_0.ppm tile_0_1.ppm tile_1_0.ppm tile_1_1.ppm -mode Concatenate -tile 2x2 mandle.jpg
should_transfer_files   = YES
when_to_transfer_output = ONEXIT
transfer_input_files    = tile_0_0.ppm,tile_0_1.ppm,tile_1_0.ppm,tile_1_1.ppm
transfer_executable     = true
output                  = montage.out
error                   = montage.err
log                     = goat.log
queue
```

Now we can re-submit our original DAG and DAGMan will pick up where it left off. It will automatically notice the rescue DAG If you didn't fix the problem, DAGMan would generate another rescue DAG.

```
$ condor_submit_dag goatbrot.dag
Running rescue DAG 1
-----------------------------------------------------------------------
File for submitting this DAG to Condor           : goatbrot.dag.condor.sub
Log of DAGMan debugging messages                 : goatbrot.dag.dagman.out
Log of Condor library output                     : goatbrot.dag.lib.out
Log of Condor library error messages             : goatbrot.dag.lib.err
Log of the life of condor_dagman itself          : goatbrot.dag.dagman.log

Submitting job(s).
1 job(s) submitted to cluster 83.
-----------------------------------------------------------------------

$ tail -f goatbrot.dag.dagman.out
06/23/12 11:30:53 ******************************************************
06/23/12 11:30:53 ** condor_scheduniv_exec.83.0 (CONDOR_DAGMAN) STARTING UP
06/23/12 11:30:53 ** /usr/bin/condor_dagman
06/23/12 11:30:53 ** SubsystemInfo: name=DAGMAN type=DAGMAN(10) class=DAEMON(1)
06/23/12 11:30:53 ** Configuration: subsystem:DAGMAN local:<NONE> class:DAEMON
06/23/12 11:30:53 ** $CondorVersion: 7.7.6 Apr 16 2012 BuildID: 34175 PRE-RELEASE-UWCS $
06/23/12 11:30:53 ** $CondorPlatform: x86_64_rhap_5.7 $
06/23/12 11:30:53 ** PID = 28576
06/23/12 11:30:53 ** Log last touched 6/22 18:08:42
06/23/12 11:30:53 ******************************************************
06/23/12 11:30:53 Using config source: /etc/condor/condor_config
...
```

Here is where DAGMAN notices that there is a rescue DAG:

```
06/23/12 11:30:53 Parsing 1 dagfiles
06/23/12 11:30:53 Parsing goatbrot.dag ...
06/23/12 11:30:53 Found rescue DAG number 1; running goatbrot.dag.rescue001 in combination with normal DAG file
06/23/12 11:30:53 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
06/23/12 11:30:53 USING RESCUE DAG goatbrot.dag.rescue001
06/23/12 11:30:53 Dag contains 5 total jobs
```

Shortly thereafter it sees that four jobs have already finished:

```
06/23/12 11:31:05 Bootstrapping...
06/23/12 11:31:05 Number of pre-completed nodes: 4
06/23/12 11:31:05 Registering condor_event_timer...
06/23/12 11:31:06 Sleeping for one second for log file consistency
06/23/12 11:31:07 MultiLogFiles: truncating log file /home/roy/condor/goatbrot/montage.log
```

Here is where DAGMan resubmits the montage job and waits for it to complete:

```
06/23/12 11:31:07 Submitting Condor Node montage job(s)...
06/23/12 11:31:07 submitting: condor_submit 
      -a dag_node_name' '=' 'montage 
      -a +DAGManJobId' '=' '83 
      -a DAGManJobId' '=' '83 
      -a submit_event_notes' '=' 'DAG' 'Node:' 'montage 
      -a DAG_STATUS' '=' '0 
      -a FAILED_COUNT' '=' '0 
      -a +DAGParentNodeNames' '=' '"g1,g2,g3,g4" 
      montage.sub
06/23/12 11:31:07 From submit: Submitting job(s).
06/23/12 11:31:07 From submit: 1 job(s) submitted to cluster 84.
06/23/12 11:31:07   assigned Condor ID (84.0.0)
06/23/12 11:31:07 Just submitted 1 job this cycle...
06/23/12 11:31:07 Currently monitoring 1 Condor log file(s)
06/23/12 11:31:07 Event: ULOG_SUBMIT for Condor Node montage (84.0.0)
06/23/12 11:31:07 Number of idle job procs: 1
06/23/12 11:31:07 Of 5 nodes total:
06/23/12 11:31:07  Done     Pre   Queued    Post   Ready   Un-Ready   Failed
06/23/12 11:31:07   ===     ===      ===     ===     ===        ===      ===
06/23/12 11:31:07     4       0        1       0       0          0        0
06/23/12 11:31:07 0 job proc(s) currently held
06/23/12 11:40:22 Currently monitoring 1 Condor log file(s)
06/23/12 11:40:22 Event: ULOG_EXECUTE for Condor Node montage (84.0.0)
06/23/12 11:40:22 Number of idle job procs: 0
06/23/12 11:40:22 Event: ULOG_IMAGE_SIZE for Condor Node montage (84.0.0)
06/23/12 11:40:22 Event: ULOG_JOB_TERMINATED for Condor Node montage (84.0.0)
```

This is where the montage finished:

```
06/23/12 11:40:22 Node montage job proc (84.0.0) completed successfully.
06/23/12 11:40:22 Node montage job completed
06/23/12 11:40:22 Number of idle job procs: 0
06/23/12 11:40:22 Of 5 nodes total:
06/23/12 11:40:22  Done     Pre   Queued    Post   Ready   Un-Ready   Failed
06/23/12 11:40:22   ===     ===      ===     ===     ===        ===      ===
06/23/12 11:40:22     5       0        0       0       0          0        0
06/23/12 11:40:22 0 job proc(s) currently held
```

And here DAGMan decides that the work is all done:

```
06/23/12 11:40:22 All jobs Completed!
06/23/12 11:40:22 Note: 0 total job deferrals because of -MaxJobs limit (0)
06/23/12 11:40:22 Note: 0 total job deferrals because of -MaxIdle limit (0)
06/23/12 11:40:22 Note: 0 total job deferrals because of node category throttles
06/23/12 11:40:22 Note: 0 total PRE script deferrals because of -MaxPre limit (0)
06/23/12 11:40:22 Note: 0 total POST script deferrals because of -MaxPost limit (0)
06/23/12 11:40:22 **** condor_scheduniv_exec.83.0 (condor_DAGMAN) pid 28576 EXITING WITH STATUS 0</pre>
```

Success! Now go ahead and clean up. 

## Challenge

If you have time, add an extra node to the DAG. Copy our original `simple` program, but make it exit with a 1 instead of a 0. DAGMan would consider this a failure, but you'll tell DAGMan that it's really a success. This is reasonable--many real world programs use a variety of return codes, and you might need to help DAGMan distinguish success from failure.

Write a POST script that checks the return value. Check [the Condor manual](http://www.cs.wisc.edu/condor/manual/v8.4/2_10DAGMan_Applications.html#dagman:SCRIPT) to see how to describe your post script. 
