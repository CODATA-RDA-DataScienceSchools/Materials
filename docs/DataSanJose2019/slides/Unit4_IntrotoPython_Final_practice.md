In [ ]:

    #General practice
    #Wrap-up
    #Feedback

### Practice[¶](#Practice) {#Practice}

With the data in the file "Salaries.csv" in the folder data do the
following:

1.  Load the data
2.  Check the structure of the file
3.  Check the type of variables in the file
    -   Remember the method .info()

4.  Select the numeric variables in a separate dataframe \*Remember
    using columns
5.  Check if there are some missing values
6.  IF you have missing values, correct them
7.  Make a quick plot for one of the variables, be creative!
8.  Rescale the data using the method preprocessing.MinMaxScaler()

In [7]:

    # Load the data
    import pandas as pd
    data = pd.read_csv('/home/mcubero/dataSanJose19/data/Salaries.csv')
    #Check the structure of the file
    data.head()

Out[7]:

Unnamed: 0

rank

discipline

yrs.since.phd

yrs.service

sex

salary

0

1

Prof

B

19

18

Male

139750

1

2

Prof

B

20

16

Male

173200

2

3

AsstProf

B

4

3

Male

79750

3

4

Prof

B

45

39

Male

115000

4

5

Prof

B

40

41

Male

141500

In [6]:

    # Check the type of variables in the file
    data.info()

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 397 entries, 0 to 396
    Data columns (total 7 columns):
    Unnamed: 0       397 non-null int64
    rank             397 non-null object
    discipline       397 non-null object
    yrs.since.phd    397 non-null int64
    yrs.service      397 non-null int64
    sex              397 non-null object
    salary           397 non-null int64
    dtypes: int64(4), object(3)
    memory usage: 21.8+ KB

In [11]:

    #Select the numeric variables in a separate dataframe *Remember using columns
    num = data.iloc[:,[3,4,6]]
    num.head()

Out[11]:

yrs.since.phd

yrs.service

salary

0

19

18

139750

1

20

16

173200

2

4

3

79750

3

45

39

115000

4

40

41

141500

In [13]:

    # Check if there are some missing values
    num.isna().sum()

Out[13]:

    yrs.since.phd    0
    yrs.service      0
    salary           0
    dtype: int64

In [14]:

    #Rescale the data using the method preprocessing.MinMaxScaler()
    from sklearn import preprocessing
    #Save columns names
    names = num.columns
    #Create scaler 
    scaler = preprocessing.MinMaxScaler() #StandardScaler() #MaxAbsScaler

    #Transform your data frame (numeric variables )
    data1 = num
    data1 = scaler.fit_transform(data1) 
    data1 = pd.DataFrame(data1, columns=names) 
    print(data1.head())
    print(num.head())

       yrs.since.phd  yrs.service    salary
    0       0.327273     0.300000  0.471668
    1       0.345455     0.266667  0.664192
    2       0.054545     0.050000  0.126335
    3       0.800000     0.650000  0.329218
    4       0.709091     0.683333  0.481740
       yrs.since.phd  yrs.service  salary
    0             19           18  139750
    1             20           16  173200
    2              4            3   79750
    3             45           39  115000
    4             40           41  141500

Wrap-up[¶](#Wrap-up) {#Wrap-up}
--------------------

20 min

### Python supports a large and diverse community across academia and industry.[¶](#Python-supports-a-large-and-diverse-community-across-academia-and-industry.) {#Python-supports-a-large-and-diverse-community-across-academia-and-industry.}

[NumPy](https://numpy.org/)

-   The [Python 3 documentation](https://docs.python.org/3/) covers the
    core language and the standard library.

-   [PyCon](https://pycon.org/) is the largest annual conference for the
    Python community.

-   [SciPy](https://scipy.org/) is a rich collection of scientific
    utilities. It is also the name of a series of annual
    [conferences](https://conference.scipy.org/).

-   [Jupyter](https://jupyter.org/) is the home of Project Jupyter.

-   [Pandas](https://pandas.pydata.org/) is the home of the Pandas data
    library.

-   Stack Overflow’s [general
    Python](https://stackoverflow.com/questions/tagged/python?tab=Votes)
    section can be helpful, as well as the sections on
    [NumPy](https://stackoverflow.com/questions/tagged/numpy?tab=Votes),
    [SciPy](https://stackoverflow.com/questions/tagged/scipy?tab=Votes),
    and
    [Pandas.](https://stackoverflow.com/questions/tagged/pandas?tab=Votes)

KEY POINTS[¶](#KEY-POINTS) {#KEY-POINTS}
==========================

-   Python supports a large and diverse community across academia and
    industry.

Feedback[¶](#Feedback) {#Feedback}
======================

THANK YOU![¶](#THANK-YOU!) {#THANK-YOU!}
==========================
