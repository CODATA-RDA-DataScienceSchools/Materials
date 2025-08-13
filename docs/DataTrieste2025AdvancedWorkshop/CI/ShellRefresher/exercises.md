# Bash Exercise

These exercises came from the [Duke HTS Summer School](https://people.duke.edu/~ccc14/duke-hts-2018/janice/2_Intro_to_Unix_and_bash.html)

Do the following exercises. Feel free to use `man`, or `<command> --help` or even Google to find solutions. Avoid copy and pasting solutins though - we want you to learn how to do these operations fluently, and typing the commands will help.

## 0. Clean up

This will remove the docs folder in your home direcotry if you have one.
`
rm -rf ~/docs
`

## 1. Creating text files

Create a file with the following contents in a new `docs` folder in your home directory

```
first,last,middle,age,sex
Jane,Frost,G,23,F
John,Mundy,F,25,M
Bob,Evans,H,57,M
John,Smith,M<4,M
```

- First make the `docs` folder in your home directory and make that your working directory
- Using `echo` and redirection (save as `echo.txt`)
- Using `cat` and a `heredoc` (save as `cat.txt`)
- Using a `nano` text editor (save as `editor.txt`). You can also use `emacs` or `vi` if you are familiar with these traditional editors.


## 2. File and directory management.

- Display your current working directory
- Change your working directory to your hoem directory if not already there
- List the contents of the `docs` folder in your home directory
- Make a new directory `stuff` within the `docs` folder
- Move the files `cat.txt` and `editor.txt` to the `stuff` folder
- Copy the file `echo.txt` to the `stuff` folder as `echoecho.txt`
- Show the contents of the docs directory recursively
- Remove the `stuff` directory and everything in it

## 3. Working with text files

- Display the contents of `echo.txt` without the header (first) line
- Display the contents of `echo.txt` sorted by first name (do not display the first row)
- Display the contents of `echo.txt` sorted by age in descending order (do not display the first row)
- Display only lines that contain `John`
- Display only lines that do not contain `John`
- Display only lines that contain 4-letter words starting with `J`
- Save only the first three columns of data sorted by last name to a new file `names.txt` in the `docs` folder (do not display the first row))

### Optional challenging exercises

- Display the contents of `echo.txt` but changing all occurrences of `John` to `Tom` (You should use the [sed](https://www.geeksforgeeks.org/sed-command-in-linux-unix-with-examples/) command)

## Looping

- Using a for loop, save lines 2 to 3 of each file in the docs folder as a new file with a name that looks like `<originaal name>-copy.txt` in a folder with a name like `<originaal name>`.

- Upon completiton, `ls -R ~/docs` should have this structure

```
/home/cliburn/docs:
echo  echo.txt   names  names.txt

/home/cliburn/docs/echo:
echo-copy.txt

/home/cliburn/docs/names:
names-copy.txt
```

- Upon completioin, `wc ~/docs/*/*` shouod show this

```
2  2 36 docs/echo/echo-copy.txt
2  2 26 docs/names/names-copy.txt
6  6 96 total
```

Hints:

- Use variables to store path and file names (convetnion for variable names is ALL_CAPS_WITH_UNDERSCORES)
- The direcotry part of a path can be extracted with `dirname`
- The filename part of a path can be extracted with `basename`
- You can remove the file extension of a filename stored in `X` with `Y=${X%.*}`
- Experiment using the above hints with simple one line commands to understand what they do
- Use `echo` statements in your for loop to see what is going on

