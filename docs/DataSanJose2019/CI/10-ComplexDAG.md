# A More Complex DAG

### Objective
The objective of this exercise is to run a real set of jobs with DAGMan.

## Make your job submission files

We'll run our `goatbrot` example. If you didn't read about it yet, [please do so now](https://github.com/opensciencegrid/dosar/blob/master/docs/DataTrieste2018/08-Mandlebrot.md). We are going to make a DAG with four simultaneous jobs (`goatbrot`) and one final node to stitch them together (`montage`). This means we have five jobs. We're going to run `goatbrot` with more iterations (100,000) so it will take longer to run. 

You can create your five jobs. The goatbrot jobs very similar to each other, but they have slightly different parameters (arguments) and output files. 

I have placed the goatbrot executable in my public directory: `/stash/user/rquick/public/goatbrot-master/goatbrot`


### goatbrot1.sub

```
executable              = /stash/user/rquick/public/goatbrot-master/goatbrot
arguments               = -i 100000 -c -0.75,0.75 -w 1.5 -s 500,500 -o tile_0_0.ppm
log                     = goatbrot.log
output                  = goatbrot.out.0.0
error                   = goatbrot.err.0.0
requirements = (HAS_MODULES =?= true) && (OSGVO_OS_STRING == "RHEL 6") && (OpSys == "LINUX")
should_transfer_files   = YES
when_to_transfer_output = ONEXIT
queue
```

### goatbrot2.sub

```
executable              = /stash/user/rquick/public/goatbrot-master/goatbrot
arguments               = -i 100000 -c 0.75,0.75 -w 1.5 -s 500,500 -o tile_0_1.ppm
log                     = goatbrot.log
output                  = goatbrot.out.0.1
error                   = goatbrot.err.0.1
requirements = (HAS_MODULES =?= true) && (OSGVO_OS_STRING == "RHEL 6") && (OpSys == "LINUX")
should_transfer_files   = YES
when_to_transfer_output = ONEXIT
queue
```

### goatbrot3.sub

```
executable              = /stash/user/rquick/public/goatbrot-master/goatbrot
arguments               = -i 100000 -c -0.75,-0.75 -w 1.5 -s 500,500 -o tile_1_0.ppm
log                     = goatbrot.log
output                  = goatbrot.out.1.0
error                   = goatbrot.err.1.0
requirements = (HAS_MODULES =?= true) && (OSGVO_OS_STRING == "RHEL 6") && (OpSys == "LINUX")
should_transfer_files   = YES
when_to_transfer_output = ONEXIT
queue
```

### goatbrot4.sub

```
executable              = /stash/user/rquick/public/goatbrot-master/goatbrot
arguments               = -i 100000 -c 0.75,-0.75 -w 1.5 -s 500,500 -o tile_1_1.ppm
log                     = goatbrot.log
output                  = goatbrot.out.1.1
error                   = goatbrot.err.1.1
requirements = (HAS_MODULES =?= true) && (OSGVO_OS_STRING == "RHEL 6") && (OpSys == "LINUX")
should_transfer_files   = YES
when_to_transfer_output = ONEXIT
queue
```

### montage.sub

You should notice a few things about the montage submission file:

   1. The `transfer_input_files` statement refers to the files created by the other jobs. 
   1. We do *not* transfer the montage program because it is on OASIS.

```
universe                = vanilla
executable              = wrapper_montage.sh
arguments               = tile_0_0.ppm tile_0_1.ppm tile_1_0.ppm tile_1_1.ppm -mode Concatenate -tile 2x2 mandle.gif
should_transfer_files   = YES
when_to_transfer_output = ONEXIT
transfer_input_files    = tile_0_0.ppm,tile_0_1.ppm,tile_1_0.ppm,tile_1_1.ppm
transfer_executable     = true
output                  = montage.out
error                   = montage.err
log                     = montage.log
requirements = (HAS_MODULES =?= true) && (OSGVO_OS_STRING == "RHEL 6") && (OpSys == "LINUX")
queue
```

### wrapper_montage.sh

Because we are using OASIS, we will need to create a wrapper script to load the ImageMagick module so that we can use it to create the montage.  Put the following lines into `wrapper_montage.sh`:

```
source /cvmfs/oasis.opensciencegrid.org/osg/modules/lmod/current/init/bash
module load imagemagick
montage tile_0_0.ppm tile_0_1.ppm tile_1_0.ppm tile_1_1.ppm -mode Concatenate -tile 2x2 mandle.gif
```

## Make your DAG

In a file called `goatbrot.dag`, you have your DAG specification:

```
JOB g1 goatbrot1.sub
JOB g2 goatbrot2.sub
JOB g3 goatbrot3.sub
JOB g4 goatbrot4.sub
JOB montage montage.sub
PARENT g1 g2 g3 g4 CHILD montage
```

Ask yourself: do you know how we ensure that all the `goatbrot` commands can run simultaneously and all of them will complete before we run the montage job?

## Running the DAG

Submit your DAG:

```
$ condor_submit_dag goatbrot.dag
-----------------------------------------------------------------------
File for submitting this DAG to Condor           : goatbrot.dag.condor.sub
Log of DAGMan debugging messages                 : goatbrot.dag.dagman.out
Log of Condor library output                     : goatbrot.dag.lib.out
Log of Condor library error messages             : goatbrot.dag.lib.err
Log of the life of condor_dagman itself          : goatbrot.dag.dagman.log

Submitting job(s).
1 job(s) submitted to cluster 71.

-----------------------------------------------------------------------
```

## Watch your DAG

Watch with condor_q:

```
$ watch condor_q USER -nobatch
```

Here we see DAGMan running:

```
-- Submitter: kagross@frontal.cci.ucad.sn : <172.16.200.1:9645> : frontal.cci.ucad.sn
 ID      OWNER            SUBMITTED     RUN_TIME ST PRI SIZE CMD               
  68.0   kagross         8/19 11:38   0+00:00:10 R  0   0.3  condor_dagman

1 jobs; 0 completed, 0 removed, 0 idle, 1 running, 0 held, 0 suspended
```

DAGMan has submitted the goatbrot jobs, but they haven't started running yet (note that the `I` status stands for Idle):

```
-- Submitter: kagross@frontal.cci.ucad.sn : <172.16.200.1:9645> : frontal.cci.ucad.sn
 ID	 OWNER            SUBMITTED     RUN_TIME ST PRI SIZE CMD
  68.0   kagross         8/19 11:38   0+00:00:10 R  0   0.3  condor_dagman
  69.0   kagross         8/19 11:38   0+00:00:00 I  0   0.0  goatbrot -i 100000
  70.0   kagross         8/19 11:38   0+00:00:00 I  0   0.0  goatbrot -i 100000
  71.0   kagross         8/19 11:38   0+00:00:00 I  0   0.0  goatbrot -i 100000
  72.0   kagross         8/19 11:38   0+00:00:00 I  0   0.0  goatbrot -i 100000

6 jobs; 0 completed, 0 removed, 4 idle, 2 running, 0 held, 0 suspended
```

They're running!  (All four jobs are in state `R` - running)

```
-- Submitter: kagross@frontal.cci.ucad.sn : <172.16.200.1:9645> : frontal.cci.ucad.sn
 ID      OWNER            SUBMITTED     RUN_TIME ST PRI SIZE CMD               
  68.0   kagross         8/19 11:38   0+00:00:15 R  0   0.3  condor_dagman
  69.0   kagross         8/19 11:38   0+00:00:05 R  0   0.0  goatbrot -i 100000
  70.0   kagross         8/19 11:38   0+00:00:05 R  0   0.0  goatbrot -i 100000
  71.0   kagross         8/19 11:38   0+00:00:05 R  0   0.0  goatbrot -i 100000
  72.0   kagross         8/19 11:38   0+00:00:05 R  0   0.0  goatbrot -i 100000

5 jobs; 0 completed, 0 removed, 0 idle, 5 running, 0 held, 0 suspended
```

Two of the jobs have finished, while the others are still running (remember that completed jobs disappear from `condor_q` output):

```
-- Submitter: kagross@frontal.cci.ucad.sn : <172.16.200.1:9645> : frontal.cci.ucad.sn
 ID      OWNER            SUBMITTED     RUN_TIME ST PRI SIZE CMD               
  68.0   kagross         8/19 11:38   0+00:00:20 R  0   0.3  condor_dagman
  71.0   kagross         8/19 11:38   0+00:00:10 R  0   0.0  goatbrot -i 100000
  72.0   kagross         8/19 11:38   0+00:00:10 R  0   0.0  goatbrot -i 100000

3 jobs; 0 completed, 0 removed, 0 idle, 3 running, 0 held, 0 suspended
```

They finished, but DAGMan hasn't noticed yet. It only checks periodically:

```
-- Submitter: kagross@frontal.cci.ucad.sn : <172.16.200.1:9645> : frontal.cci.ucad.sn
 ID      OWNER            SUBMITTED     RUN_TIME ST PRI SIZE CMD               
  68.0   kagross         8/19 11:38   0+00:00:30 R  0   0.3  condor_dagman

1 jobs; 0 completed, 0 removed, 0 idle, 1 running, 0 held, 0 suspended
```

DAGMan submitted and ran the montage job. It ran so fast I didn't capture it running. DAGMan will finish up soon

```
-- Submitter: kagross@frontal.cci.ucad.sn : <172.16.200.1:9645> : frontal.cci.ucad.sn
 ID      OWNER            SUBMITTED     RUN_TIME ST PRI SIZE CMD               
  68.0   kagross         8/19 11:38   0+00:01:01 R  0   0.3  condor_dagman

1 jobs; 0 completed, 0 removed, 0 idle, 1 running, 0 held, 0 suspended
```

Now it's all done:
```
-- Submitter: kagross@frontal.cci.ucad.sn : <172.16.200.1:9645> : frontal.cci.ucad.sn
 ID      OWNER            SUBMITTED     RUN_TIME ST PRI SIZE CMD               

0 jobs; 0 completed, 0 removed, 0 idle, 0 running, 0 held, 0 suspended
```

Examine your results. For some reason, goatbrot prints everything to stderr, not stdout. 

```
$ cat goatbrot.err.0.0
Complex image:
            Center: -0.75 + 0.75i
             Width: 1.5
            Height: 1.5
        Upper Left: -1.5 + 1.5i
       Lower Right: 0 + 0i

Output image:
          Filename: tile_0_0.ppm
     Width, Height: 500, 500
             Theme: beej
       Antialiased: no

Mandelbrot:
    Max Iterations: 100000
        Continuous: no

Goatbrot:
    Multithreading: not supported in this build

Completed: 100.0%  
```

Examine your log files (`goatbrot.log` and `montage.log`) and DAGMan output file (`goatbrot.dag.dagman.out`). Do they look as you expect? Can you see the progress of the DAG in the DAGMan output file?

Does your final Mandlebrot image (`mandle.gif`) look correct? To view it we can use Stash.

```
$ cp mandle.gif ~/stash/public/
```

And now you can go to http://stash.osgconnect.net/~USER . You will see mandle.gif listed.  You can click on it to view it.

Clean up your results. Be careful about deleting the goatbrot.dag.* files, you do not want to delete the goatbrot.dag file, just goatbrot.dag.* . 

```
$ rm goatbrot.dag.*
$ rm goatbrot.out.*
$ rm goatbrot.err.*
```

## On your own.

   * Re-run your DAG. When jobs are running, try `condor_q -dag`. What does it do differently?
   * Challenge, if you have time: Make a bigger DAG by making more tiles in the same area. 
