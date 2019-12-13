**underlineCODATA. 2019 CODATA-RDA School of Research Data Scienceunderline**
**underlineDecember 2 – 13, 2019underline**
**underlineSan José, Costa Rica @ CeNATunderline**

**Este teclado se sincroniza a medida que escribe, para que todos los que vean esta página vean el mismo texto. Esto le permite colaborar sin problemas en los documentos.**

**Se espera que los usuarios sigan nuestro código de conducta: **\url{**http://software-carpentry.org/conduct.html**}

**Todo el contenido está disponible públicamente bajo la Licencia de Atribución Creative Commons: **\url{**https://creativecommons.org/licenses/by/4.0/**}
 
**¡NO CORTES NADA DE ESTA PÁGINA - UNA VEZ QUE SE BORRÓ, SE HA IDO! **

-> URL for the course \url{http://www.cenat.ac.cr/es/codata-rda-sanjose2019/}
Materials will be uploaded here: \url{https://codata-rda-datascienceschools.github.io/Materials/DataSanJose2019/}

Please deposit your One Page Slide (BioSketch) at 
\url{https://drive.google.com/drive/folders/13G08EiTc0e9u-IQQHaaXcGaMWEx\_uHwP?usp=sharing}

if you would like to hear further news or activities about the CODATA-RDA schools.
PLEASE GO TO:
\url{http://lists.codata.org/mailman/listinfo/datatrieste17\_lists.codata.org}

Summer School 18 Trieste
\url{https://www.youtube.com/watch?v=AK8Y\_UigQcc}

\url{https://www.rd-alliance.org/}
\url{https://www.rd-alliance.org/groups/national-groups} **# Join Research Data Alliance (RDA) regional and national groups! You have to create an account to join.**

**underlineSLACK Workspace:  underline**
datasanjos19.slack.com
What is SLACK?  Slack is a collaboration hub that can replace email to help you and your team work together seamlessly. It’s designed to support the way people naturally work together, so you can collaborate with people online as efficiently as you do face-to-face. Learn more in: \url{https://slack.com/intl/en-cr/help/articles/115004071768-what-is-slack-}

**underline   -> Use this invite link: underline**\url{https://join.slack.com/t/datasanjos19/shared\_invite/enQtODQzNTAxNTA4NjQyLTUyMzE4MWY2Y2U0NmIxM2QyZmYyYjM0NGM3N2EwOWJlM2I1OTZiY2RmZGFiNGRkMDE2ODYxZmZmMzM0MWEwMDc}

**Use #dataSanJosé19 on Instagram, Facebook, and/or Twitter. Share your experience!**


##====**SECTION 1**====
OPEN SCIENCE
Instructor: Lou Bezuidenhout
\url{https://www.insis.ox.ac.uk/people/dr-louise-bezuidenhout}

**Slides:** 
\url{https://codata-rda-datascienceschools.github.io/Materials/DataSanJose2019/slides/Unit%201\_CR\_Ethics\_Mon\_presentation\_extended.pdf}

On the timetable - **RCR **= Responsible Conduct of Research


##==== **SECTION 2** ===
THE UNIX SHELL
Instructor: Steve Diggs
\url{https://www.esipfed.org/steve-diggs}

**Slides:** 
\url{https://codata-rda-datascienceschools.github.io/Materials/DataSanJose2019/slides/Unit2\_TheRoadtoLinux2019.12.02.pdf}

**For Windows users:**
Install Git for Windows to obtain a working BASH shell: \url{https://gitforwindows.org/} (also necessary for tomorrow's Git lesson!)

**JupyterHub Terminal:  **underlinekabre.cenat.ac.cr:8000underline

**Lectures of today (2019-12-2) can be found at (to follow along the class): **
\url{underlinehttp://swcarpentry.github.io/shell-novice/underline}
In spanish: \url{https://swcarpentry.github.io/shell-novice-es/}

Please click on "setup" and download the files required for the lesson or:

$ curl \url{https://swcarpentry.github.io/shell-novice/data/data-shell.zip} > data-shell.zip

unzip data-shell.zip

On the timetable - **CLI **= Command Line Interface
**GUI** = Graphical User Interface

Ethics assignments at
\url{underlinehttps://docs.google.com/presentation/d/1\_wl9KkNbpCdXgRhpvTyJrAhR40z8bFqPLgBC7GYN1ao/edit?usp=sharingunderline}

Here's a nice UNIX command cheatsheet: \url{underlinehttp://cheatsheetworld.com/programming/unix-linux-cheat-sheet/underline}

Projects that can make your shell a lot more informative:
    \url{underlinehttps://github.com/robbyrussell/oh-my-zshunderline}
    \url{underlinehttps://github.com/sorin-ionescu/preztounderline}
    \url{underlinehttps://github.com/denysdovhan/spaceship-promptunderline}
    \url{underlinehttps://github.com/athityakumar/colorlsunderline}
    
**Command manual (list all arguments or flags for the command):**
$ man command name -e.g: man ls 

Commands for creating files: cat, echo, touch
Text editors like commands: vim, nano, vi
    
**AT THE END OF THE SECTION, PLEASE:**
1.         Write a positive thing from the class (green note) and a negative one (red note) in this form: \url{underlinehttps://forms.gle/jYyCVMHRLuFXL8Qw8underline}
2.         Evaluate the module in this form:
\url{underlinehttps://forms.gle/4DonkixGo5fKYL816underline}
3.         Answer the SHELL ethics questions in 2 post-its (1-yellow, 2-orange) and add them to the white board in the front of the class, so everybody can read your answers:
\url{underlinehttps://docs.google.com/presentation/d/1\_wl9KkNbpCdXgRhpvTyJrAhR40z8bFqPLgBC7GYN1ao/edit#slide=id.p4underline}

At the beggining of the session:
**script** scriptfile\_$$
$$ = unique ID number
when you type exit, it will automatically save it as scriptfile\_$$

##**==== SECTION 3 ====**
VERSION CONTROL WITH GIT
Instructor: Joao Rodrigues
\url{https://profiles.stanford.edu/joao-rodrigues}

**The material for the git/github lectures can be found at:** 
\url{https://swcarpentry.github.io/git-novice/}
In spanish: \url{http://swcarpentry.github.io/git-novice-es}

A nice visual guide to git:
\url{underlinehttps://marklodato.github.io/visual-git-guide/index-en.htmlunderline}
Pro Git book \url{underlinehttps://git-scm.com/book/en/v2underline}

**underlineGITHUB important commands:underline**
    
which # shell command to locate executables

**# Identification and configuration (once in one PC):**

**git config --global user.name** "Your Name"
**git config --global user.email **"youremail@mail.com"

**git config --global core.editor "nano" -w  **#setting default text editor
other editors: vim, vi 

**git config --list**   #SHOWS PRESENT CONFIG
**git config -h**  #SHOWS ALL CONFIG OPTIONS

**mkdir**  # create directory
**cd** -name of directory- # goes to directory

**git init **# intialize an empty git REPOSITORY inside the current directory
**git commit** # Git takes everything we have told it to save by using git add and stores a copy permanently inside the special .git directory
**git status **# is like an ls, showing what is inside the repository
**nano **sometextfile.txt # create mars.txt file and write on it using nano text editor
**git add**  # copy files, add file changes to staging area (starts tracking its changes with git)
**# OR use VIM editor, as you prefer!**
**git commit --m** "first commit" #COMMIT AND FINALLY SAVE CHANGE IN THE REPOSITORY, -m FOR MESSAGE
**#Your commit message is important for your future self and for others!**
**git diff **#Show changes between commits
**# FIRST,** you need to **add **changes to the staging area**, THEN** you **commit**
**# IF WE TRY TO COMMIT WITHOUT STAGING THE FILE, IT DOES NOT WORK!**
**git diff --staged** #show changes that have not been commited
**git clone** #get a copy of an existing repo (create a **clone**, or copy of the target repository.)
**git remote -v **# to get information about that repository
# You can always fork someone's public repository (i.e., copy it to your account). To make changes in the author's original repo, you would need collaborator's permission.

#Syncing a new remote *upstream* (= conventional name for the canonical repo <- from the original author) repository with the fork (it is your origin, in your account)
# use this to send all of our changes to the canonical repo
**git remote add upstream** 

**git branch** # creating another branch

**git remote rm upstream**  # in case you need to delete this repo
**git remote add upstream** # add a new one

# We already forked and cloned th repo
# Make changes in some file and commit then

# Send current branch to your origin (the remote repository in your GitHub account):
**git push --set-upstream **

# Now it should be in you GitHub online account

**IMPORTANT LINKS **
Documentation: 

   * Pro Git book: \url{https://git-scm.com/book/en/v2}
   * Git distributed version control system: \url{https://git-scm.com}
   * GitHub benefits for students and teachers: \url{https://education.github.com/benefits}
###GIT/GITHUB WITH RSTUDIO
Hello, there's a little guide on Git Github (spanish) using RStudio on this links

\url{https://github.com/dawidh15/dinPob/wiki/03-Tutorial-de-Git-y-GitHub} 

\url{https://github.com/dawidh15/dinPob/wiki/04-Gu%C3%ADa-para-hacer-un-Pull-Request}

I hope you find them useful. David M.

**AT THE END OF THE SECTION, PLEASE:**
1.             Write a positive thing from the class (green note) and a negative one (red note) in this form: \url{https://forms.gle/jYyCVMHRLuFXL8Qw8}
2.             Evaluate the module in this form:
\url{https://forms.gle/4DonkixGo5fKYL816}
3.             Answer the GIT ethics questions in 2 post-its (1-yellow, 2-orange) and add them to the white board in the front of the class, so everybody can read your answers:
\url{https://docs.google.com/presentation/d/1\_wl9KkNbpCdXgRhpvTyJrAhR40z8bFqPLgBC7GYN1ao/edit#slide=id.p4}
##
##**==== SECTION 4 ====**
INTRO TO python
Instructor: Mariana Cubero
\url{https://kabre.cenat.ac.cr/personnel/}

currently working on:
**JupyterHub Terminal:  **underlinekabre.cenat.ac.cr:8000underline

**Lectures:** 
\url{https://codata-rda-datascienceschools.github.io/Materials/DataSanJose2019/}    
\url{https://swcarpentry.github.io/python-novice-gapminder/}

**underlineGETTING HELP underline**
-name of function-? #access help documentation
e. g.: max**?**
#press shift and tab, it shows the options or arguemts available for the function (tab completition)
**help() **# built-in function to access help documentation, e. g.: help(round)
.describe() #to get summary statistics about data
.info() #to get info on the structure of the data frame
**#Conditionals **use elif (short for “else if”) and a condition to specify these, before else, after if
# ordering matters.


**# Gapminder wide data to download:**
 \url{https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/gh-pages/\_episodes\_rmd/data/gapminder\_wide.csv} (right click - save link as...)
 
** READ THE DOCS!**
** Python 3 Documentation: **\url{https://docs.python.org/3/}
 Stack Overflow Python section: \url{https://stackoverflow.com/questions/tagged/python?tab=Votes}

DATA FOR THE FINAL PRACTICE!!!!
\url{https://drive.google.com/drive/folders/1YUjbfap5ixKvvOYzPq7w9rgfUExWYe7l?usp=sharing}

zip -r nameoffile.zip directory, e.g zip -r notebooks.zip dataSanJose19

**AT THE END OF THE SECTION, PLEASE:**
1.             Write a positive thing from the class (green note) and a negative one (red note) in this form: \url{https://forms.gle/jYyCVMHRLuFXL8Qw8}
2.             Evaluate the module in this form:
\url{https://forms.gle/4DonkixGo5fKYL816}
3.             Answer the python ethics questions in 2 post-its (1-yellow, 2-orange) and add them to the white board in the front of the class, so everybody can read your answers:
\url{https://docs.google.com/presentation/d/1\_wl9KkNbpCdXgRhpvTyJrAhR40z8bFqPLgBC7GYN1ao/edit#slide=id.p4}

************************************To know more about CODATA-RDA and the RDS schools******************************* 
\url{https://codata-rda-datascienceschools.github.io/index.html}
\url{http://www.codata.org/working-groups/research-data-science-summer-schools}
\url{https://www.rd-alliance.org}
RDA Plenary 2020 in Costa Rica
\url{https://www.rd-alliance.org/plenaries/rda-16th-plenary-meeting-costa-rica}

##**==== SECTION 5 ====**
AUTHOR CARPENTRY 
Instructor: Marcela Alfaro
\url{https://malfaro.netlify.com/}

**Lectures:** \url{https://authorcarpentry.github.io}

**Slides:** \url{https://codata-rda-datascienceschools.github.io/Materials/DataSanJose2019/slides/Unit%205\_AuthorCarpentry.pdf}

**#**Promote your articles through social media (Twitter) and academia networks (Academia, ResearchGate, Github)
**#**Check the copyright and restrictions of publishers (check before sharing papers, books)
\url{http://sherpa.ac.uk/romeo/index.php?la=en\&fIDnum=%7C\&mode=simple}
**#Establish your academy identity, use a digital name identifier, ORCID ID **
** **\url{https://orcid.org}
 \url{https://support.orcid.org/hc/en-us/articles/360006971053-Your-ORCID-iD-your-digital-name-identifier}
**#Register for an ORCID ID **(it´s free!)
\url{https://orcid.org/register}
**#**You already have it? Integrate your ORCID ID with ScienceOpen
\url{https://blog.scienceopen.com/2017/06/flexible-content-management-on-scienceopen/#more-2925}

**#Links of interest**:
Rainbow of Open Science workflow: \url{https://zenodo.org/record/1147025/files/rainbow-of-open-science-practices.png}
More of social and academic networking: \url{https://osc.universityofcalifornia.edu/2015/12/a-social-networking-site-is-not-an-open-access-repository/}
List of predatory journals: \url{https://predatoryjournals.com/journals/}
Hi all, here is some more information about predatory publishing - a fun presentation by Andy Nobes from INASP. \url{https://www.youtube.com/watch?v=24--RCxEugE}

**AT THE END OF THE SECTION, PLEASE:**
1.             Write a positive thing from the class (green note) and a negative one (red note) in this form: \url{underlinehttps://forms.gle/jYyCVMHRLuFXL8Qw8underline}
2.             Evaluate the module in this form:
\url{underlinehttps://forms.gle/4DonkixGo5fKYL816underline}


##**==== SECTION 6 ====**
RESEARCH DATA MANAGEMENT
**Instructor:** S. Venkat 
\url{http://www.dcc.ac.uk/about-us/dcc-staff-directory/shanmugasundaram-venkataraman-venkat}

**#**General intro questions
\url{https://www.menti.com} CODE  29 04 30

**Slides:** \url{https://codata-rda-datascienceschools.github.io/Materials/DataSanJose2019/slides/Unit%206\_Intro\_to\_RDM\_open\_fair\_dmp\_part1.pdf}
Data Management plans (DMP) -one is good, the other bad:
\url{https://codata-rda-datascienceschools.github.io/Materials/DataSanJose2019/slides/Unit%206\_atlantos\_dmp.pdf}
\url{https://codata-rda-datascienceschools.github.io/Materials/DataSanJose2019/slides/Unit\_6\_woscap\_dmp.pdf}

**#**Tool for License selection:

   * \url{https://github.com/ufal/public-license-selector}**#**The Open Data Citation Advantage:
    \url{https://sparceurope.org/open-data-citation-advantage/}
**#**Consent for data sharing:
    \url{https://www.ukdataservice.ac.uk/manage-data/legal-ethical/consent-data-sharing/consent-forms}
**#**Recommended formats:
    \url{https://www.ukdataservice.ac.uk/manage-data/format/recommended-formats}
**#**What makes a good file name?
    \url{https://www.jisc.ac.uk/guides/managing-information/good-file-name}
**#**Metadata Standards Directory Working Group:
    \url{http://rd-alliance.github.io/metadata-directory/}
**#**Some Repositories:
    www.re3data.org
    \url{http://biosharing.org}
    www.zenodo.org
**#**Making your code citable:
   \url{https://guides.github.com/activities/citable-code/}
**#**Building a culture of data citation:
   \url{https://www.ands.org.au/working-with-data/citation-and-identifiers/data-citation}
**#**FAIR Data Principles:
    \url{https://www.go-fair.org/fair-principles/}
**#**DMPonline helps you to create, review, and share data management plans that meet institutional and funder requirements. It is provided by the Digital Curation Centre (DCC):
\url{https://dmponline.dcc.ac.uk/}
**#**DMP Guidelines and example: \url{http://www.dcc.ac.uk/resources/data-management-plans/guidance-examples}
**#**Recommended repositories: \url{https://www.nature.com/sdata/policies/repositories}
**#**Public datasets \url{https://github.com/awesomedata/awesome-public-datasets}
**#Ontology** encompasses a representation, formal naming and definition of the categories, properties and relations between the concepts, data and entities that substantiate one, many or all domains of discourse. To learn more: \url{http://www.dcc.ac.uk/resources/curation-reference-manual/completed-chapters/ontologies} 


**AT THE END OF THE SECTION, PLEASE:**
1.             Write a positive thing from the class (green note) and a negative one (red note) in this form: \url{underlinehttps://forms.gle/jYyCVMHRLuFXL8Qw8underline}
2.             Evaluate the module in this form:
\url{underlinehttps://forms.gle/4DonkixGo5fKYL816underline}
3.             Answer the RDM ethics questions in 1post-its (green) and add them to the white board in the front of the class, so everybody can read your answers:
\url{underlinehttps://docs.google.com/presentation/d/1\_wl9KkNbpCdXgRhpvTyJrAhR40z8bFqPLgBC7GYN1ao/edit#slide=id.p4underline}


##**==== SECTION 7 ====**
OPEN SCIENCE 2 
Instructor: Lou Bezuidenhout
\url{https://www.insis.ox.ac.uk/people/dr-louise-bezuidenhout}

**Slides: **
\url{https://codata-rda-datascienceschools.github.io/Materials/DataSanJose2019/slides/Unit\_7\_Ethics\_Fri\_presentation.pdf}
On the timetable - **RCR **= Responsible Conduct of Research
\url{https://www.research.nhg.com.sg/wps/wcm/connect/romp/nhgromp/06+conducting+research/rcr+core+components}

**#**FAIR Data Principles:
    \url{https://www.go-fair.org/fair-principles/}
**#**CARE Data principles
    \url{https://www.gida-global.org/care}
    \url{https://medium.com/@opendatacharter/spotlight-care-principles-f475ec2bf6ec}
**#BeFAIRandCARE**

**#**Don’t have an appropriate institutional or thematic repository? Use Zenodo!
\url{https://zenodo.org}
**#**Registry of Research Data Repos: \url{https://www.re3data.org}

**#**Rainbow of Open Science workflow: \url{https://zenodo.org/record/1147025/files/rainbow-of-open-science-practices.png}

**#**Promoting Integrity of Researches and its publications: \url{https://publicationethics.org}

**#**Algorithmic Justice League: \url{https://www.ajlunited.org}


**AT THE END OF THE SECTION, PLEASE:**
1.             Write a positive thing from the class (green note) and a negative one (red note) in this form: \url{underlinehttps://forms.gle/jYyCVMHRLuFXL8Qw8underline}
2.             Evaluate the module in this form:
\url{underlinehttps://forms.gle/4DonkixGo5fKYL816underline}
3.             Answer the Open Science ethics questions in 1post-its (green) and add them to the white board in the front of the class, so everybody can read your answers:
\url{underlinehttps://docs.google.com/presentation/d/1\_wl9KkNbpCdXgRhpvTyJrAhR40z8bFqPLgBC7GYN1ao/edit#slide=id.p4underline}

##**==== SECTION 8 ====**
RESEARCH DATA MANAGEMENT LAB
**Instructor:** Steve Diggs
\url{https://www.esipfed.org/steve-diggs}

**Slides:** coming soon

**Data for Oceanography lab:** \url{http://bit.ly/2YUOLeJ} 

Please send a link to *your* shared G-Drive presentation to:***underline sdiggs@ucsd.eduunderline***
**Make sure that your grant "view" privileges with everyone!**

**AT THE END OF THE SECTION, PLEASE:**
1.             Write a positive thing from the class (green note) and a negative one (red note) in this form: \url{underlinehttps://forms.gle/jYyCVMHRLuFXL8Qw8underline}
2.             Evaluate the module in this form:
\url{underlinehttps://forms.gle/4DonkixGo5fKYL816underline}


##**==== SECTION 9 ====**
DATA VISUALIZATION
**Instructor:** Hugh Shanahan
\url{https://pure.royalholloway.ac.uk/portal/en/persons/hugh-shanahan%2877128df7-1747-4d9f-8fe5-c11d30e77abc%29.html}

**Working materials: **
\url{https://github.com/CODATA-RDA-DataScienceSchools/Materials/tree/master/docs/DataSanJose2019/slides/Visualisation} 

   * 
\url{https://github.com/CODATA-RDA-DataScienceSchools/Materials/blob/master/docs/DataSanJose2019/slides/Visualisation/Visualisation%20using%20Seaborn.md}

You can work on:
Local JupyterHub: \url{http://kabre.cenat.ac.cr:8000/hub/login}
or
\url{https://colab.research.google.com/notebooks/welcome.ipynb}

Data "gapminder" URL: \url{https://bit.ly/2PbVBcR}

**#Mark **is the basic graphical element / geometric primitive. Marks can be classified according the spatial dimensions they requires. The figure below shows three kinds of dimensions: a zero-dimensional (0D) mark is a point, a one-dimensional (1D) mark is a line, and a two-dimensional (2D) mark is an area.

**#**A **visual channel **is a way to control the appearance of marks, independent of the dimensionality of the geometric primitive.  There are many different visual channels, such as position, color, shape, hue and size, etc..

**#Expressiveness principle**: visual encoding should express all of, and only, the information in the dataset attributes.

**#Effectiveness principle: **the most important attributes should be encoded with the most noticeable channels.

**#Steven´s Psycophysical Power Law:** \url{https://tinyurl.com/uxe6xt7}

**#**In order to satisfy **discriminability,** the characterization of visual channel thus should quantify the number of bins that are available for use within a visual channel, where each bin is a distinguishable step or level from the other. The key factor is matching the ranges: the number of different values that need to be shown for the attribute being encoded must not be greater than the number of bins available for the visual channel used to encode it.

**#Separability: **the amount of interference between any pair of channels.

**To learn more about Marks and visual channels:**
    \url{https://jenniewblog.wordpress.com/2016/03/08/marks-and-channels-chapter5/}
    \url{http://vda.univie.ac.at/Teaching/Vis/14s/LectureNotes/05\_marks\_and\_channels.pdf}
    \url{https://medium.com/multiple-views-visualization-research-explained/how-we-see-our-data-vision-science-and-visualization-pt-1-2b36f2330e42}

   * 
RECOMMENDED BOOK: **Visualization, Analysis and Design**
     \url{https://www.oreilly.com/library/view/visualization-analysis-and/9781466508910/}

**More resources:**
Difference between Matplotlib, Pyplot, Pylab: \url{http://queirozf.com/entries/matplotlib-pylab-pyplot-etc-what-s-the-different-between-these}
Not sure what type of plot to use? \url{https://www.data-to-viz.com}

**Multiple choice exercises:**
\url{https://Menti.com}
CODE 82 66 18 

**#**We may want to order the box plots in ascending order of the medians of the life expectancy:
    
medianLifeExps = {} 
for val in gapminder.continent:  
    key = gapminder[gapminder.continent==val].lifeExp.median() medianLifeExps[key] = val 
    sortedKeys = sorted(medianLifeExps) 
    for m in sortedKeys:
        orderedMedianContinents.append(medianLifeExps[m])


**AT THE END OF THE SECTION, PLEASE:**
1.             Write a positive thing from the class (green note) and a negative one (red note) in this form: \url{underlinehttps://forms.gle/jYyCVMHRLuFXL8Qw8underline}
2.             Evaluate the module in this form:
\url{underlinehttps://forms.gle/4DonkixGo5fKYL816underline}
3.             Answer the Data Visualization ethics questions in post-its (yellow) and add them to the white board in the front of the class, so everybody can read your answers:
\url{underlinehttps://docs.google.com/presentation/d/1\_wl9KkNbpCdXgRhpvTyJrAhR40z8bFqPLgBC7GYN1ao/edit#slide=id.p4underline}


##**==== SECTION 10 ====**
MACHINE LEARNING
**Instructor:** José Pablo González-Brenes
\url{https://josepablogonzalez.com}

**underlineTypes of MLunderline**
**underlineSupervised learning:underline** data shows how the input looks like,** also we know the output. Clasic classification problem when we already know the possible categories**
**underlineUnsupervised learning:underline** No teacher, just input data, separates data into clusters
**underlineReasoning under uncertainty: underline**you make decisions as you go! Like a robot moving around an unknown room. 
Very good for simple examples, more research needs to be done for more complex cases.
**underlineActive learning:underline** specify which data to give to the teacher. 

**Working material:** \url{https://bit.ly/36lrlmP}

Local JupyterHub: \url{http://kabre.cenat.ac.cr:8000/hub/login}

**Reading material:**
Understanding the structure of neural networks:\url{https://becominghuman.ai/understanding-the-structure-of-neural-networks-1fa5bd17fef0}
This is a cool visualization of how a convolutional network works \url{http://scs.ryerson.ca/~aharley/vis/conv/flat.html}
The XOR Problem: in Neural Networks \url{https://medium.com/@jayeshbahire/the-xor-problem-in-neural-networks-50006411840b}


**AT THE END OF THE SECTION, PLEASE:**
1.             Write a positive thing from the class (green note) and a negative one (red note) in this form: \url{underlinehttps://forms.gle/jYyCVMHRLuFXL8Qw8underline}
2.             Evaluate the module in this form:
\url{underlinehttps://forms.gle/4DonkixGo5fKYL816underline}
3.             Answer the Data Visualization ethics questions in post-its (yellow) and add them to the white board in the front of the class, so everybody can read your answers:
\url{underlinehttps://docs.google.com/presentation/d/1\_wl9KkNbpCdXgRhpvTyJrAhR40z8bFqPLgBC7GYN1ao/edit#slide=id.p4underline}



##**==== SECTION 11 ====**
ARTIFICIAL NEURAL NETWORKS
**Instructor: **Raphael Cobe
@raphaelcobe

Link to the slides: \url{https://raphaelmcobe.github.io/dataSanJose2019\_nn\_presentation}

Shorter link: \url{http://tiny.cc/dataSanJose-nn}

How to download the slide:
1) git clone \url{https://github.com/raphaelmcobe/dataSanJose2019\_nn\_presentation.git}
2) cd dataSanJose2019\_nn\_presentation/
3) git checkout gh-pages
4) open the index.html file

**AT THE END OF THE SECTION, PLEASE:**
1.             Write a positive thing from the class (green note) and a negative one (red note) in this form: \url{underlinehttps://forms.gle/jYyCVMHRLuFXL8Qw8underline}
2.             Evaluate the module in this form:
\url{underlinehttps://forms.gle/4DonkixGo5fKYL816underline}
3.             Answer the Artificial Neural Networks ethics questions (slide 16) on post-its and add them to the white board in the front of the class, so everybody can read your answers:
\url{underlinehttps://docs.google.com/presentation/d/1\_wl9KkNbpCdXgRhpvTyJrAhR40z8bFqPLgBC7GYN1ao/edit#slide=id.p4underline}



##**==== SECTION 12 ====**
INTRO TO SECURITY AND COMPUTATIONAL INFRASTRUCTURES 
**Instructor: Rob Quick**
\url{http://www.osgconnect.net/}
@robquick5

Follow instructions for the OSG section : \url{http://tiny.cc//osg-sanjose}

All Security and Cyber-infrastructures Slides and Exercises are available in: \url{https://github.com/CODATA-RDA-DataScienceSchools/Materials/blob/master/docs/DataSanJose2019/CI/Materials.md} 


**AT THE END OF THE SECTION, PLEASE:**
1.             Write a positive thing from the class (green note) and a negative one (red note) in this form: \url{underlinehttps://forms.gle/jYyCVMHRLuFXL8Qw8underline}
2.             Evaluate the module in this form:
\url{underlinehttps://forms.gle/4DonkixGo5fKYL816underline}
3.             Answer the CI ethics questions (slide 17-18) on post-its and add them to the glass walls in the class, so everybody can read your answers:
\url{underlinehttps://docs.google.com/presentation/d/1\_wl9KkNbpCdXgRhpvTyJrAhR40z8bFqPLgBC7GYN1ao/edit#slide=id.p4underline}


##**REMINDERS**

1. Which platform do you prefer for keeping in contact? poll: 
    \url{https://www.menti.com}
    CODE 78 09 01 
    
The winner was WhatsApp group with 11 votes but E-mail list was very close with 10 votes, so we are doing both.
**The Contact list (E-mail list) is here: **\url{https://docs.google.com/spreadsheets/d/1SRlkNs8YETEqMjFrcgLBKRg7fztg29K5E7m3kiyOrMM/edit?usp=sharing}

Invitation link for WhatsApp group:
\url{https://chat.whatsapp.com/F4WYuWGFoeuEDSXCP1A0rU}

2. Remember to wear your name tag at all times.

3. We are in the process of developing a vocabulary list of key terms that we are using in the course of the schools. It is still a work in progress, but might be of use to students as is. It can be viewed here: \url{https://docs.google.com/document/d/1kZj9D9-pKWCvOx9NXteqQw9f0TV6c\_ciSKnRbiNWRlU/edit?usp=sharing} 

4. Group photos!: \url{https://slack-files.com/TR68C4RAL-FR0SVHJRY-09daa3b83b}
\url{https://slack-files.com/TR68C4RAL-FRFGB7ATZ-068e4be05c}

**5. More group photos!:** \url{https://drive.google.com/drive/folders/1pRz7PtX8iFKSFzGgqZV46TKjrDNsSAn8?usp=sharing}

6. All the class materials are here: \url{https://codata-rda-datascienceschools.github.io/Materials/DataSanJose2019/}
(we are still working on uploading Steve and José Pablo's materials).

7. This pad will be saved in a HTML and Markdown format, which will be available in the school´s Github repo

******************************
Here some links to more courses that might be helpful for you in the future (if you know other good ones please feel free to share):
Spatial data: \url{http://rspatial.org/index.html}
R4DS en español: \url{https://es.r4ds.hadley.nz/}
Speciality based courses (ecology, genomics, social sciences, and geospatial, biology): \url{https://datacarpentry.org/lessons/#biology-semester-long-course}
IDLE in case you're not comfortable with RStudio, Spyder, the Terminal, etc: \url{https://atom.io/}
R, Python, Git, Statistics, time series, machine learning, visualization, etc. tutorials at: \url{https://ourcodingclub.github.io/tutorials/}
Word analysis (you just might need that someday): \url{https://uc-r.github.io/word\_relationships}
A good compilation of data science and ML materials: \url{https://www.claoudml.com}
Data Carpentry for Biologists: \url{http://datacarpentry.org/semester-biology/} 
******************************




