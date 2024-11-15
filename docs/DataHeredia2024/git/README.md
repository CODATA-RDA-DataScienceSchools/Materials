
## Version Control Systems

### Definition:
* A system that records **changes to a file or set of files over time** so you can **recover specific versions** later;
* You can do this with **almost any type of file on a computer**;
  * Many people’s version control method is copying files to another directory (perhaps with a timestamp if they’re smart) – the simplest form.
    * **Very easy to make mistakes**;
    * Easy to forget which directory you’re in and accidentally overwrite the wrong file or copy files you didn’t intend to.
* **Local version control systems** (local version databases);

![image](https://hackmd.io/_uploads/BJ4UH6VGye.png)

## Git

### Git History

* Linux Kernel Project
  * **Patches sent back and forth** (1991–2002);
  * 2002: proprietary system called *BitKeeper*;
  * 2005: **End of free status** for *BitKeeper*;
* Development of their own system;
* VCS goals:
  * Speed
  * Simple design
  * Strong support for non-linear development (thousands of **parallel branches**);
  * **Fully distributed**;
  * Able to handle large projects like the Linux kernel efficiently (speed and data size).

### What is Git?

* Conceptually, most other systems store information as a **list of file-based changes**.
* Information is stored as a **set of files** and **changes made to each file over time**.
  * *Delta-based* version control;

![](https://i.imgur.com/Zr4SYwp.png)

* Git thinks of its data more as a **series of snapshots of a filesystem**.
* Every time you **save the state of your project**, Git **takes a snapshot of how all your files look at that moment and stores a reference to that snapshot**.
  * If the files haven’t changed, Git doesn’t store the file again, just a link to the previous identical file already stored.

![](https://i.imgur.com/eiIXMVY.png)

* Most Git operations **only need local files and resources to operate**;
  * The entire project history is right there on your local disk;
  * Fast operations;
  * E.g., querying the history is almost instantaneous.
* Everything in Git is checked using a *checksum* before being stored and is then **identified by that *checksum***.
  * **Impossible to alter the contents of any file or directory without Git knowing about it**.
  * *SHA-1 hash*.
* Three main sections of a Git project: the **working tree, the staging area, and the Git directory**.

![](https://i.imgur.com/xmKjtjO.png)

* Git has three main states in which files can reside: *modified*, *staged*, and *committed*:
* **The working tree** is a single **check-out of one version of the project**.
  * These files are **extracted from the compressed database in the Git directory** and **placed on disk** for you to use or modify.
* **The staging area** is **a file** (*index*), usually contained in your Git directory.
  * Stores information about what will go into your next commit.
* **The Git directory** is where Git stores the metadata and object database for your project.
  * The most important part of Git;
  * What’s copied when you clone a repository from another computer.
* Workflow:
  1. **Modify files** in your working tree.
  2. **Selectively stage only the changes you want** to be part of your next commit, which adds those changes to the staging area.
  3. **Commit your changes**, which takes the files as they are in the staging area and **stores a permanent snapshot of the filesystem** in your Git directory.



### Centralized Version Control Systems

![](https://i.imgur.com/iC0o3Iz.png)

* Need for **distributed collaboration**;
* Centralized systems:
  * **A single server** that contains all versioned files;
  * Clients perform **check-outs of files from that central location**;
  * **Standard for many years**.
* **Advantages**:
  * Everyone knows, to some extent, **what everyone else on the project is doing**.
  * Administrators have **fine-grained control over who can do what**.
    * It’s much **easier to administer a CVCS than to deal with local databases** on each client.
* **Disadvantages**:
  * **Single point of failure**;
    * A failure in the central DB can result in the loss of all data.

### Distributed Version Control Systems

![](https://i.imgur.com/isVkHIZ.png)

* **Complete mirror** of the repository (**including history**);
* In case of a failure, one of the client repos can be **promoted to the main repo**;
* Enables **multiple workflows** that are not possible with centralized systems, such as hierarchical models.

From now we will continue with the [Software Carpentry Git Lessons](https://swcarpentry.github.io/git-novice/aio.html)


# Aditional Information

### Git Setup

* `git config` allows you to get and set configuration variables that control all aspects of how Git looks and operates;
* Variables can be stored in three different places:
  * `/etc/gitconfig`: system-wide
    * Specified with `--system` option.
  * `~/.gitconfig` or `~/.config/git/config`: applies to all user repositories.
    * Specified with `--global` option.
  * `config` file in the `.git` directory: applies only to a given repository.
    * Specified with `--local` option.
  * Precedence: `local > global > system`.
* Listing all configurations:
```bash
$ git config --list
```

* Setting identity:
  * Every Git commit uses this information, and it’s immutably embedded in the commits you create:
```bash
$ git config --global user.name "User 1"
$ git config --global user.email user1@example.com
```
* Configuring editor:
  * Used when commit messages need to be typed:
```bash
$ git config --global core.editor nano
```

* Testing `--show-origin` option:
```bash
$ git config --show-origin user.name
```

### Getting Help

```bash
$ git help <verb> 
$ git <verb> --help 
$ man git-<verb>
```
* Example with `$ git commit --help`.

### Getting a Repository

#### Initializing a Repo from a Local Directory

* The `$ git init` command:
  * This creates a new subdirectory called `.git` that contains all your repository files.

```bash
$ git init
$ ls -aF
./  ../  .git/
```

#### Cloning a Remote Repository

* Git gets a complete copy of almost all data that the server has.
* Every version of every file in the project’s history is pulled by default when you run `git clone`.

```bash
$ git clone https://github.com/ruanyf/simple-bash-scripts.git
```

* This creates a directory called `simple-bash-scripts`, initializes a `.git` directory inside it, pulls all the data for that repository, and checks out a working copy of the latest version.
* Supported protocols include `https://`, `git://`, or `user@server:path/to/repo.git`.

### Making Changes to the Repository

* Normally, you’ll **make changes and commit snapshots of those changes to your repository** whenever the project reaches a state you want to record.
* Each file in your working directory can be in one of **two states**: **tracked or untracked**.
  * **Tracked files** are those in the last snapshot and any files staged for the next commit; they can be unmodified, modified, or staged. In short, tracked files are those Git knows about.
  * **Untracked files** are everything else—any files in your working directory that were not in your last snapshot and are not staged for the next commit.
    * When you first clone a repository, all your files are tracked and unmodified because Git just checked them out, and you haven’t edited anything yet.
* As you edit files, Git sees them as modified because they’ve changed since your last commit.
  * As you work, you stage these modified files and then commit all the staged changes, repeating the cycle.

![](https://i.imgur.com/oOjVO4H.png)

#### Checking the Status of Changes

* The main tool for determining the state of files is the `git status` command.
  * Running this command immediately after a clone should give you something like this:

```bash
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
```

Once Git is configured, we can start using it.

We will help Alfredo with his new project, create a repository with all his recipes.

First, let’s create a new directory in the Desktop folder for our work and then change the current working directory to the newly created one:

```
$ cd ~/Desktop
$ mkdir recipes
$ cd recipes
```
Then we tell Git to make recipes a repository -- a place where Git can store versions of our files:

```
$ git init
```
It is important to note that `git init` will create a repository that can include subdirectories and their files—there is no need to create separate repositories nested within the recipes repository, whether subdirectories are present from the beginning or added later. Also, note that the creation of the recipes directory and its initialization as a repository are completely separate processes.

If we use ls to show the directory’s contents, it appears that nothing has changed:

```
$ ls -a

.	..	.git
```

Git uses this special subdirectory to store all the information about the project, including the tracked files and sub-directories located within the project’s directory. If we ever delete the .git subdirectory, we will lose the project’s history.

We can now start using one of the most important git commands, which is particularly helpful to beginners. git status tells us the status of our project, and better, a list of changes in the project and options on what to do with those changes. We can use it as often as we want, whenever we want to understand what is going on.

```
$ git status

On branch main

No commits yet

nothing to commit (create/copy files and use "git add" to track)
```
If you are using a different version of git, the exact wording of the output might be slightly different.

#### Creating a New File

* Let’s create the file `README.md` with the content:

```bash
# My Random Emoji Generator
```

* Check the repository status:

```bash
$ git status

On branch master

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	README.md

nothing added to commit but untracked files present (use "git add" to track)
```

* Adding the file to tracking:
```bash
$ git add README.md
$ git status

On branch master
Your branch is up-to-date with 'origin/master'.
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
  
    new file:   README.md
```

* Edit the file `CONTRIBUTING.md`:
```bash
$ git status

On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
	new file:   README.md

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	CONTRIBUTING.md
```

* Adding the file `CONTRIBUTING.md`:
```bash
$ git add CONTRIBUTING.md
$ git status

On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
	new file:   CONTRIBUTING.md
	new file:   README.md
```

* Edit the file `CONTRIBUTING.md` again:
```bash
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
	new file:   CONTRIBUTING.md
	new file:   README.md

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   CONTRIBUTING.md
```

* Git stages a file exactly as it is when you run the `git add` command.

#### Ignoring Files

* You can define file patterns to ignore using the `.gitignore` file.
* Rules for the file:
  * Blank lines or lines starting with `#` are ignored.
  * Standard glob patterns are applied recursively throughout the working directory.

---

### Committing Changes

* Before committing, it’s important to review changes to ensure they make sense.
* View differences using `git diff`:
```bash
$ git diff
```

#### Removing Files

* To remove a file from Git, untrack it (remove it from the staging area) and commit the change:
```bash
$ git rm <file>
```

* To keep the file locally but stop tracking it:
```bash
$ git rm --cached <file>
```
