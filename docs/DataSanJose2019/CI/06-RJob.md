# Using scripting languages


## Objective
The objective of this exercise is to demonstrate that you can submit jobs to Condor in any language, including scripting languages.

At this point, you might be asking yourself, "This is all well and good, but I don't write programs in C. Can I use other languages?" Absolutely.

Let's assume you like to write program in Bourne shell. Make sure your program begins with `#!/bin/sh`, and you're good to go. Save this example code into a file called `simple.sh` using nano or your favorite editor. 

```
#!/bin/sh

if [ $# -ne 2 ]; then
    echo "Usage: simple.sh sleep-time integer"
    exit 1
fi

echo "Thinking really hard for $1 seconds.."
sleep $1
answer=$(( $2 * 2 ))
echo "We calculated $answer."
exit 0
```

This script will not be executable without changing the permissions.

```
$ chmod 755 simple.sh
```

Can you write a submit file to run this job? This should be easy--the script is your _Executable_, not `/bin/sh`. You may also want to change the name of your `submit.log`, `submit.out`, and `submit.err` in your `submit` file to be sure they are not written over when you run this submission. 

## Challenge
Rewrite this script in Perl or Python (if you're comfortable with one of those languages). Does it still work for you?

