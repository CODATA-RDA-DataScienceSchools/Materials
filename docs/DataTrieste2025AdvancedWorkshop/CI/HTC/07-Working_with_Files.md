# Working with data in files

### Objective
The objective of this exercise is to teach you how to provide files as input to your job, and get output as files back from your job.

## Data Movement
So far, we've done really simple examples where the entire input to the program is just on the command-line. What do you do if you have data files to deal with? Let's walk through a short example.

First, let's make a program, call it `analyze.sh` that analyzes a text file that it is provided on the command-line.

```
#!/bin/sh

if [ $# -ne 1 ]; then
    echo "Usage: analyze.sh <filename>"
    exit 1
fi

echo "About to do a deep analysis of $1..."
echo "First, we convert it to all upper case (see $1.upper)"
tr "[:lower:]" "[:upper:]" < $1 > $1.upper

echo "Next, we find the 10 most common words (see $1.10)"
cat $1 | tr "[:upper:]" "[:lower:]" | tr -cs "[:alpha:]" "\n" | sort | uniq -c | sort --key=1,7 -n -r  | head -10 > $1.10

sleep 5
```
You'll need to make this script executable:
```
chmod 755 analyze.sh
```

You also need a file to analyze. Put the following text into a file called `gettysburg`.

```
Four score and seven years ago our fathers brought forth on this
continent, a new nation, conceived in Liberty, and dedicated to the
proposition that all men are created equal.

Now we are engaged in a great civil war, testing whether that nation,
or any nation so conceived and so dedicated, can long endure. We are
met on a great battle-field of that war. We have come to dedicate a
portion of that field, as a final resting place for those who here
gave their lives that that nation might live. It is altogether fitting
and proper that we should do this.

But, in a larger sense, we can not dedicate -- we can not consecrate
-- we can not hallow -- this ground. The brave men, living and dead,
who struggled here, have consecrated it, far above our poor power to
add or detract. The world will little note, nor long remember what we
say here, but it can never forget what they did here. It is for us the
living, rather, to be dedicated here to the unfinished work which they
who fought here have thus far so nobly advanced. It is rather for us
to be here dedicated to the great task remaining before us -- that
from these honored dead we take increased devotion to that cause for
which they gave the last full measure of devotion -- that we here
highly resolve that these dead shall not have died in vain -- that
this nation, under God, shall have a new birth of freedom -- and that
government of the people, by the people, for the people, shall not
perish from the earth.
```

Our submit file looks nearly identical to what we had before, except for the one bolded line that specifies the data file to transfer.  Put the following text into a file called `submit.speech`.

```
Universe        = vanilla
Executable      = analyze.sh
Output          = analyze.out
Error           = analyze.error
Log             = analyze.log
Arguments       = gettysburg
ShouldTransferFiles = Yes
WhenToTransferOutput = ON_EXIT
transfer_input_files = gettysburg
queue 
```

Notice that you just had to specify the input files and not the output files. Condor will automatically transfer back any new files, so you don't have to worry about it. Nifty, huh?

Now run the job.

```
$ condor_submit submit.speech
Submitting job(s).
1 job(s) submitted to cluster 37.

$ ls -lh gettys*
-rw-rw-r--. 1 kagross kagross 1.5K Aug 18 15:41 gettysburg
-rw-r--r--. 1 kagross kagross  120 Aug 18 15:42 gettysburg.10
-rw-r--r--. 1 kagross kagross 1.5K Aug 18 15:42 gettysburg.upper
```

You got your files! Check them out--do they look okay?

## On your own
Create several text files, then submit jobs (preferably from a single submit file) to analyze each of them. If you're at a loss to create some text files, here are a few for you.

   * [Walkthrough of the Original Text Game "Adventure"](http://textfiles.com/100/adventur.txt)
   * [The Story of Captain Midnight](http://textfiles.com/100/captmidn.txt)
   * [The Universal Geek Code](http://textfiles.com/100/codegeek.txt)
   * [Tao of Programming](http://textfiles.com/100/taoprogram.pro)


Instead of downloading these files and transferring them directly, can you change your `transfer-input-files` to use a URL and have Condor download them for you? Give this a try.
