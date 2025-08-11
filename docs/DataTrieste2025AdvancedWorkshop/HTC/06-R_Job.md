# Running a job with R

### Objective
The objective of this exercise is to learn how to run a program that depends on a larger run-time environment that isn't already available on your cluster.  The run-time environment refers to all the hardware and software resources available on the machine where your job is running.  We will focus on the available software in this exercise.

## The Problem

Sometimes you want to run a program that depends on a larger run-time environment. For example, perhaps you wrote your program in Perl, but there is no Perl installed on the cluster. (That's an unlikely example, intended just to give you feel for what I mean by "run-time environment".) This is a common problem distributed computing users encounter. For example, many people like to use [Matlab](http://www.mathworks.com/) (or its open-source cousin, [Octave](http://www.gnu.org/software/octave/)) or [R](http://www.r-project.org/) for doing calculations. These require a fair amount of run-time environment to run the programs you write. What do you do if they aren't installed?

There are at least two possibilities:

   1. Ask your kindly system administrator to install it for you on all of the computers you might run on.
   1. Bring the environment (Such as Octave or R) along with your job. 

Before you read any further, please stop for a moment, and think about the tradeoffs between these two methodologies. They both have benefits and drawbacks. Why would you choose each of them? Why not? 

Here are some of my answers...

### Pros and cons of having your system administrator do it for you

   * PRO - It's a lot easier for you.
   * PRO - You have to transfer less data with each job.
   * CON - You have to wait for the system administrator to install them.
   * CON - If you want upgrades (or downgrades), you have to ask again and wait for them.

### Pros and cons of bringing it along
   * CON - It's more complex for you.
   * CON - You have to transfer the application and data with each job (or have a job that pre-stages it for you.)
   * PRO - You are in complete control: when you need a tweak, an upgrade, or a downgrade, you can make it happen.


Clearly, there is a choice here. I'd like to enable you to be able to bring along your run-time environment with you. In my experience, if you are capable of bringing it with you, you can take advantage of more computers: you don't have to wait for someone to build and install the environment for you. 

We'd like to demonstrate how to install one run-time environment called [R](http://www.r-project.org/). Don't worry if you have no experience with it: neither do I. It's a package for doing math and statistics and it lets you write programs in the R language. (Actually, it's the S language. Who chose names like this that are hard to Google?) We've built a minimal version of R that won't do graphical output, which makes it much less interesting, but it's good enough for our purposes.

You'll need an R program. After hours of <strike>combing the internet</strike> coding, I present to you my first R program. Save it in a file called `demo.r` using nano or your favorite editor:

```
len <- 100
fibvals <- numeric(len)
fibvals[1] <- 1
fibvals[2] <- 1
for (i in 3:len) { 
   fibvals[i] <- fibvals[i-1]+fibvals[i-2]
} 
print("First 100 Fibonacci numbers:")
for (i in 1:len) { 
    print(fibvals[i], digits = 21)
}
print("Number of possible combinations of cards in a 52 card deck:")
comb <- factorial(52)
print(comb, digits = 21)
```

This program prints the first 100 [Fibonacci numbers](http://en.wikipedia.org/wiki/Fibonacci_number). These are the numbers that show up in the weirdest places, like pineapples and sunflowers. It's a sequence of numbers beginning with 0, 1, 1, 2, 3, 5, 8... where each successive number is the sum of the previous two numbers. It also prints 52 factorial, which is the number of possible combinations of a standard 52-card deck (not including the jokers, of course). 

R is a bit fussy about where it's been installed on disk, so I had to write a wrapper program so it will happily run wherever it lands in our cluster. I could make you work it out, but that seems unfair. Save this program in `run-r.sh`. If you're curious about exactly why it's needed, ask Rob. There are two important parts to it, and you should know what they are, at least conceptually because this is the magic you would need to do for any run-time environment you want to bring along.

   1. Load the R environment using `module`. In general you might have to do more work. 
   1. Invoke R, using whatever magic is needed. In our case, I set up some environment variables and invoke the right executable.

```
#!/bin/sh -x

if [ $# -ne 1 ]; then
    echo "Usage: run-r "
    exit 1
fi

# Invoke R with the proper environment
R --slave --vanilla < $1
```

You could easily execute this on OSG Connect locally by making the shell script executable and executing it.

```
$ chmod 755 run-r.sh
$ ./run-r.sh demo.r
```

## On your own
Write a Condor submit file that will use R to run the `demo.r` program. 

Make sure you get back the output. Make sure you transfer the program. 

## The answer

This should be easy for you now, but if it's not, here's the answer, just in case.

```
universe = vanilla
executable = run-r.sh
arguments = demo.r
transfer_input_files = demo.r
log = R.log.$(Cluster).$(Process)
error = R.err.$(Cluster).$(Process)
output = R.out.$(Cluster).$(Process)
queue  
```

