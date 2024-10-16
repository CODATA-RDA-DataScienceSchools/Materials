Pandas Dataframes/Series[¶](#Pandas-Dataframes/Series) {#Pandas-Dataframes/Series}
------------------------------------------------------

20 min

Exercies (10 min)

A DataFrame is a collection of Series; The DataFrame is the way Pandas
represents a table, and Series is the data-structure Pandas use to
represent a column.

Pandas is built on top of the Numpy library, which in practice means
that most of the methods defined for Numpy Arrays apply to Pandas
Series/DataFrames.

What makes Pandas so attractive is the powerful interface to access
individual records of the table, proper handling of missing values, and
relational-databases operations between DataFrames.

### Selecting values (iloc[...,...])[¶](#Selecting-values-(iloc[...,...])) {#Selecting-values-(iloc[...,...])}

To access a value at the position [i,j] of a DataFrame, we have two
options, depending on what is the meaning of i in use. Remember that a
DataFrame provides a index as a way to identify the rows of the table; a
row, then, has a position inside the table as well as a label, which
uniquely identifies its entry in the DataFrame.

`dataframe.iloc` can specify by numerical index analogously to 2D
version of character selection in strings.

dataframe.iloc[rows, columns]

In [4]:

    import pandas as pd
    data = pd.read_csv('/home/mcubero/dataSanJose19/data/gapminder_gdp_europe.csv', index_col='country')
    #data
    print(data.iloc[0:3, 0])

    #With labels 
    #print(data.loc["Albania", "gdpPercap_1952"])

    #All columns (just like usual slicing)

    #print(data.loc["Albania", :])

    country
    Albania    1601.056136
    Austria    6137.076492
    Belgium    8343.105127
    Name: gdpPercap_1952, dtype: float64

Use DataFrame.loc[..., ...] to select values by their (entry) label.

-   Can specify location by row name analogously to 2D version of
    dictionary keys.

In [72]:

    data = pd.read_csv('/home/mcubero/dataSanJose19/data/gapminder_gdp_europe.csv', index_col='country')
    print(data.loc["Albania", "gdpPercap_1952"])

    1601.056136

Use : on its own to mean all columns or all rows.

-   Just like Python’s usual slicing notation.

In [9]:

    print(data.loc["Italy",:])

    gdpPercap_1952     4931.404155
    gdpPercap_1957     6248.656232
    gdpPercap_1962     8243.582340
    gdpPercap_1967    10022.401310
    gdpPercap_1972    12269.273780
    gdpPercap_1977    14255.984750
    gdpPercap_1982    16537.483500
    gdpPercap_1987    19207.234820
    gdpPercap_1992    22013.644860
    gdpPercap_1997    24675.024460
    gdpPercap_2002    27968.098170
    gdpPercap_2007    28569.719700
    Name: Italy, dtype: float64

In [ ]:

    print(data.loc["Albania", :])

Select multiple columns or rows using DataFrame.loc and a named slice.

In [5]:

    print(data.loc['Italy':'Poland', 'gdpPercap_1962':'gdpPercap_1972'])

                 gdpPercap_1962  gdpPercap_1967  gdpPercap_1972
    country                                                    
    Italy           8243.582340    10022.401310    12269.273780
    Montenegro      4649.593785     5907.850937     7778.414017
    Netherlands    12790.849560    15363.251360    18794.745670
    Norway         13450.401510    16361.876470    18965.055510
    Poland          5338.752143     6557.152776     8006.506993

In the above code, we discover that **slicing using** `loc` **is
inclusive at both ends**, which differs from **slicing using** `iloc`,
where slicing indicates everything up to but not including the final
index.

#### Result of slicing can be used in further operations.[¶](#Result-of-slicing-can-be-used-in-further-operations.) {#Result-of-slicing-can-be-used-in-further-operations.}

-   Usually don’t just print a slice.
-   All the statistical operators that work on entire dataframes work
    the same way on slices.
-   E.g., calculate max of a slice.

In [10]:

    print(data.loc['Italy':'Poland', 'gdpPercap_1962':'gdpPercap_1972'].max())

    gdpPercap_1962    13450.40151
    gdpPercap_1967    16361.87647
    gdpPercap_1972    18965.05551
    dtype: float64

In [11]:

    # Calculate minimum of slice 

    print(data.loc['Italy':'Poland', 'gdpPercap_1962':'gdpPercap_1972'].min())

    gdpPercap_1962    4649.593785
    gdpPercap_1967    5907.850937
    gdpPercap_1972    7778.414017
    dtype: float64

Use comparisons to select data based on value.

-   Comparison is applied element by element.

-   Returns a similarly-shaped dataframe of True and False.

In [15]:

    subset = data.loc['Italy':'Poland', 'gdpPercap_1962':'gdpPercap_1972']
    #print('Subset of data:\n', subset)

    # Which values were greater than 10000 ?
    print('\nWhere are values large?\n', subset > 10000)

    #Select values or NaN using a Boolean mask.
    mask = subset > 10000
    print(subset[mask])

    Where are values large?
                  gdpPercap_1962  gdpPercap_1967  gdpPercap_1972
    country                                                    
    Italy                 False            True            True
    Montenegro            False           False           False
    Netherlands            True            True            True
    Norway                 True            True            True
    Poland                False           False           False
                 gdpPercap_1962  gdpPercap_1967  gdpPercap_1972
    country                                                    
    Italy                   NaN     10022.40131     12269.27378
    Montenegro              NaN             NaN             NaN
    Netherlands     12790.84956     15363.25136     18794.74567
    Norway          13450.40151     16361.87647     18965.05551
    Poland                  NaN             NaN             NaN

Get the value where the mask is true, and NaN (Not a Number) where it is
false. Useful because NaNs are ignored by operations like max, min,
average, etc.

-   A frame full of Booleans is sometimes called a mask because of how
    it can be used.

In [9]:

    mask = subset > 10000
    print(subset[mask])

                 gdpPercap_1962  gdpPercap_1967  gdpPercap_1972
    country                                                    
    Italy                   NaN     10022.40131     12269.27378
    Montenegro              NaN             NaN             NaN
    Netherlands     12790.84956     15363.25136     18794.74567
    Norway          13450.40151     16361.87647     18965.05551
    Poland                  NaN             NaN             NaN

-   Get the value where the mask is true, and NaN (Not a Number) where
    it is false.
-   Useful because NaNs are ignored by operations like max, min,
    average, etc.

### Group By: split-apply-combine[¶](#Group-By:-split-apply-combine) {#Group-By:-split-apply-combine}

Pandas vectorizing methods and grouping operations are features that
provide users much flexibility to analyse their data.

1.  We may have a glance by splitting the countries in two groups during
    the years surveyed, those who presented a GDP higher than the
    European average and those with a lower GDP.
2.  We then estimate a wealthy score based on the historical (from 1962
    to 2007) values, where we account how many times a country has
    participated in the groups of lower or higher GDP

In [21]:

    mask_higher = data > data.mean()

    wealth_score = mask_higher.aggregate('sum', axis=1) / len(data.columns)
    wealth_score

Out[21]:

    country
    Albania                   0.000000
    Austria                   1.000000
    Belgium                   1.000000
    Bosnia and Herzegovina    0.000000
    Bulgaria                  0.000000
    Croatia                   0.000000
    Czech Republic            0.500000
    Denmark                   1.000000
    Finland                   1.000000
    France                    1.000000
    Germany                   1.000000
    Greece                    0.333333
    Hungary                   0.000000
    Iceland                   1.000000
    Ireland                   0.333333
    Italy                     0.500000
    Montenegro                0.000000
    Netherlands               1.000000
    Norway                    1.000000
    Poland                    0.000000
    Portugal                  0.000000
    Romania                   0.000000
    Serbia                    0.000000
    Slovak Republic           0.000000
    Slovenia                  0.333333
    Spain                     0.333333
    Sweden                    1.000000
    Switzerland               1.000000
    Turkey                    0.000000
    United Kingdom            1.000000
    dtype: float64

**Note**: axis : (default 0) {0 or ‘index’, 1 or ‘columns’} 0 or
‘index’: apply function to each column. 1 or ‘columns’: apply function
to each row.

Finally, for each group in the wealth\_score table, we sum their
(financial) contribution across the years surveyed:

In [22]:

    data.groupby(wealth_score).sum()

Out[22]:

gdpPercap\_1952

gdpPercap\_1957

gdpPercap\_1962

gdpPercap\_1967

gdpPercap\_1972

gdpPercap\_1977

gdpPercap\_1982

gdpPercap\_1987

gdpPercap\_1992

gdpPercap\_1997

gdpPercap\_2002

gdpPercap\_2007

0.000000

36916.854200

46110.918793

56850.065437

71324.848786

88569.346898

104459.358438

113553.768507

119649.599409

92380.047256

103772.937598

118590.929863

149577.357928

0.333333

16790.046878

20942.456800

25744.935321

33567.667670

45277.839976

53860.456750

59679.634020

64436.912960

67918.093220

80876.051580

102086.795210

122803.729520

0.500000

11807.544405

14505.000150

18380.449470

21421.846200

25377.727380

29056.145370

31914.712050

35517.678220

36310.666080

40723.538700

45564.308390

51403.028210

1.000000

104317.277560

127332.008735

149989.154201

178000.350040

215162.343140

241143.412730

263388.781960

296825.131210

315238.235970

346930.926170

385109.939210

427850.333420

### Exercises[¶](#Exercises) {#Exercises}

1.  Assume Pandas has been imported into your notebook and the Gapminder
    GDP data for Europe has been loaded:

<!-- -->

    import pandas as pd

    df = pd.read_csv('data/gapminder_gdp_europe.csv', index_col='country')

Write an expression to find the Per Capita GDP of Serbia in 2007.

In [26]:

    df = pd.read_csv('/home/mcubero/dataSanJose19/data/gapminder_gdp_europe.csv', index_col='country')
    print(df.loc['Serbia','gdpPercap_2007'])

    9786.534714

In [27]:

    df.loc["Serbia"][-1]

Out[27]:

    9786.534714

1.  Explain in simple terms what idxmin and idxmax do in the short
    program below. When would you use these methods?

<!-- -->

    data = pd.read_csv('data/gapminder_gdp_europe.csv', index_col='country')
    print(data.idxmin())
    print(data.idxmax())

In [28]:

    print(data.idxmin())

    gdpPercap_1952    Bosnia and Herzegovina
    gdpPercap_1957    Bosnia and Herzegovina
    gdpPercap_1962    Bosnia and Herzegovina
    gdpPercap_1967    Bosnia and Herzegovina
    gdpPercap_1972    Bosnia and Herzegovina
    gdpPercap_1977    Bosnia and Herzegovina
    gdpPercap_1982                   Albania
    gdpPercap_1987                   Albania
    gdpPercap_1992                   Albania
    gdpPercap_1997                   Albania
    gdpPercap_2002                   Albania
    gdpPercap_2007                   Albania
    dtype: object

### Key Points[¶](#Key-Points) {#Key-Points}

-   Use DataFrame.iloc[..., ...] to select values by integer location.

-   Use : on its own to mean all columns or all rows.

-   Select multiple columns or rows using DataFrame.loc and a named
    slice.

-   Result of slicing can be used in further operations.

-   Use comparisons to select data based on value.

-   Select values or NaN using a Boolean mask.

### Data prep with Pandas[¶](#Data-prep-with-Pandas) {#Data-prep-with-Pandas}

20 min

In [29]:

    import numpy as np
    import pandas as pd
    from numpy.random import randn
    np.random.seed(101)

In [3]:

    df = pd.DataFrame(randn(5,4),index='A B C D E'.split(),columns='W X Y Z'.split()) 
    df

Out[3]:

W

X

Y

Z

A

2.706850

0.628133

0.907969

0.503826

B

0.651118

-0.319318

-0.848077

0.605965

C

-2.018168

0.740122

0.528813

-0.589001

D

0.188695

-0.758872

-0.933237

0.955057

E

0.190794

1.978757

2.605967

0.683509

-   Create new columns

In [41]:

    df['K', :] = df[1,:] + df[1,:] 
    df
    df.iloc[6,:] = df.iloc[1,:] + df.iloc[1,:] 

Out[41]:

gdpPercap\_1952

gdpPercap\_1957

gdpPercap\_1962

gdpPercap\_1967

gdpPercap\_1972

gdpPercap\_1977

gdpPercap\_1982

gdpPercap\_1987

gdpPercap\_1992

gdpPercap\_1997

gdpPercap\_2002

gdpPercap\_2007

6

country

Sweden

8527.844662

9911.878226

12329.441920

15258.296970

17832.02464

18855.725210

20667.381250

23586.929270

23880.016830

25266.594990

29341.630930

33859.748350

NaN

Switzerland

14734.232750

17909.489730

20431.092700

22966.144320

27195.11304

26982.290520

28397.715120

30281.704590

31871.530300

32135.323010

34480.957710

37506.419070

NaN

Turkey

1969.100980

2218.754257

2322.869908

2826.356387

3450.69638

4269.122326

4241.356344

5089.043686

5678.348271

6601.429915

6508.085718

8458.276384

NaN

United Kingdom

9979.508487

11283.177950

12477.177070

14142.850890

15895.11641

17428.748460

18232.424520

21664.787670

22705.092540

26074.531360

29478.999190

33203.261280

NaN

6

12274.152984

17685.196060

21501.442220

25669.204800

33323.25120

39498.844600

43194.167240

47375.652140

54084.037360

58191.841320

64835.215380

72252.985400

NaN

-   Reorder columns in a data frame

In [5]:

    df = df[['newColumn', 'W', 'X', 'Y', 'Z']]
    df

Out[5]:

newColumn

W

X

Y

Z

A

1.131958

2.706850

0.628133

0.907969

0.503826

B

0.286647

0.651118

-0.319318

-0.848077

0.605965

C

0.151122

-2.018168

0.740122

0.528813

-0.589001

D

0.196184

0.188695

-0.758872

-0.933237

0.955057

E

2.662266

0.190794

1.978757

2.605967

0.683509

### Group by[¶](#Group-by) {#Group-by}

The method group-by allow you to group rows in a data frame and apply a
function to it.

In [65]:

    #Let's create a DF
    data = {'Company':['GOOG','GOOG','MSFT','MSFT','FB','FB'],
           'Person':['Sam','Charlie','Amy','Vanessa','Carl','Sarah'],
           'Sales':[200,120,340,124,243,350]}
    df = pd.DataFrame(data)
    print(df)

    #Group by company

    by_comp = df.groupby("Company")
    #by_comp

    # Try some functions
    by_comp.mean()
    by_comp.count()
    by_comp.describe()
    by_comp.describe().transpose()

      Company   Person  Sales
    0    GOOG      Sam    200
    1    GOOG  Charlie    120
    2    MSFT      Amy    340
    3    MSFT  Vanessa    124
    4      FB     Carl    243
    5      FB    Sarah    350

Out[65]:

Company

FB

GOOG

MSFT

Sales

count

2.000000

2.000000

2.000000

mean

296.500000

160.000000

232.000000

std

75.660426

56.568542

152.735065

min

243.000000

120.000000

124.000000

25%

269.750000

140.000000

178.000000

50%

296.500000

160.000000

232.000000

75%

323.250000

180.000000

286.000000

max

350.000000

200.000000

340.000000

We can also merge data from different dataframes.

It's very useful when we need a variable from a different file.

You can use a ‘left’, ‘right’, ‘outer’, ‘inner’

![Types](https://drive.google.com/uc?id=1KbDQt3qLgHazKvyz1mXngRgqCmXK8aMx)

[Taken
from](https://www.datasciencemadesimple.com/join-merge-data-frames-pandas-python/)

In [56]:

    left = pd.DataFrame({'key': ['K0', 'K1', 'K2', 'K3'],
                         'A': ['A0', 'A1', 'A2', 'A3'],
                         'B': ['B0', 'B1', 'B2', 'B3'],
                         'C': ['C0', 'C1', 'C2', 'C3']})
       
    right = pd.DataFrame({'key': ['K0', 'K1', 'K2', 'K3'],
                              'C': ['C0', 'C1', 'C2', 'C3'],
                              'D': ['D0', 'D1', 'D2', 'D3']})
    print(left)
    print(right)
    ## Merge
    pd.merge(left, right, how='outer', on=['key'])

        A   B   C key
    0  A0  B0  C0  K0
    1  A1  B1  C1  K1
    2  A2  B2  C2  K2
    3  A3  B3  C3  K3
        C   D key
    0  C0  D0  K0
    1  C1  D1  K1
    2  C2  D2  K2
    3  C3  D3  K3

Out[56]:

A

B

C\_x

key

C\_y

D

0

A0

B0

C0

K0

C0

D0

1

A1

B1

C1

K1

C1

D1

2

A2

B2

C2

K2

C2

D2

3

A3

B3

C3

K3

C3

D3

#### Join (union)[¶](#Join-(union)) {#Join-(union)}

In [58]:

    left = pd.DataFrame({'A': ['A0', 'A1', 'A2'],
                         'B': ['B0', 'B1', 'B2']},
                          index=['K0', 'K1', 'K2']) 

    right = pd.DataFrame({'C': ['C0', 'C2', 'C3'],
                          'D': ['D0', 'D2', 'D3']},
                          index=['K0', 'K2', 'K3'])

In [59]:

     left.join(right)

Out[59]:

A

B

C

D

K0

A0

B0

C0

D0

K1

A1

B1

NaN

NaN

K2

A2

B2

C2

D2

In [60]:

    right.join(left)

Out[60]:

C

D

A

B

K0

C0

D0

A0

B0

K2

C2

D2

A2

B2

K3

C3

D3

NaN

NaN

In [61]:

    left.join(right, how='outer')

Out[61]:

A

B

C

D

K0

A0

B0

C0

D0

K1

A1

B1

NaN

NaN

K2

A2

B2

C2

D2

K3

NaN

NaN

C3

D3

Some additional operations you can use with a pandas data frame

-   unique: returns unique values in a series.
-   nunique: returns the number of distinct observations over requested
    axis.
-   value\_counts: returns an object containing counts of unique values
    in sorted order.

In [62]:

    df['Company'].unique()

Out[62]:

    array(['GOOG', 'MSFT', 'FB'], dtype=object)

In [63]:

    df['Company'].nunique()

Out[63]:

    3

In [20]:

    df['Company'].value_counts()

Out[20]:

    FB      2
    GOOG    2
    MSFT    2
    Name: Company, dtype: int64

There are some other very useful tricks you can do with pandas data
frames. Such as profiling a dataframe. Profiling `df.profile_report()`
is a simple and easy way to go furhter into knowing your data. [Some
other tips and
tricks](https://towardsdatascience.com/10-simple-hacks-to-speed-up-your-data-analysis-in-python-ec18c6396e6b)

In [0]:

    #Install
    #pip install pandas-profiling

In [0]:

    uploaded = files.upload()

In [0]:

    import pandas as pd
    import pandas_profiling
    import io

    data = pd.read_csv(io.BytesIO(uploaded['gapminder_

In [0]:

    print(data.iloc[:,1:3])

**Note:** There are many other method we can use to explore the data and
more effective exploration of a data set with pandas profiling.

[Check this
out!](https://towardsdatascience.com/10-simple-hacks-to-speed-up-your-data-analysis-in-python-ec18c6396e6b)

In [0]:

    pandas_profiling.ProfileReport(data.iloc[:,0:6])

### Some other useful tools to work with data frames[¶](#Some-other-useful-tools-to-work-with-data-frames) {#Some-other-useful-tools-to-work-with-data-frames}

When you are working with large data frames you might want to know if
there are missing values and how many are there.

-   .isna() will create a table with booleans.
    -   True if a value is NaN

In [67]:

    df.isna().head()

Out[67]:

Company

Person

Sales

0

False

False

False

1

False

False

False

2

False

False

False

3

False

False

False

4

False

False

False

You can count how many Nan values you have per variable

In [68]:

    df.isna().sum()

Out[68]:

    Company    0
    Person     0
    Sales      0
    dtype: int64

In [69]:

    df1 = df.copy()

You can discard these values

In [71]:

    df.dropna(axis=0) #for rows
    df.dropna(axis= 1) #for columns

Out[71]:

Company

Person

Sales

0

GOOG

Sam

200

1

GOOG

Charlie

120

2

MSFT

Amy

340

3

MSFT

Vanessa

124

4

FB

Carl

243

5

FB

Sarah

350

Standardize and resize data directly in the dataframe[¶](#Standardize-and-resize-data-directly-in-the-dataframe) {#Standardize-and-resize-data-directly-in-the-dataframe}
----------------------------------------------------------------------------------------------------------------

Here we can do it manually (if like to do things like that) but we can
also use methods already created.

For example ScikitLearn provides:

-   Simple and efficient tools for **data mining** and data analysis
-   Accessible to everybody, and reusable in various contexts
-   Built on NumPy, SciPy, and matplotlib

The
[sklearn.preprocessing](https://scikit-learn.org/stable/modules/preprocessing.html)
package provides several common utility functions and transformer
classes to change raw feature vectors into a representation that is more
suitable for the downstream estimators.

In general, learning algorithms benefit from standardization of the data
set. If some outliers are present in the set, robust scalers or
transformers are more appropriate.

In [73]:

    from sklearn import preprocessing
    #Save columns names
    names = data.iloc[:,2:8].columns
    #Create scaler 
    scaler = preprocessing.MinMaxScaler() #StandardScaler() #MaxAbsScaler

    #Transform your data frame (numeric variables )
    data1 = data.iloc[:,2:8]
    data1 = scaler.fit_transform(data1) 
    data1 = pd.DataFrame(data1, columns=names) 
    print(data1.head())
    print(data.iloc[:,2:8].head())

       gdpPercap_1962  gdpPercap_1967  gdpPercap_1972  gdpPercap_1977  \
    0        0.032220        0.028270        0.018626        0.000193   
    1        0.482925        0.512761        0.567146        0.691612   
    2        0.495771        0.527883        0.567578        0.664689   
    3        0.000000        0.000000        0.000000        0.000000   
    4        0.135922        0.163734        0.153579        0.174119   

       gdpPercap_1982  gdpPercap_1987  
    0        0.000000        0.000000  
    1        0.725414        0.717533  
    2        0.700492        0.675728  
    3        0.020016        0.020688  
    4        0.185462        0.161892  
                            gdpPercap_1962  gdpPercap_1967  gdpPercap_1972  \
    country                                                                  
    Albania                    2312.888958     2760.196931     3313.422188   
    Austria                   10750.721110    12834.602400    16661.625600   
    Belgium                   10991.206760    13149.041190    16672.143560   
    Bosnia and Herzegovina     1709.683679     2172.352423     2860.169750   
    Bulgaria                   4254.337839     5577.002800     6597.494398   

                            gdpPercap_1977  gdpPercap_1982  gdpPercap_1987  
    country                                                                 
    Albania                    3533.003910     3630.880722     3738.932735  
    Austria                   19749.422300    21597.083620    23687.826070  
    Belgium                   19117.974480    20979.845890    22525.563080  
    Bosnia and Herzegovina     3528.481305     4126.613157     4314.114757  
    Bulgaria                   7612.240438     8224.191647     8239.854824  

### Exercise[¶](#Exercise) {#Exercise}

With the file `gapminder_all.csv` try to:

1.  Filter only those countries located in Latin America.
2.  Select the columns corresponding to the gdpPercap and the population
3.  Explore the data frame using 3 different methods 4
4.  Show how many contries had a gdpPercap higher than the mean in 1977.
5.  Check if there are some missing values (NaN) in the data

Lists[¶](#Lists) {#Lists}
================

15 min

Exercises (10 min)

A list stores many values in a single structure.

-   Doing calculations with a hundred variables called pressure\_001,
    pressure\_002, etc., would be at least as slow as doing them by
    hand.

-   Use a list to store many values together.

    -   Contained within square brackets [...].
    -   Values separated by commas ,. Use len to find out how many
        values are in a list.

In [74]:

    pressures = [0.273, 0.275, 0.277, 0.275, 0.276]
    print('pressures:', pressures)
    print('length:', len(pressures))

    pressures: [0.273, 0.275, 0.277, 0.275, 0.276]
    length: 5

Use an item’s index to fetch it from a list.

In [22]:

    print('zeroth item of pressures:', pressures[0])

    zeroth item of pressures: 0.273

Lists’ values can be replaced by assigning to them.

In [23]:

    pressures[0] = 0.265
    print('pressures is now:', pressures)

    pressures is now: [0.265, 0.275, 0.277, 0.275, 0.276]

Use list\_name.append to add items to the end of a list.

In [75]:

    primes = [2, 3, 5]
    print('primes is initially:', primes)
    primes.append(7)
    #primes.append(9)
    #print('primes has become:', primes)

    primes is initially: [2, 3, 5]

Use del to remove items from a list entirely.

In [76]:

    primes = [2, 3, 5, 7, 9]
    print('primes before removing last item:', primes)
    del primes[4]
    print('primes after removing last item:', primes)

    primes before removing last item: [2, 3, 5, 7, 9]
    primes after removing last item: [2, 3, 5, 7]

The empty list contains no values.

-   Use [ ] on its own to represent a list that doesn’t contain any
    values.

Lists may contain values of different types.

In [26]:

    goals = [1, 'Create lists.', 2, 'Extract items from lists.', 3, 'Modify lists.']

Character strings can be indexed like lists.

In [27]:

    element = 'carbon'
    print('zeroth character:', element[0])
    print('third character:', element[3])

    zeroth character: c
    third character: b

Character strings are immutable.

-   Cannot change the characters in a string after it has been created.
    -   Immutable: can’t be changed after creation.
    -   In contrast, lists are mutable: they can be modified in place.
-   Python considers the string to be a single value with parts, not a
    collection of values.

In [28]:

    element[0] = 'C'

    ---------------------------------------------------------------------------
    TypeError                                 Traceback (most recent call last)
    <ipython-input-28-6dc46761ce07> in <module>()
    ----> 1 element[0] = 'C'

    TypeError: 'str' object does not support item assignment

### Exercises[¶](#Exercises) {#Exercises}

Given this:

    print('string to list:', list('tin'))
    print('list to string:', ''.join(['g', 'o', 'l', 'd']))

1.  What does list('some string') do?
2.  What does '-'.join(['x', 'y', 'z']) generate?

In [77]:

    print(list('YaQueremosComer'))

    ['Y', 'a', 'Q', 'u', 'e', 'r', 'e', 'm', 'o', 's', 'C', 'o', 'm', 'e', 'r']

What does the following program print?

    element = 'helium'
    print(element[-1])

1.  How does Python interpret a negative index?
2.  If a list or string has N elements, what is the most negative index
    that can safely be used with it, and what location does that index
    represent?
3.  If values is a list, what does del values[-1] do?
4.  How can you display all elements but the last one without changing
    values? (Hint: you will need to combine slicing and negative
    indexing.)

What does the following program print?

    element = 'fluorine'
    print(element[::2])
    print(element[::-1])

1.  If we write a slice as low:high:stride, what does stride do?
2.  What expression would select all of the even-numbered items from a
    collection?

### Key Points[¶](#Key-Points) {#Key-Points}

-   A list stores many values in a single structure.

-   Use an item’s index to fetch it from a list.

-   Lists’ values can be replaced by assigning to them.

-   Appending items to a list lengthens it.

-   Use del to remove items from a list entirely.

-   The empty list contains no values.

-   Lists may contain values of different types.

-   Character strings can be indexed like lists.

-   Character strings are immutable.

-   Indexing beyond the end of the collection is an error.

**For** Loops[¶](#For-Loops) {#For-Loops}
============================

10 min

Exercises (15 min)

A for loop executes commands once for each value in a collection.

*“for each thing in this group, do these operations”*

In [78]:

    for number in [2, 3, 5]:
        print(number)

    2
    3
    5

-   This for loop is equivalent to:

In [30]:

    print(2)
    print(3)
    print(5)

    2
    3
    5

A for loop is made up of a collection, loop variable and a body.

Parts of a for loop

-   The collection, [2, 3, 5], is what the loop is being run on.
-   The body, print(number), specifies what to do for each value in the
    collection.
-   The loop variable, number, is what changes for each iteration of the
    loop.

    -   The “current thing”.
-   Python uses indentation rather than {} or begin/end to show nesting.

-   Use range to iterate over a sequence of numbers.

The first line of the for loop must end with a colon, and the body must
be indented.

-   The colon at the end of the first line signals the start of a block
    of statements.
-   Python uses indentation rather than {} or begin/end to show nesting.
    -   Any consistent indentation is legal, but almost everyone uses
        four spaces.

In [80]:

    for number in [2, 3, 5]:
        print(number)

    2
    3
    5

Indentation is always meaningful in Python.

In [81]:

    firstName = "Jon"
      lastName = "Smith"

      File "<ipython-input-81-6966a7c3a64d>", line 2
        lastName = "Smith"
        ^
    IndentationError: unexpected indent

Loop variables can be called anything.

-   As with all variables, loop variables are:
    -   Created on demand.
    -   Meaningless: their names can be anything at all.

In [33]:

    for kitten in [2, 3, 5]:
        print(kitten)

    2
    3
    5

The body of a loop can contain many statements.

-   But no loop should be more than a few lines long.
-   Hard for human beings to keep larger chunks of code in mind.

In [82]:

    primes = [2, 3, 5]
    for p in primes:
        squared = p ** 2
        cubed = p ** 3
        print(p, squared, cubed)

    2 4 8
    3 9 27
    5 25 125

Use range to iterate over a sequence of numbers.

-   The built-in function range produces a sequence of numbers. Not a
    list: the numbers are produced on demand to make looping over large
    ranges more efficient.
-   range(N) is the numbers 0..N-1
    -   Exactly the legal indices of a list or character string of
        length N

In [83]:

    print('a range is not a list: range(0, 3)')
    for number in range(0, 3):
        print(number)

    a range is not a list: range(0, 3)
    0
    1
    2

The Accumulator pattern turns many values into one.

-   Initialize an accumulator variable to zero, the empty string, or the
    empty list.

In [86]:

    total = 0
    for number in range(10):
        total = total + (number + 1)
        print(total)

    1
    3
    6
    10
    15
    21
    28
    36
    45
    55

### Exercises[¶](#Exercises) {#Exercises}

Create a table showing the numbers of the lines that are executed when
this program runs, and the values of the variables after each line is
executed.

    total = 0
    for char in "tin":
        total = total + 1

Fill in the blanks in the program below so that it prints “nit” (the
reverse of the original character string “tin”).

    original = "tin"
    result = ____
    for char in original:
        result = ____
    print(result)

In [0]:

    original = "tin"
    result = ""
    for char in original:
        result = char + result
        print(result)

    t
    it
    nit

Fill in the blanks in each of the programs below to produce the
indicated result.

In [0]:

    # Total length of the strings in the list: ["red", "green", "blue"] => 12
    total = 0
    for word in ["red", "green", "blue"]:
        ____ = ____ + len(word)
    print(total)

In [87]:

    # List of word lengths: ["red", "green", "blue"] => [3, 5, 4]
    lengths = []
    for word in ["red", "green", "blue"]:
        lengths.append(len(word))
    print(lengths)

    [3, 5, 4]

In [0]:

    # Concatenate all words: ["red", "green", "blue"] => "redgreenblue"
    words = ["red", "green", "blue"]
    result = ____
    for ____ in ____:
        ____
    print(result)

In [0]:

    # Create acronym: ["red", "green", "blue"] => "RGB"
    # write the whole thing

Find the error to the following code

    students = ['Ana', 'Juan', 'Susan']
    for m in students:
    print(m)

Cumulative sum. Reorder and properly indent the lines of code below so
that they print a list with the cumulative sum of data. The result
should be [1, 3, 5, 10].

In [0]:

    cumulative.append(sum)
    for number in data:
    cumulative = []
    sum += number
    sum = 0
    print(cumulative)
    data = [1,2,2,5]

### Key Points[¶](#Key-Points) {#Key-Points}

-   A for loop executes commands once for each value in a collection.

-   A for loop is made up of a collection, a loop variable, and a body.

-   The first line of the for loop must end with a colon, and the body
    must be indented.

-   Indentation is always meaningful in Python.

-   Loop variables can be called anything (but it is strongly advised to
    have a meaningful name to the looping variable).

-   The body of a loop can contain many statements.

-   Use range to iterate over a sequence of numbers.

-   The Accumulator pattern turns many values into one.

Looping Over Data Sets[¶](#Looping-Over-Data-Sets) {#Looping-Over-Data-Sets}
==================================================

5 min

Exercises (10 min)

Use a for loop to process files given a list of their names.

In [88]:

    import pandas as pd
    for filename in ['/home/mcubero/dataSanJose19/data/gapminder_gdp_africa.csv', '/home/mcubero/dataSanJose19/data/gapminder_gdp_asia.csv']:
        data = pd.read_csv(filename, index_col='country')
        print(filename, data.min())

    /home/mcubero/dataSanJose19/data/gapminder_gdp_africa.csv gdpPercap_1952    298.846212
    gdpPercap_1957    335.997115
    gdpPercap_1962    355.203227
    gdpPercap_1967    412.977514
    gdpPercap_1972    464.099504
    gdpPercap_1977    502.319733
    gdpPercap_1982    462.211415
    gdpPercap_1987    389.876185
    gdpPercap_1992    410.896824
    gdpPercap_1997    312.188423
    gdpPercap_2002    241.165877
    gdpPercap_2007    277.551859
    dtype: float64
    /home/mcubero/dataSanJose19/data/gapminder_gdp_asia.csv gdpPercap_1952    331.0
    gdpPercap_1957    350.0
    gdpPercap_1962    388.0
    gdpPercap_1967    349.0
    gdpPercap_1972    357.0
    gdpPercap_1977    371.0
    gdpPercap_1982    424.0
    gdpPercap_1987    385.0
    gdpPercap_1992    347.0
    gdpPercap_1997    415.0
    gdpPercap_2002    611.0
    gdpPercap_2007    944.0
    dtype: float64

Use glob.glob to find sets of files whose names match a pattern.

-   In Unix, the term “globbing” means “matching a set of files with a
    pattern”.

-   '\*' meaning “match zero or more characters”

-   Python contains the glob library to provide pattern matching
    functionality.

In [90]:

    import glob
    print('all csv files in data directory:', glob.glob('/home/mcubero/dataSanJose19/data/*.csv'))

    all csv files in data directory: ['/home/mcubero/dataSanJose19/data/gapminder_all.csv', '/home/mcubero/dataSanJose19/data/gapminder_gdp_africa.csv', '/home/mcubero/dataSanJose19/data/gapminder_gdp_americas.csv', '/home/mcubero/dataSanJose19/data/gapminder_gdp_asia.csv', '/home/mcubero/dataSanJose19/data/gapminder_gdp_europe.csv', '/home/mcubero/dataSanJose19/data/gapminder_gdp_oceania.csv', '/home/mcubero/dataSanJose19/data/processed.csv']

In [91]:

    print('all PDB files:', glob.glob('*.pdb'))

    all PDB files: []

Use glob and for to process batches of files.

In [92]:

    for filename in glob.glob('/home/mcubero/dataSanJose19/data/gapminder_*.csv'):
        data = pd.read_csv(filename)
        print(filename, data['gdpPercap_1952'].min())

    /home/mcubero/dataSanJose19/data/gapminder_all.csv 298.8462121
    /home/mcubero/dataSanJose19/data/gapminder_gdp_africa.csv 298.8462121
    /home/mcubero/dataSanJose19/data/gapminder_gdp_americas.csv 1397.7171369999999
    /home/mcubero/dataSanJose19/data/gapminder_gdp_asia.csv 331.0
    /home/mcubero/dataSanJose19/data/gapminder_gdp_europe.csv 973.5331947999999
    /home/mcubero/dataSanJose19/data/gapminder_gdp_oceania.csv 10039.595640000001

### Exercises[¶](#Exercises) {#Exercises}

Which of these files is not matched by the expression
glob.glob('data/*as*.csv')?

1.  data/gapminder\_gdp\_africa.csv
2.  data/gapminder\_gdp\_americas.csv
3.  data/gapminder\_gdp\_asia.csv
4.  1 and 2 are not matched.

### Key Points[¶](#Key-Points) {#Key-Points}

-   Use a for loop to process files given a list of their names.

-   Use glob.glob to find sets of files whose names match a pattern.

-   Use glob and for to process batches of files.

### STRETCHING TIME![¶](#STRETCHING-TIME!) {#STRETCHING-TIME!}

Writing functions[¶](#Writing-functions) {#Writing-functions}
========================================

15 min

Exercises (20 min)

-   Break programs down into functions to make them easier to
    understand.

    -   Human beings can only keep a few items in working memory at a
        time.
-   Encapsulate complexity so that we can treat it as a single “thing”.

-   Write one time, use many times.

To define a function use `def` then the name of the function like this:

    def say_hi(parameter1, parameter2): 
      print('Hello')

Remember, defining a function does not run it, you must call the
function to execute it.

In [93]:

    def print_date(year, month, day):
        joined = str(year) + '/' + str(month) + '/' + str(day)
        print(joined)

    print_date(1871, 3, 19)

    1871/3/19

In [43]:

    print_date(month=3, day=19, year=1871)

    1871/3/19

-   Use return ... to give a value back to the caller.
-   May occur anywhere in the function.

In [94]:

    def average(values):
        if len(values) == 0:
            return None
        return sum(values) / len(values)

Remember: **every function returns something**

-   A function that doesn’t explicitly return a value automatically
    returns None.

### Exercises[¶](#Exercises) {#Exercises}

What does the following program print?

    def report(pressure):
        print('pressure is', pressure)

    print('calling', report, 22.5)

In [96]:

    def report(pressure):
        print('pressure is', pressure)

    print('calling', report(22.5))

    pressure is 22.5
    calling None

Fill in the blanks to create a function that takes a single filename as
an argument, loads the data in the file named by the argument, and
returns the minimum value in that data.

    import pandas as pd

    def min_in_data(____):
        data = ____
        return ____

In [98]:

    import pandas as pd

    def min_in_data(data):
        data = pd.read_csv(data)
        return data.min()
    min_in_data('/home/mcubero/dataSanJose19/data/gapminder_gdp_africa.csv')

Out[98]:

    country           Algeria
    gdpPercap_1952    298.846
    gdpPercap_1957    335.997
    gdpPercap_1962    355.203
    gdpPercap_1967    412.978
    gdpPercap_1972      464.1
    gdpPercap_1977     502.32
    gdpPercap_1982    462.211
    gdpPercap_1987    389.876
    gdpPercap_1992    410.897
    gdpPercap_1997    312.188
    gdpPercap_2002    241.166
    gdpPercap_2007    277.552
    dtype: object

The code below will run on a label-printer for chicken eggs. A digital
scale will report a chicken egg mass (in grams) to the computer and then
the computer will print a label.

Please re-write the code so that the if-block is folded into a function.

    import random
     for i in range(10):

        # simulating the mass of a chicken egg
        # the (random) mass will be 70 +/- 20 grams
        mass=70+20.0*(2.0*random.random()-1.0)

        print(mass)

        #egg sizing machinery prints a label
        if(mass>=85):
           print("jumbo")
        elif(mass>=70):
           print("large")
        elif(mass<70 and mass>=55):
           print("medium")
        else:
           print("small")

Assume that the following code has been executed:

In [46]:

    import pandas as pd

    df = pd.read_csv('/home/mcubero/dataSanJose19/data/gapminder_gdp_asia.csv', index_col=0)
    japan = df.loc['Japan']
    japan

Out[46]:

    gdpPercap_1952     3216.956347
    gdpPercap_1957     4317.694365
    gdpPercap_1962     6576.649461
    gdpPercap_1967     9847.788607
    gdpPercap_1972    14778.786360
    gdpPercap_1977    16610.377010
    gdpPercap_1982    19384.105710
    gdpPercap_1987    22375.941890
    gdpPercap_1992    26824.895110
    gdpPercap_1997    28816.584990
    gdpPercap_2002    28604.591900
    gdpPercap_2007    31656.068060
    Name: Japan, dtype: float64

1.Complete the statements below to obtain the average GDP for Japan
across the years reported for the 1980s.

    year = 1983
    gdp_decade = 'gdpPercap_' + str(year // ____)
    avg = (japan.loc[gdp_decade + ___] + japan.loc[gdp_decade + ___]) / 2

2.Abstract the code above into a single function.

    def avg_gdp_in_decade(country, continent, year):
        df = pd.read_csv('data/gapminder_gdp_'+___+'.csv',delimiter=',',index_col=0)
        ____
        ____
        ____
        return avg

1.  .How would you generalize this function if you did not know
    beforehand which specific years occurred as columns in the data? For
    instance, what if we also had data from years ending in 1 and 9 for
    each decade? (Hint: use the columns to filter out the ones that
    correspond to the decade, instead of enumerating them in the code.)

### Key Points[¶](#Key-Points) {#Key-Points}

-   Break programs down into functions to make them easier to
    understand.

-   Define a function using def with a name, parameters, and a block of
    code.

-   Defining a function does not run it.

-   Arguments in call are matched to parameters in definition.

-   Functions may return a result to their caller using return.

### Variable Scope[¶](#Variable-Scope) {#Variable-Scope}

10 min

Exercise (10 min)

The scope of a variable is the part of a program that can ‘see’ that
variable.

-   There are only so many sensible names for variables.
-   People using functions shouldn’t have to worry about what variable
    names the author of the function used.
-   People writing functions shouldn’t have to worry about what variable
    names the function’s caller uses.
-   The part of a program in which a variable is visible is called its
    scope.

In [99]:

    pressure = 103.9

    def adjust(t):
        temperature = t * 1.43 / pressure
        return temperature

-   pressure is a global variable.
    -   Defined outside any particular function.
    -   Visible everywhere.
-   t and temperature are local variables in adjust.
    -   Defined in the function.
    -   Not visible in the main program.
    -   Remember: a function parameter is a variable that is
        automatically assigned a value when the function is called.

In [100]:

    print('adjusted:', adjust(0.9))
    print('temperature after call:', temperature)

    adjusted: 0.01238691049085659

    ----------------------------------------------------------------------
    NameError                            Traceback (most recent call last)
    <ipython-input-100-e73c01f89950> in <module>()
          1 print('adjusted:', adjust(0.9))
    ----> 2 print('temperature after call:', temperature)

    NameError: name 'temperature' is not defined

### Exercises[¶](#Exercises) {#Exercises}

Trace the values of all variables in this program as it is executed.
(Use ‘—’ as the value of variables before and after they exist.)

    limit = 100

    def clip(value):
        return min(max(0.0, value), limit)

    value = -22.5
    print(clip(value))

Read the traceback below, and identify the following:

1.  How many levels does the traceback have?
2.  What is the file name where the error occurred?
3.  What is the function name where the error occurred?
4.  On which line number in this function did the error occur?
5.  What is the type of error?
6.  What is the error message?

<!-- -->

    ---------------------------------------------------------------------------
    KeyError                                  Traceback (most recent call last)
    <ipython-input-2-e4c4cbafeeb5> in <module>()
          1 import errors_02
    ----> 2 errors_02.print_friday_message()

    /Users/ghopper/thesis/code/errors_02.py in print_friday_message()
         13
         14 def print_friday_message():
    ---> 15     print_message("Friday")

    /Users/ghopper/thesis/code/errors_02.py in print_message(day)
          9         "sunday": "Aw, the weekend is almost over."
         10     }
    ---> 11     print(messages[day])
         12
         13

    KeyError: 'Friday'

### Key Points[¶](#Key-Points) {#Key-Points}

-   The scope of a variable is the part of a program that can ‘see’ that
    variable.

Conditionals[¶](#Conditionals) {#Conditionals}
==============================

15 min

Exercise (15 min)

Use if statements to control whether or not a block of code is executed.

-   An if statement (more properly called a conditional statement)
    controls whether some block of code is executed or not.
-   Structure is similar to a for statement:
    -   First line opens with if and ends with a colon
    -   Body containing one or more statements is indented (usually by 4
        spaces)

In [52]:

    mass = 2.07

    if mass > 3.0:
        print (mass, 'is large')
        

In [102]:

    masses = [3.54, 2.07, 9.22, 1.86, 1.71]
    for m in masses:
        if m > 3.0:
            print(m, 'is large')
        else:
            print(m, 'is small')

    3.54 is large
    2.07 is small
    9.22 is large
    1.86 is small
    1.71 is small

In [104]:

    thing1 = [3.54, 2.07, 9.22]
    if masses > thing1:
        print (masses, 'is large')

    [3.54, 2.07, 9.22, 1.86, 1.71] is large

Conditionals are often used inside loops.

-   Not much point using a conditional when we know the value (as
    above).
-   But useful when we have a collection to process.

In [54]:

    masses = [3.54, 2.07, 9.22, 1.86, 1.71]
    for m in masses:
        if m > 3.0:
            print(m, 'is large')

    3.54 is large
    9.22 is large

Use else to execute a block of code when an if condition is not true.

-   else can be used following an if.
-   Allows us to specify an alternative to execute when the if branch
    isn’t taken.

In [55]:

    masses = [3.54, 2.07, 9.22, 1.86, 1.71]
    for m in masses:
        if m > 3.0:
            print(m, 'is large')
        else:
            print(m, 'is small')

    3.54 is large
    2.07 is small
    9.22 is large
    1.86 is small
    1.71 is small

Use elif to specify additional tests.

-   May want to provide several alternative choices, each with its own
    test.
-   Use elif (short for “else if”) and a condition to specify these.
-   Always associated with an if.
-   Must come before the else (which is the “catch all”).

-   Complete the next conditional

In [56]:

    masses = [3.54, 2.07, 9.22, 1.86, 1.71]
    for m in ____:
        if m > 9.0:
            print(__, 'is HUGE')
        elif m > 3.0:
            print(m, 'is large')
        ___:
            print(m, 'is small')

      File "<ipython-input-56-97e8fa260561>", line 7
        ___:
            ^
    SyntaxError: invalid syntax

Conditions are tested once, in order.

-   Python steps through the branches of the conditional in order,
    testing each in turn.
-   So ordering matters.

In [0]:

    grade = 85
    if grade >= 70:
        print('grade is C')
    elif grade >= 80:
        print('grade is B')
    elif grade >= 90:
        print('grade is A')

    grade is C

-   Does not automatically go back and re-evaluate if values change.

In [0]:

    velocity = 10.0
    if velocity > 20.0:
        print('moving too fast')
    else:
        print('adjusting velocity')
        velocity = 50.0

Often use conditionals in a loop to “evolve” the values of variables.

In [105]:

    velocity = 10.0
    for i in range(5): # execute the loop 5 times
        print(i, ':', velocity)
        if velocity > 20.0:
            print('moving too fast')
            velocity = velocity - 5.0
        else:
            print('moving too slow')
            velocity = velocity + 10.0
    print('final velocity:', velocity)

    0 : 10.0
    moving too slow
    1 : 20.0
    moving too slow
    2 : 30.0
    moving too fast
    3 : 25.0
    moving too fast
    4 : 20.0
    moving too slow
    final velocity: 30.0

Conditionals are useful to check for errors!

Often, you want some combination of things to be true. You can combine
relations within a conditional using and and or. Continuing the example
above, suppose you have

In [0]:

    mass     = [ 3.54,  2.07,  9.22,  1.86,  1.71]
    velocity = [10.00, 20.00, 30.00, 25.00, 20.00]

    i = 0
    for i in range(5):
        if mass[i] > 5 and velocity[i] > 20:
            print("Fast heavy object.  Duck!")
        elif mass[i] > 2 and mass[i] <= 5 and velocity[i] <= 20:
            print("Normal traffic")
        elif mass[i] <= 2 and velocity[i] <= 20:
            print("Slow light object.  Ignore it")
        else:
            print("Whoa!  Something is up with the data.  Check it")

    Normal traffic
    Normal traffic
    Fast heavy object.  Duck!
    Whoa!  Something is up with the data.  Check it
    Slow light object.  Ignore it

Just like with arithmetic, you can and should use parentheses whenever
there is possible ambiguity. A good general rule is to always use
parentheses when mixing and and or in the same condition. That is,
instead of:

In [0]:

    if mass[i] <= 2 or mass[i] >= 5 and velocity[i] > 20:

write one of these:

In [0]:

    if (mass[i] <= 2 or mass[i] >= 5) and velocity[i] > 20:
    if mass[i] <= 2 or (mass[i] >= 5 and velocity[i] > 20):

so it is perfectly clear to a reader (and to Python) what you really
mean.

### Exercise[¶](#Exercise) {#Exercise}

What does this program print?

    pressure = 71.9
    if pressure > 50.0:
        pressure = 25.0
    elif pressure <= 50.0:
        pressure = 0.0
    print(pressure)

In [106]:

    pressure = 71.9
    if pressure > 50.0:
        pressure = 25.0
    elif pressure <= 50.0:
        pressure = 0.0
    print(pressure)

    25.0

**Trimming Values** Fill in the blanks so that this program creates a
new list containing zeroes where the original list’s values were
negative and ones where the original list’s values were positive.

In [107]:

    original = [-1.5, 0.2, 0.4, 0.0, -1.3, 0.4]
    result = []
    for value in original:
        if value < 0.0:
            result.append(0)
        else:
            result.append(1)
    print(result)

    [0, 1, 1, 1, 0, 1]

-   Modify this program so that it only processes files with fewer than
    50 records.

In [108]:

    import glob
    import pandas as pd
    for filename in glob.glob('/home/mcubero/dataSanJose19/data/*.csv'):
        contents = pd.read_csv(filename)
        if len(contents) < 50:
            print(filename, len(contents))

    /home/mcubero/dataSanJose19/data/gapminder_gdp_americas.csv 25
    /home/mcubero/dataSanJose19/data/gapminder_gdp_asia.csv 33
    /home/mcubero/dataSanJose19/data/gapminder_gdp_europe.csv 30
    /home/mcubero/dataSanJose19/data/gapminder_gdp_oceania.csv 2
    /home/mcubero/dataSanJose19/data/processed.csv 2

Modify this program so that it finds the largest and smallest values in
the list no matter what the range of values originally is.

    values = [...some test data...]
    smallest, largest = None, None
    for v in values:
        if ____:
            smallest, largest = v, v
        ____:
            smallest = min(____, v)
            largest = max(____, v)
    print(smallest, largest)

What are the advantages and disadvantages of using this method to find
the range of the data?

-   Using functions with conditionals in Pandas

Functions will often contain conditionals. Here is a short example that
will indicate which quartile the argument is in based on hand-coded
values for the quartile cut points.

In [9]:

    def calculate_life_quartile(exp):
        if exp < 58.41:
            # This observation is in the first quartile
            return 1
        elif exp >= 58.41 and exp < 67.05:
            # This observation is in the second quartile
           return 2
        elif exp >= 67.05 and exp < 71.70:
            # This observation is in the third quartile
           return 3
        elif exp >= 71.70:
            # This observation is in the fourth quartile
           return 4
        else:
            # This observation has bad data
           return None

    calculate_life_quartile(62.5)

Out[9]:

    2

That function would typically be used within a for loop, but Pandas has
a different, more efficient way of doing the same thing, and that is by
applying a function to a dataframe or a portion of a dataframe. Here is
an example, using the definition above.

In [59]:

    data = pd.read_csv('/home/mcubero/dataSanJose19/data/all-Americas.csv')
    data
    #data['life_qrtl'] = data['lifeExp'].apply(calculate_life_quartile)

Out[59]:

continent

country

gdpPercap\_1952

gdpPercap\_1957

gdpPercap\_1962

gdpPercap\_1967

gdpPercap\_1972

gdpPercap\_1977

gdpPercap\_1982

gdpPercap\_1987

gdpPercap\_1992

gdpPercap\_1997

gdpPercap\_2002

gdpPercap\_2007

0

Americas

Argentina

5911.315053

6856.856212

7133.166023

8052.953021

9443.038526

10079.026740

8997.897412

9139.671389

9308.418710

10967.281950

8797.640716

12779.379640

1

Americas

Bolivia

2677.326347

2127.686326

2180.972546

2586.886053

2980.331339

3548.097832

3156.510452

2753.691490

2961.699694

3326.143191

3413.262690

3822.137084

2

Americas

Brazil

2108.944355

2487.365989

3336.585802

3429.864357

4985.711467

6660.118654

7030.835878

7807.095818

6950.283021

7957.980824

8131.212843

9065.800825

3

Americas

Canada

11367.161120

12489.950060

13462.485550

16076.588030

18970.570860

22090.883060

22898.792140

26626.515030

26342.884260

28954.925890

33328.965070

36319.235010

4

Americas

Chile

3939.978789

4315.622723

4519.094331

5106.654313

5494.024437

4756.763836

5095.665738

5547.063754

7596.125964

10118.053180

10778.783850

13171.638850

5

Americas

Colombia

2144.115096

2323.805581

2492.351109

2678.729839

3264.660041

3815.807870

4397.575659

4903.219100

5444.648617

6117.361746

5755.259962

7006.580419

6

Americas

Costa Rica

2627.009471

2990.010802

3460.937025

4161.727834

5118.146939

5926.876967

5262.734751

5629.915318

6160.416317

6677.045314

7723.447195

9645.061420

7

Americas

Cuba

5586.538780

6092.174359

5180.755910

5690.268015

5305.445256

6380.494966

7316.918107

7532.924763

5592.843963

5431.990415

6340.646683

8948.102923

8

Americas

Dominican Republic

1397.717137

1544.402995

1662.137359

1653.723003

2189.874499

2681.988900

2861.092386

2899.842175

3044.214214

3614.101285

4563.808154

6025.374752

9

Americas

Ecuador

3522.110717

3780.546651

4086.114078

4579.074215

5280.994710

6679.623260

7213.791267

6481.776993

7103.702595

7429.455877

5773.044512

6873.262326

10

Americas

El Salvador

3048.302900

3421.523218

3776.803627

4358.595393

4520.246008

5138.922374

4098.344175

4140.442097

4444.231700

5154.825496

5351.568666

5728.353514

11

Americas

Guatemala

2428.237769

2617.155967

2750.364446

3242.531147

4031.408271

4879.992748

4820.494790

4246.485974

4439.450840

4684.313807

4858.347495

5186.050003

12

Americas

Haiti

1840.366939

1726.887882

1796.589032

1452.057666

1654.456946

1874.298931

2011.159549

1823.015995

1456.309517

1341.726931

1270.364932

1201.637154

13

Americas

Honduras

2194.926204

2220.487682

2291.156835

2538.269358

2529.842345

3203.208066

3121.760794

3023.096699

3081.694603

3160.454906

3099.728660

3548.330846

14

Americas

Jamaica

2898.530881

4756.525781

5246.107524

6124.703451

7433.889293

6650.195573

6068.051350

6351.237495

7404.923685

7121.924704

6994.774861

7320.880262

15

Americas

Mexico

3478.125529

4131.546641

4581.609385

5754.733883

6809.406690

7674.929108

9611.147541

8688.156003

9472.384295

9767.297530

10742.440530

11977.574960

16

Americas

Nicaragua

3112.363948

3457.415947

3634.364406

4643.393534

4688.593267

5486.371089

3470.338156

2955.984375

2170.151724

2253.023004

2474.548819

2749.320965

17

Americas

Panama

2480.380334

2961.800905

3536.540301

4421.009084

5364.249663

5351.912144

7009.601598

7034.779161

6618.743050

7113.692252

7356.031934

9809.185636

18

Americas

Paraguay

1952.308701

2046.154706

2148.027146

2299.376311

2523.337977

3248.373311

4258.503604

3998.875695

4196.411078

4247.400261

3783.674243

4172.838464

19

Americas

Peru

3758.523437

4245.256698

4957.037982

5788.093330

5937.827283

6281.290855

6434.501797

6360.943444

4446.380924

5838.347657

5909.020073

7408.905561

20

Americas

Puerto Rico

3081.959785

3907.156189

5108.344630

6929.277714

9123.041742

9770.524921

10330.989150

12281.341910

14641.587110

16999.433300

18855.606180

19328.709010

21

Americas

Trinidad and Tobago

3023.271928

4100.393400

4997.523971

5621.368472

6619.551419

7899.554209

9119.528607

7388.597823

7370.990932

8792.573126

11460.600230

18008.509240

22

Americas

United States

13990.482080

14847.127120

16173.145860

19530.365570

21806.035940

24072.632130

25009.559140

29884.350410

32003.932240

35767.433030

39097.099550

42951.653090

23

Americas

Uruguay

5716.766744

6150.772969

5603.357717

5444.619620

5703.408898

6504.339663

6920.223051

7452.398969

8137.004775

9230.240708

7727.002004

10611.462990

24

Americas

Venezuela

7689.799761

9802.466526

8422.974165

9541.474188

10505.259660

13143.950950

11152.410110

9883.584648

10733.926310

10165.495180

8605.047831

11415.805690

There is a lot in that second line, so let’s take it piece by piece. On
the right side of the = we start with data['lifeExp'], which is the
column in the dataframe called data labeled lifExp. We use the apply()
to do what it says, apply the calculate\_life\_quartile to the value of
this column for every row in the dataframe.

### Key Points[¶](#Key-Points) {#Key-Points}

-   Use if statements to control whether or not a block of code is
    executed.

-   Conditionals are often used inside loops.

-   Use else to execute a block of code when an if condition is not
    true.

-   Use elif to specify additional tests.

-   Conditions are tested once, in order.

-   Create a table showing variables’ values to trace a program’s
    execution.

Plotting[¶](#Plotting) {#Plotting}
======================

20 min Exercises (15 min)

We are going to use matplotlib.

**`matplotlib`** is the most widely used scientific plotting library in
Python.

-   Commonly use a sub-library called matplotlib.pyplot.
-   The Jupyter Notebook will render plots inline if we ask it to using
    a “magic” command.

In [61]:

    #%matplotlib inline
    import matplotlib.pyplot as plt

-   Simple plots are then (fairly) simple to create

In [62]:

    time = [0, 1, 2, 3]
    position = [0, 100, 200, 300]

    plt.plot(time, position)
    plt.xlabel('Time (hr)')
    plt.ylabel('Position (km)')

Out[62]:

    Text(0,0.5,'Position (km)')

![](data:image/png;base64,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%0A)

### Plot data directly from a Pandas dataframe[¶](#Plot-data-directly-from-a-Pandas-dataframe) {#Plot-data-directly-from-a-Pandas-dataframe}

-   We can also plot Pandas dataframes.
-   This implicitly uses matplotlib.pyplot.
-   Before plotting, we convert the column headings from a string to
    integer data type, since they represent numerical values

In [64]:

    import pandas as pd

    data = pd.read_csv('/home/mcubero/dataSanJose19/data/gapminder_gdp_oceania.csv', index_col='country')

    # Extract year from last 4 characters of each column name
    years = data.columns.str.strip('gdpPercap_')
    # Convert year values to integers, saving results back to dataframe
    data.columns = years.astype(int)

    data.loc['Australia'].plot()

Out[64]:

    <matplotlib.axes._subplots.AxesSubplot at 0x7fdc600bc588>

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAYcAAAD8CAYAAACcjGjIAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEgAACxIB0t1+/AAAADl0RVh0U29mdHdhcmUAbWF0cGxvdGxpYiB2ZXJzaW9uIDIuMS4yLCBodHRwOi8vbWF0cGxvdGxpYi5vcmcvNQv5yAAAIABJREFUeJzt3Xd8VvXd//HXh7D3CHuFEVGGgASCA+ct4Cq2jjpBhtiqP21rrdpabbW97y71vrtsQRBwU1GhiqXO4igj7CmEnRAIO2EkIcnn98d1sFFWEkjOdV15Px+P68HJ55xzXZ8vV5J3zrjOMXdHRESkpGphNyAiItFH4SAiIkdROIiIyFEUDiIichSFg4iIHEXhICIiR1E4iIjIURQOIiJyFIWDiIgcpXrYDZRXYmKiJyUlhd2GiEhMWbBgwU53b36y5WI2HJKSkkhLSwu7DRGRmGJmm0qz3El3K5lZbTObZ2ZLzGyFmf08qE8ysw1mtjh49AnqZma/N7N0M1tqZueUeK4RZrY2eIwoUe9nZsuCdX5vZlb2IYuIyOlSmi2HfOBSd99vZjWAT83s3WDeg+7++teWvwJIDh6pwLNAqpk1BR4HUgAHFpjZDHffEyxzJzAXmAkMBd5FRERCcdItB4/YH3xZI3ic6FKuw4ApwXpzgMZm1hoYArzn7ruDQHgPGBrMa+juczxyidgpwLWnMCYRETlFpTpbycwSzGwxkE3kF/zcYNYvg11Hz5hZraDWFthSYvWMoHaiesYx6iIiEpJShYO7F7l7H6AdMMDMegKPAGcC/YGmwEMV1mXAzMaaWZqZpe3YsaOiX05EpMoq0+cc3H0v8BEw1N2zgl1H+cDzwIBgsUygfYnV2gW1E9XbHaN+rNcf5+4p7p7SvPlJz8QSEZFyKs3ZSs3NrHEwXQe4HFgdHCsgOLPoWmB5sMoMYHhw1tJAYJ+7ZwGzgMFm1sTMmgCDgVnBvBwzGxg813Bg+ukdpoiIlEVpzlZqDUw2swQiYTLV3d82sw/NrDlgwGLgO8HyM4ErgXTgIDASwN13m9mTwPxguSfcfXcwfTcwCahD5CwlnakkIvI1G3Ye4PUFW3jg8m5Uq1axZ/xbrN5DOiUlxfUhOBGpKrbn5HHds59zsKCId+67gNaN6pTrecxsgbunnGw5XVtJRCTK7Tt0mBET57HnQAGTRvYvdzCURcxePkNEpCrIO1zEmMnzWbdjP8/fMYCz2zWulNdVOIiIRKnComLufXkRaZv28Ieb+3JBcmKlvbZ2K4mIRCF358dvLuP9Vdv5+Td6cPXZbSr19RUOIiJR6LezvmBqWgb3XZbM8HOTKv31FQ4iIlFmwqcb+PPH67gltQPf/6/kUHpQOIiIRJG3FmXy5NsruaJnK54c1pOw7mCgcBARiRIff5HND/+2hIGdm/LMt/uQUMEfdDsRhYOISBRYtHkP331xId1aNWD88BRq10gItR+Fg4hIyNKzcxk5aT4tGtZi0sgBNKhdI+yWFA4iImHauvcQwyfMo3q1arwwKpXmDWqdfKVKoHAQEQnJngMFDJ84j9y8QiaP6k+HZnXDbulL+oS0iEgIDhYUMmryfDbvPsjkkQPo0aZR2C19hbYcREQq2eGiYu5+aSFLtuzl9zf15dwuzcJu6SjachARqUTFxc6PXl/Kx1/s4H++1YuhPVuF3dIxactBRKSSuDv/PXMVby7K5IHLz+DmAR3Cbum4FA4iIpXkr7PX89ynG7jjvCTuvbRr2O2ckMJBRKQSTE3bwq/eXc01vdvw2NXdQ7ssRmkpHEREKtj7K7fzyBvLGJScyFM39K7w+z+fDgoHEZEKNH/jbu55eSE92zTk2dv6UbN6bPzajY0uRURi0OptOYyeNJ+2jesw8Y7+1K8VOyeIKhxERCrAlt0HGTFxHnVqJjBl9ACa1Y+Oy2KUlsJBROQ027U/nxET53GooIgpo1Jp1yR6LotRWrGzjSMiEgP25xcyctJ8Mvce4qUxqXRr1SDslspF4SAicprkFxbxnRcWsGJrDuNu70dKUtOwWyo37VYSETkNioudB6Yu4dP0nfzqW7247KyWYbd0ShQOIiKnyN35+d9X8PbSLB6+4kxuSGkfdkunTOEgInKK/vhhOpP/vYk7B3Xirgs7h93OaaFwEBE5BS/N3cRT763hW33b8sgVZ0X9ZTFKS+EgIlJO7y7L4qdvLeeSbs359fVnx8RlMUpL4SAiUg6frt3J/a8upm+HJvzp1nOokRBfv07jazQiIpVg0eY9jH0hjc7N6zFxRH/q1oy/TwWcNBzMrLaZzTOzJWa2wsx+HtQ7mdlcM0s3s9fMrGZQrxV8nR7MTyrxXI8E9S/MbEiJ+tCglm5mD5/+YYqInB5rtucyctJ8EuvXYsqoATSqWyPslipEabYc8oFL3b030AcYamYDgV8Dz7h7V2APMDpYfjSwJ6g/EyyHmXUHbgJ6AEOBP5tZgpklAH8CrgC6AzcHy4qIRJUtuw9y+4S51EioxoujU2nRsHbYLVWYk4aDR+wPvqwRPBy4FHg9qE8Grg2mhwVfE8y/zCKH74cBr7p7vrtvANKBAcEj3d3Xu3sB8GqwrIhI1NiRm8/tE+ZyqKCIF0YPoEOz2LteUlmU6phD8Bf+YiAbeA9YB+x198JgkQygbTDdFtgCEMzfBzQrWf/aOserH6uPsWaWZmZpO3bsKE3rIiKnLCfvMCMmzmNbTh7Pj+zPma0aht1ShStVOLh7kbv3AdoR+Uv/zArt6vh9jHP3FHdPad68eRgtiEgVc6igiDGT0libnctfbutHv46xe72ksijT2Uruvhf4CDgXaGxmRw7RtwMyg+lMoD1AML8RsKtk/WvrHK8uIhKqw0XF3PPyQuZv2s3TN/bh4m4twm6p0pTmbKXmZtY4mK4DXA6sIhIS1weLjQCmB9Mzgq8J5n/o7h7UbwrOZuoEJAPzgPlAcnD2U00iB61nnI7BiYiUV3Gx86PXl/Lh6myeHNaTa3q3CbulSlWak3NbA5ODs4qqAVPd/W0zWwm8ama/ABYBE4LlJwAvmFk6sJvIL3vcfYWZTQVWAoXAPe5eBGBm9wKzgARgoruvOG0jFBEpI3fnibdX8uaiTH44+AxuG9gx7JYqnUX+qI89KSkpnpaWFnYbIhKH/u/9tTzz/hpGX9CJR6+Kn+slAZjZAndPOdly+oS0iEgJkz/fyDPvr+G6c9rxkyvjKxjKQuEgIhKYvjiTx2es4PLuLfn1db3i6kJ6ZaVwEBEBPlqdzQNTlzCwc1P+cHNfqsfZhfTKqmqPXkQEmL9xN995cQFntW7I+OEp1K6REHZLoVM4iEiVtnJrDqMmzadtkzpMGtmfBrXj80J6ZaVwEJEqa+POAwyfOI/6tarzwuhUmtWvFXZLUUPhICJV0vacPG6bMJdid14YnUrbxnXCbimqKBxEpMrZe7CA2yfMZc+BAiaN7E/XFvXDbinqxN/ti0RETuBgQSEjJ81n486DTBrVn7PbNQ67paikLQcRqTLyC4u464UFLNmylz/c0pfzuiSG3VLU0paDiFQJRcXOD15bwidrd/Kb689mSI9WYbcU1bTlICJxz9159K3lvLMsi59ceRY3prQ/+UpVnMJBROLeb2d9wSvzNnP3xV2488LOYbcTExQOIhLXxs9ez58/XsctqR14cEi3sNuJGQoHEYlbU9O28MuZq7jq7NY8Oaxnlb3CankoHEQkLv1j+TYenraUQcmJPHNjHxKq8BVWy0PhICJx5/N1O7nvlUX0bt+Yv97ej5rV9auurPQ/JiJxZWnGXu6cnEanxHo8f0d/6tbUGfvloXAQkbjxxbZcRkycR9P6NZkyegCN69YMu6WYpXAQkbiwYecBbn1uLjWrV+PF0am0bFg77JZimsJBRGJexp6D3Dp+Du7OS2NS6disXtgtxTyFg4jEtO05edz63Fz25xfywuhUurZoEHZLcUHhICIxa9f+fG59bi47c/OZPGoA3ds0DLuluKHD+CISk/YdOsztE+aRsecgk0YOoG+HJmG3FFe05SAiMWd/fiF3PD+P9Oz9/PX2FAZ2bhZ2S3FHWw4iElPyDhcxZvJ8lmbs48+3nsNFZzQPu6W4pC0HEYkZR27WM3fDbp6+sbfuyVCBFA4iEhMKi4q5/5XF/GvNDn71rV4M69M27JbimsJBRKJeUbHzw78t4R8rtvH4Nd35dv8OYbcU9xQOIhLVIndxW8Zbi7fy4JBujDy/U9gtVQkKBxGJWu7Ok2+v4pV5W7j3kq7cc0nXsFuqMk4aDmbW3sw+MrOVZrbCzO4P6j8zs0wzWxw8riyxziNmlm5mX5jZkBL1oUEt3cweLlHvZGZzg/prZqarZYkIT/1zDRM/28DI85N4YPAZYbdTpZRmy6EQeMDduwMDgXvMrHsw7xl37xM8ZgIE824CegBDgT+bWYKZJQB/Aq4AugM3l3ieXwfP1RXYA4w+TeMTkRj1p4/S+eNH6dw8oD2PXd1dd3GrZCcNB3fPcveFwXQusAo40WkCw4BX3T3f3TcA6cCA4JHu7uvdvQB4FRhmkXf8UuD1YP3JwLXlHZCIxL7nP9vAb2d9wbV92vCLa3spGEJQpmMOZpYE9AXmBqV7zWypmU00syOfXW8LbCmxWkZQO169GbDX3Qu/VheRKui1+Zv5+d9XMqRHS353Q2/d3jMkpQ4HM6sPTAO+5+45wLNAF6APkAU8VSEdfrWHsWaWZmZpO3bsqOiXE5FKNn1xJg+/sYyLzmjO72/uS/UEnTMTllL9z5tZDSLB8JK7vwHg7tvdvcjdi4HxRHYbAWQC7Uus3i6oHa++C2hsZtW/Vj+Ku49z9xR3T2neXB+ZF4kns1Zs4wdTl5DaqSl/vb0ftaonhN1SlVaas5UMmACscvenS9Rbl1jsm8DyYHoGcJOZ1TKzTkAyMA+YDyQHZybVJHLQeoa7O/ARcH2w/ghg+qkNS0Riyb/W7OD/vbyIs9s14rkR/aldQ8EQttJceO984HZgmZktDmo/JnK2UR/AgY3AXQDuvsLMpgIriZzpdI+7FwGY2b3ALCABmOjuK4Lnewh41cx+ASwiEkYiUgXMWb+LsVPS6NqiPpPuGED9WroeaDSwyB/usSclJcXT0tLCbkNETsGizXu47bm5tG5ch9fGDqRZ/VphtxT3zGyBu6ecbDkd7RGRUKzYuo8RE+eR2KAWL41JVTBEGYWDiFS69Oxchk+YR/1a1XlpTCotG9YOuyX5GoWDiFSqTbsOcOtzczEzXhyTSrsmdcNuSY5B4SAilWbr3kPcMn4uBYXFvDQmlc7N64fdkhyHwkFEKkV2bh63PjeXnEOHmTIqlW6tGoTdkpyAzhkTkQq350ABtz83j2378nhh9AB6tWsUdktyEgoHEalQew4UMHziPDbsOsDzd/QnJalp2C1JKSgcRKRCbN51kImfbWBq2hYKCosZN7wf53dNDLstKSWFg4icVgs37+G5T9bzj+XbqGbGN3q3YexFnTmzVcOwW5MyUDiIyCkrKnbeW7mN8Z9sYMGmPTSsXZ2xF3bhjvOSaNVIn2GIRQoHESm3gwWF/C0tg4mfbWDTroO0b1qHx6/pzo0p7amnayTFNL17IlJm2Tl5TPp8Iy/N3cy+Q4fp26ExDw09kyE9WunmPHFC4SAipbZ6Ww7PfbKB6YszKSx2hnRvxZ0XdqJfR52BFG8UDiJyQu7OJ2t3Mv6T9Xyydid1aiRwy4AOjLqgEx2b1Qu7PakgCgcROab8wiJmLN7KhE83sHpbLs0b1OLBId24NbUDjevWDLs9qWAKBxH5ir0HC3hp7mYmf76R7Nx8urVswG+vP5tv9GmjW3dWIQoHEQEiV0ud+OkGpqZlcOhwEYOSE/ntDb25MDmRyN2CpSpROIhUcQs27Wb87A3MWrmN6tWMb/Ruy5hBnTirtT60VpUpHESqoKJiZ9aKbYz/ZD2LNu+lUZ0afPeiLow4L0k33hFA4SBS5cxZv4uHpy1l466DdGhal59/owfX92unD63JV+i7QaSKKCgs5un31vDX2evo2LQuf7ntHC7vrg+tybEpHESqgPTs/XzvtUUsz8zh5gHtefSq7tpSkBPSd4dIHHN3XpyziV/OXEWdGgmMu70fg3u0CrstiQEKB5E4tSM3n4emLeXD1dlcdEZzfnv92bTQwWYpJYWDSBz6YNV2fvT6UnLzC/nZNd0ZcV6SPqsgZaJwEIkjhwqK+OXMlbw4ZzNntW7IKzf14YyWDcJuS2KQwkEkTizL2Mf9ry1i/Y4DjL2wMw8MPkOXu5ByUziIxLiiYuevs9fx9D/XkFi/Fi+PSeU83atZTpHCQSSGZe49xPdfW8y8Dbu5qldrfvnNnrpiqpwWCgeRGDV9cSaPvrUcd3jqht5865y2Ougsp43CQSTG7Dt0mMemL2f64q3069iE//12H9o3rRt2WxJnFA4iMWTu+l38YOoStuXk8YPLz+Dui7tQPaFa2G1JHDrpd5WZtTezj8xspZmtMLP7g3pTM3vPzNYG/zYJ6mZmvzezdDNbambnlHiuEcHya81sRIl6PzNbFqzze9O2schXFBQW8+t/rOam8XOokWC8/p1zue+yZAWDVJjSfGcVAg+4e3dgIHCPmXUHHgY+cPdk4IPga4ArgOTgMRZ4FiJhAjwOpAIDgMePBEqwzJ0l1ht66kMTiQ/p2fu57tnPefbjddzYrz3v3DeIvh2anHxFkVNw0t1K7p4FZAXTuWa2CmgLDAMuDhabDHwMPBTUp7i7A3PMrLGZtQ6Wfc/ddwOY2XvAUDP7GGjo7nOC+hTgWuDd0zNEkdjk7rw0dzO/eGcldWok8Jfb+jG0p66LJJWjTMcczCwJ6AvMBVoGwQGwDWgZTLcFtpRYLSOonaiecYz6sV5/LJGtETp06FCW1kViys79+Tz0+lI+WJ3NoOREfndDb92ERypVqcPBzOoD04DvuXtOycMC7u5m5hXQ31e4+zhgHEBKSkqFv55IGD5anc2Dry8hJ6+Qx6/pzohzk6imey5IJStVOJhZDSLB8JK7vxGUt5tZa3fPCnYbZQf1TKB9idXbBbVM/rMb6kj946De7hjLi1QphwqK+O+Zq3hhzibObNWAl8YMpFsrXRdJwlGas5UMmACscvenS8yaARw542gEML1EfXhw1tJAYF+w+2kWMNjMmgQHogcDs4J5OWY2MHit4SWeSyTuuTvzN+7m6j98wgtzNjHmgk68dc/5CgYJVWm2HM4HbgeWmdnioPZj4FfAVDMbDWwCbgzmzQSuBNKBg8BIAHffbWZPAvOD5Z44cnAauBuYBNQhciBaB6Mlrrk7yzNzeHvZVmYuy2LL7kO0bFiLF0enckGyrosk4bPISUWxJyUlxdPS0sJuQ6TU3J0VW3N4Z1kW7yzNYvPug1SvZpzXNZGre7VmaK9WNKxdI+w2Jc6Z2QJ3TznZcvqEtEgFOhIIM5dl8c6yLDbtOkhCNeO8Ls2455IuDO7eiib1dKE8iT4KB5HTzN1ZmRUEwtIsNpYIhO9e1IXBPVrRVIEgUU7hIHIauDursnK/3ELYsPMACdWMczs3466LujBEgSAxRuEgUk7uzuptuV9uIazfeYBqBud2acadgzozpEdLmtWvFXabIuWicBApA3fni+25zFyaxdvLsli/IxIIAzs3Y/SgTgzp0YpEBYLEAYWDSCms2Z7L20uzeGfpVtYFgZDaqRmjzu/E0J4KBIk/CgeR41h7JBCWZZGevf/LQLjj/E4M7dGK5g0UCBK/FA4iJRQVO++t3Ma42etZuHkvZpDaqSkjzu3BkJ6taNFAF7+TqkHhIELkukavL9jCc59uYNOug7RvWoefXt2da3q3ViBIlaRwkCptR24+U/69kRfmbGLvwcP0ad+Yh4aeyZAerUjQlVClClM4SJWUnp3Lc59s4I1FmRwuKubys1oy9sLO9OvYBN2lVkThIFWIuzN3w27Gz17PB6uzqVW9Gjf0a8foCzrRuXn9sNsTiSoKB4l7hUXFvLt8G+M/Wc/SjH00rVeT7/1XMrcP7KgPqYkch8JB4tb+/EJem7+FiZ9uIHPvITol1uOX3+zJdee0o3aNhLDbE4lqCgeJO9v25THp8428NHcTuXmFDEhqys++0YPLzmyh222KlJLCQeLG6m05jJ+9gRlLMikqdq7o2ZoxgzrRt0OTsFsTiTkKB4lp7s6n6TsZN3s9n6zdSZ0aCdya2pFR53eiQ7O6YbcnErMUDhKTCgqLeXvpVsbNXs/qbbkk1q/Fg0O6cWtqBxrX1aWxRU6VwkFiSk7eYV6Zu5nnP9vItpw8klvU5zfXn82wPm2oVV0HmUVOF4WDxIScvMP84YO1vDJvC/vzCzmvSzP+57peXJTcXAeZRSqAwkGi3kers3nkjWVk5+ZxTe823DmoMz3bNgq7LZG4pnCQqLXv4GGeeHsl0xZmkNyiPn+5/Xz6tG8cdlsiVYLCQaLS+yu38+M3l7HrQAH3XNKF+y5L1jEFkUqkcJCosvdgAU/8fSVvLMqkW8sGTBjRn17ttAtJpLIpHCRqzFqxjUffWs6eAwXcd2lX7r00mZrVq4XdlkiVpHCQ0O0+UMDPZqxgxpKtnNW6Ic/f0V8HnEVCpnCQUP1jeRaPvrWcvQcP8/3/OoPvXtxFWwsiUUDhIKHYtT+fx2as4J2lWfRo05Apo1Lp3qZh2G2JSEDhIJXunaVZ/HT6cnLzDvPDwWdw10VdqJGgrQWRaKJwkEqzIzefx6Yv593l2+jVthG/u2Eg3Vo1CLstETkGhYNUOHdnxpKt/GzGCg7kF/Gjod0YO6gz1bW1IBK1TvrTaWYTzSzbzJaXqP3MzDLNbHHwuLLEvEfMLN3MvjCzISXqQ4Naupk9XKLeyczmBvXXzEyX1Iwj2bl53PXCAu5/dTEdmtXjnfsu4O6LuyoYRKJcaX5CJwFDj1F/xt37BI+ZAGbWHbgJ6BGs82czSzCzBOBPwBVAd+DmYFmAXwfP1RXYA4w+lQFJdHB33lqUyeVPz+bjNTt45Iozmfadc0luqd1IIrHgpLuV3H22mSWV8vmGAa+6ez6wwczSgQHBvHR3Xw9gZq8Cw8xsFXApcEuwzGTgZ8CzpR2ARJ/tOXn85M1lvL8qm3M6NOY31/ema4v6YbclImVwKscc7jWz4UAa8IC77wHaAnNKLJMR1AC2fK2eCjQD9rp74TGWlxjj7kxbmMkTf19BfmExj151FiPP70SCLqktEnPKu+P3WaAL0AfIAp46bR2dgJmNNbM0M0vbsWNHZbyklNK2fXmMmjSfH/5tCd1aNeDd+wcxZlBnBYNIjCrXloO7bz8ybWbjgbeDLzOB9iUWbRfUOE59F9DYzKoHWw8llz/W644DxgGkpKR4eXqX08vd+VtaBk++s5LDRcU8fk13RpybpBvwiMS4coWDmbV296zgy28CR85kmgG8bGZPA22AZGAeYECymXUi8sv/JuAWd3cz+wi4HngVGAFML+9gpHJt3XuIh99Yxuw1OxjQqSm/ue5skhLrhd2WiJwGJw0HM3sFuBhINLMM4HHgYjPrAziwEbgLwN1XmNlUYCVQCNzj7kXB89wLzAISgInuviJ4iYeAV83sF8AiYMJpG51UiC+3Ft5eSZE7TwzrwW2pHbW1IBJHzD02986kpKR4Wlpa2G1UOdtz8njkjWV8uDqb1E5N+e31venQrG7YbYlIKZnZAndPOdly+oS0lIq7M33xVh6fsYL8wiIeu7o7d5ynYwsi8UrhICe1c38+P3lzGbNWbKdvh8Y8dUNvOjfX5xZE4pnCQU7o3WVZ/OSt5ezPK+ThK87kTp2eKlIlKBzkmPYeLOCx6ZG7s/Vq24inbuzNGbr0hUiVoXCQo3ywajsPv7GMPQcK+MHlkbuz6X4LIlWLwkG+lJN3mCf+vpLXF2RwZqsGupezSBWmcBAAZq/ZwUPTlpKdm8+9l3TlvsuSdS9nkSpM4VDF7c8v5L9nruLluZvp0rwe0757Hn3aNw67LREJmcKhCpuzfhcPvr6EjD2HuHNQJx4Y3I3aNRLCbktEooDCoQo6VFDEb2at5vnPNtKxWV2m3nUu/ZOaht2WiEQRhUMVs2DTHn74tyVs2HmAEed25KErzqRuTX0biMhX6bdCFZF3uIhn3l/D+Nnrad2oDi+PSeW8rolhtyUiUUrhUAUsy9jHD6YuZm32fm4e0J4fX3kWDWrXCLstEYliCoc4VlBYzB8/XMufPl5HYv2aPD+yP5d0axF2WyISAxQOcWpVVg4PTF3CyqwcvnVOWx6/ugeN6mprQURKR+EQZwqLivnLv9bxfx+spVGdGoy7vR+De7QKuy0RiTEKhzhRXOzM3bCbX727iiUZ+7jq7NY8OawnTevVDLs1EYlBCocYt3HnAd5YmMEbizLJ2HOIJnVr8Mdb+nL12W3Cbk1EYpjCIQbl5B3mnaVZTFuQQdqmPZjBBV0T+eHgbgzp0Yo6NfUpZxE5NQqHGFFU7HyydgfTFmbyzxXbyC8spkvzevxoaDe+2bctrRvVCbtFEYkjCocot2Z7LtMWZPDmokyyc/NpVKcGN6a057p+7ejdrhFmuiubiJx+CocotPtAATMWZzJtYSbLMvdRvZpxcbfmXHdOOy49qwW1qmu3kYhULIVDlCgoLOajL7KZtiCDj77I5nCR0711Q356dXeG9WlDYv1aYbcoIlWIwiFE7s7yzBymLcxgxpKt7D5QQGL9Wow4N4nr+rXjrNYNw25RRKoohUMIsnPyeHNRJtMWZrBm+35qJlTj8u4tua5fWy5Mbk513a9ZREKmcKgkeYeL+OfK7UxbkMEna3dQ7NC3Q2N+cW1Prjm7jS5tISJRReFQgYqKnYWb9/DGwkzeXrqV3LxC2jSqzXcv7sK3zmlHl+b1w25RROSYFA6nkbuzcddBPl27g0/Td/LvdbvIySukTo0ErujZiuv6tePczs2oVk2nn4pIdFM4nKKd+/P5LH1n8NhF5t5DALRtXIcre7Xm/K6JXHJmC+rX0n+1iMQO/cYqo4MFhczbsJvP0nfyafouVmXlANCoTg3O69KM717chUHJiXRoWlcfUBORmKVwOInComKWZe4LwmAnCzftpaD32FKrAAAHv0lEQVSomJoJ1UhJasKDQ7oxKDmRHm0akaDdRSISJxQOX+PubNh54Msw+HzdLnLzCgHo0aYhI89P4vyuifRPaqoL3IlI3DppOJjZROBqINvdewa1psBrQBKwEbjR3fdYZD/K/wFXAgeBO9x9YbDOCODR4Gl/4e6Tg3o/YBJQB5gJ3O/ufprGVyo7cvP5fN1OPl0bOXawdV8eEDlucFVw3OC8Ls1opk8pi0gVUZoth0nAH4EpJWoPAx+4+6/M7OHg64eAK4Dk4JEKPAukBmHyOJACOLDAzGa4+55gmTuBuUTCYSjw7qkP7fiOHDf4dG1k62D1tlzgP8cN7rk0kQu66riBiFRdJw0Hd59tZklfKw8DLg6mJwMfEwmHYcCU4C//OWbW2MxaB8u+5+67AczsPWComX0MNHT3OUF9CnAtFRgOoyfNZ/baHRwu8i+PG/xoaDcu6KrjBiIiR5T3mENLd88KprcBLYPptsCWEstlBLUT1TOOUT8mMxsLjAXo0KFDuRrv2Kweo1rU54LkRFI66riBiMixnPIBaXd3M6uUYwTuPg4YB5CSklKu13zsmu6ntScRkXhU3iu8bQ92FxH8mx3UM4H2JZZrF9ROVG93jLqIiISovOEwAxgRTI8AppeoD7eIgcC+YPfTLGCwmTUxsybAYGBWMC/HzAYGZzoNL/FcIiISktKcyvoKkQPKiWaWQeSso18BU81sNLAJuDFYfCaR01jTiZzKOhLA3Xeb2ZPA/GC5J44cnAbu5j+nsr5LBZ+pJCIiJ2eV/JGC0yYlJcXT0tLCbkNEJKaY2QJ3TznZcrqrjIiIHEXhICIiR1E4iIjIURQOIiJylJg9IG1mO4icKXVEIrAzpHYqWjyPDeJ7fBpb7IrX8XV09+YnWyhmw+HrzCytNEfgY1E8jw3ie3waW+yK9/GdjHYriYjIURQOIiJylHgKh3FhN1CB4nlsEN/j09hiV7yP74Ti5piDiIicPvG05SAiIqdJ1IaDmU00s2wzW16i1tvM/m1my8zs72bWMKgnmdkhM1scPP5SYp1+wfLpZvZ7i5L7fpZlfMG8s4N5K4L5tYN61I2vjO/drSXet8VmVmxmfYJ5sT62GmY2OaivMrNHSqwz1My+CMb2cBhjOZYyjq+mmT0f1JeY2cUl1onG9669mX1kZiuDn6P7g3pTM3vPzNYG/zYJ6hb0nm5mS83snBLPNSJYfq2ZjTjea8Y0d4/KB3AhcA6wvERtPnBRMD0KeDKYTiq53NeeZx4wEDAiV3y9IuyxlWN81YGlQO/g62ZAQrSOryxj+9p6vYB10fzelfF9uwV4NZiuC2wMvlcTgHVAZ6AmsAToHvbYyjG+e4Dng+kWwAKgWhS/d62Bc4LpBsAaoDvwG+DhoP4w8Otg+sqgdwvGMjeoNwXWB/82CaabhD2+0/2I2i0Hd58N7P5a+QxgdjD9HnDdiZ7DIjciaujuczzyrh65R3Xoyji+wcBSd18SrLvL3YuidXyn8N7dDLwK0fvelXFsDtQzs+pELklfAOQAA4B0d1/v7gVExjysonsvjTKOrzvwYbBeNrAXSIni9y7L3RcG07nAKiK3JR4GTA4Wm8x/eh0GTPGIOUDjYGxDgPfcfbe77yHyfzK0EodSKaI2HI5jBf/5IbqBr95drpOZLTKzf5nZoKBWpntUR4Hjje8MwM1slpktNLMfBfVYGt+J3rsjvg28EkzHw9heBw4AWcBm4HceuY/J8e6pHq2ON74lwDfMrLqZdQL6BfOi/r0zsySgLzAXaOmRG48BbANaBtPHe59i7f0rl1gLh1HA3Wa2gMhmYUFQzwI6uHtf4AfAyyX318eQ442vOnABcGvw7zfN7LJwWiy3440NADNLBQ66+/JjrRzljje2AUAR0AboBDxgZp3DafGUHG98E4n8YkwD/hf4nMh4o5qZ1QemAd9z95yS84ItHZ3CSSnuBBdN3H01kV0smNkZwFVBPR/ID6YXmNk6In9tx9Q9qo83PiI/gLPdfWcwbyaR/cIvEiPjO8HYjriJ/2w1QAy9dycY2y3AP9z9MJBtZp8BKUT+6jzWPdWj0gl+7gqB7x9Zzsw+J7Iffw9R+t6ZWQ0iwfCSu78RlLebWWt3zwp2G2UH9UyO/T5lErk7Zsn6xxXZdxhiasvBzFoE/1YDHgX+Enzd3MwSgunOQDKw3mPsHtXHGx+Re3D3MrO6wf7ri4CVsTS+E4ztSO1GguMNENk/TOyPbTNwaTCvHpGDmquJHOBNNrNOZlaTSDDOqOy+S+sEP3d1g3FhZpcDhe4etd+XQS8TgFXu/nSJWTOAI2ccjeA/vc4AhgdnLQ0E9gVjmwUMNrMmwZlNg4NafAn7iPjxHkT+iswCDhP5y3k0cD+Rv0zWELmP9ZEP8V1HZL/oYmAhcE2J50kBlhM5O+SPR9YJ+1GW8QXL3xaMcTnwm2geXznGdjEw5xjPE9NjA+oDfwvet5XAgyWe58pg+XXAT8IeVznHlwR8QeTA7vtErvYZze/dBUR2GS0NflcsDt6HZsAHwNpgHE2D5Q34UzCGZUBKiecaBaQHj5Fhj60iHvqEtIiIHCWmdiuJiEjlUDiIiMhRFA4iInIUhYOIiBxF4SAiIkdROIiIyFEUDiIichSFg4iIHOX/A8lER1Jzt5u3AAAAAElFTkSuQmCC%0A)

### Select and transform data, then plot it[¶](#Select-and-transform-data,-then-plot-it) {#Select-and-transform-data,-then-plot-it}

-   By default, DataFrame.plot plots with the rows as the X axis.
-   We can transpose the data in order to plot multiple series.

In [65]:

    data.T.plot()
    plt.ylabel('GDP per capita')

Out[65]:

    Text(0,0.5,'GDP per capita')

![](data:image/png;base64,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%0A)

Many styles of plot are available.[¶](#Many-styles-of-plot-are-available.) {#Many-styles-of-plot-are-available.}
--------------------------------------------------------------------------

-   For example, do a bar plot using a fancier style.

In [66]:

    plt.style.use('ggplot')
    data.T.plot(kind='bar')
    plt.ylabel('GDP per capita')

Out[66]:

    Text(0,0.5,'GDP per capita')

![](data:image/png;base64,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6dGjB4sWLWLq1KmsW7fOMskPMHr0aMaPH49er2fgwIFWTYSPHj2a0aNH4+/vz9atW2vdJjo6GoPBQHBwsE3HJoS4schVZE3wKrLGzHN2dmbWrFn06NGDUaNGOSRPriKTPMmzX15jXkUmp8hENYMHD+bIkSNER0c3dleEEM2cnCIT1Xz99dcOPToTQrRccgQjhBDCLqTACCGEsAspMEIIIexCCowQQgi7kEn+BtR2iV/Fn9if0/pPrNpu165dTJgwgT179nDbbbddc86uXbsICgqyPEbaWh999BEZGRksXLiQTZs24eHhwcMPP3zN+UIIIUcwTVRiYiJ33303iYmJ1/X5Xbt2kZWVVet71l4lNnbsWCkuQojrJgWmCSosLCQtLY033njDskRMamoqY8eOtWzzyiuvsHnzZgAWLVpEREQEer2ef/7zn6SlpfH111+zYMECBg8ezOnTp4mJiWHOnDk88MADbNiwga+++orhw4dz33338eijj3LhwoUa/Vi6dCnr1q0D4P3332fo0KHo9XomTZokDy0TQjRITpE1QV9++SURERGW57YcPHiwzm2NRiNffPEFKSkpqFQqcnNzad26NYMHD672rBiAy5cv88UXXwBw6dIlPv30U1QqFR988AFr1qxh7ty5deY88MADjB49GoDXXnuNDz/8kCeffNJGIxZCtERSYJqgxMREJk6cCMBDDz3E9u3b61w239vbGzc3N1544QX0ej16vb7O/Y4Y8f/mk86dO8czzzxDTk4OZWVlBAYG1tunY8eO8frrr1sefz1gwIDrGJkQ4kYiBaaJMZlM7N27l6NHj6JSqaioqECtVjN48GCuXDautLQUqFzLa+fOnXz33Xfs3LmTjRs38vHHH9e67yvX8/rHP/7B5MmTue+++yxPwKzPjBkzSEhIoHv37mzevJnvv//eBqMVQrRkMgfTxOzcudPyULEff/yR9PR0AgMDMZvNZGVlUVpaSm5uLt999x1QOV+Tn5/PoEGDmDdvHocPHwYql+UvLCysMycvL4+AgACAOgvSlQoKCvD39+fy5cts377dBiMVQrR0cgTTgNouK7bn6saJiYn87W9/q9Y2bNgwduzYwYMPPkhkZCSBgYH06NEDqPyH/8knn6S0tBRFUSzzKA899BAzZ84kISGBt956q0bOCy+8wFNPPUXr1q0JDw+v84mXVWbO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%0A)

### Data can also be plotted by calling the matplotlib plot function directly.[¶](#Data-can-also-be-plotted-by-calling-the-matplotlib-plot-function-directly.) {#Data-can-also-be-plotted-by-calling-the-matplotlib-plot-function-directly.}

-   The command is plt.plot(x, y)
-   The color / format of markers can also be specified as an optical
    argument: e.g. ‘b-‘ is a blue line, ‘g–’ is a green dashed line.

Get Australia data from dataframe

In [67]:

    years = data.columns
    gdp_australia = data.loc['Australia']

    plt.plot(years, gdp_australia, 'g--')

Out[67]:

    [<matplotlib.lines.Line2D at 0x7fdc5fece550>]

![](data:image/png;base64,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%0A)

Can plot many sets of data together.

In [68]:

    # Select two countries' worth of data.
    gdp_australia = data.loc['Australia']
    gdp_nz = data.loc['New Zealand']

    # Plot with differently-colored markers.
    plt.plot(years, gdp_australia, 'b-', label='Australia')
    plt.plot(years, gdp_nz, 'g-', label='New Zealand')

    # Create legend.
    plt.legend(loc='upper left')
    plt.xlabel('Year')
    plt.ylabel('GDP per capita ($)')

Out[68]:

    Text(0,0.5,'GDP per capita ($)')

![](data:image/png;base64,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%0A)

### Add a legend[¶](#Add-a-legend) {#Add-a-legend}

Often when plotting multiple datasets on the same figure it is desirable
to have a legend describing the data.

This can be done in matplotlib in two stages:

-   Provide a label for each dataset in the figure:

In [69]:

    plt.plot(years, gdp_australia, label='Australia')
    plt.plot(years, gdp_nz, label='New Zealand')

Out[69]:

    [<matplotlib.lines.Line2D at 0x7fdc5ff24b70>]

![](data:image/png;base64,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%0A)

-   Instruct matplotlib to create the legend.

In [70]:

    plt.legend()

    No handles with labels found to put in legend.

Out[70]:

    <matplotlib.legend.Legend at 0x7fdc5fde26d8>

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAXwAAAD8CAYAAAB0IB+mAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEgAACxIB0t1+/AAAADl0RVh0U29mdHdhcmUAbWF0cGxvdGxpYiB2ZXJzaW9uIDIuMS4yLCBodHRwOi8vbWF0cGxvdGxpYi5vcmcvNQv5yAAAEj9JREFUeJzt3H9oVfUfx/HX3a5pa7q89+rWyIou+kcJml1EF4nDi/0RlQj6R2h/jIhapRY1c2kuangJf0RmJDVGUsGIKKLI4DrC2hBmukqF3JyRYzfGvTdzbF3bPOf7x9fuaamd6929u7bP8/Hf8X628/adPZln83ps27YFAJjwigo9AABgfBB8ADAEwQcAQxB8ADAEwQcAQxB8ADCE1+3AW2+9pSNHjqisrEw7duy45HXbttXc3KyjR49q8uTJqq2t1e23356XYQEA2XP9Cn/p0qWqr6+/4utHjx7Vr7/+qjfeeEOPPfaY3n333ZwOCADIDdfg33HHHSotLb3i64cPH9aSJUvk8Xg0Z84cDQ4O6rfffsvpkACAsXN9pOMmmUwqEAikr/1+v5LJpKZPn37J2Wg0qmg0KkmKRCJjvTUA4CqMOfhXIxwOKxwOp6/7+vrG8/bXrEAgoHg8XugxrgnswsEuHOzCUVlZmfXHjvmndHw+36j/EIlEQj6fb6yfFgCQY2MOfigU0sGDB2Xbtk6ePKmSkpLLPs4BABSW6yOd119/XSdOnNDAwIAef/xxrV69WiMjI5Kk5cuX66677tKRI0e0bt06XXfddaqtrc370ACAq+ca/A0bNvzr6x6PR48++mjOBgIAU9i2rVQqJcuy5PF4Rv16UVGRpkyZMurXx2pcv2kLAHCkUilNmjRJXu+lKR4ZGVEqldL111+fs/vx1goAUCCWZV029pLk9XplWVZO70fwAaBA3B7X5PJxjkTwAcAYBB8ADEHwAaBAbNse0+tXi+ADQIEUFRWl/13TP42MjKioKLeJ5scyAaBApkyZolQqpfPnz1/x5/BzieADQIF4PJ6c/py9Gx7pAIAhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGMKbyaHOzk41NzfLsiwtW7ZMK1asGPV6PB7Xnj17NDg4KMuy9PDDD2vBggV5GRgAkB3X4FuWpaamJm3evFl+v1+bNm1SKBTSzTffnD7z8ccfa/HixVq+fLl6e3u1bds2gg8A1xjXRzrd3d2qqKhQeXm5vF6vqqqq1NHRMeqMx+PR0NCQJGloaEjTp0/Pz7QAgKy5foWfTCbl9/vT136/X11dXaPOrFq1Sq+++qr279+v8+fPa8uWLZf9XNFoVNFoVJIUiUQUCATGMvuE4fV62cVF7MLBLhzsIjcyeobvpq2tTUuXLtUDDzygkydPavfu3dqxY4eKikb/BSIcDiscDqev4/F4Lm7/nxcIBNjFRezCwS4c7MJRWVmZ9ce6PtLx+XxKJBLp60QiIZ/PN+pMa2urFi9eLEmaM2eOhoeHNTAwkPVQAIDccw1+MBhULBZTf3+/RkZG1N7erlAoNOpMIBDQsWPHJEm9vb0aHh7WtGnT8jMxACArro90iouLVVNTo8bGRlmWperqas2aNUstLS0KBoMKhUJ65JFHtHfvXn3xxReSpNraWnk8nrwPDwDInMe2bbtQN+/r6yvUra8pPJ90sAsHu3CwC0den+EDACYGgg8AhiD4AGAIgg8AhiD4AGAIgg8AhiD4AGAIgg8AhiD4AGAIgg8AhiD4AGAIgg8AhiD4AGAIgg8AhiD4AGAIgg8AhiD4AGAIgg8AhiD4AGAIgg8AhiD4AGAIgg8AhiD4AGAIgg8AhiD4AGAIgg8AhiD4AGAIgg8AhiD4AGAIgg8AhiD4AGAIgg8AhiD4AGAIgg8AhvBmcqizs1PNzc2yLEvLli3TihUrLjnT3t6ujz76SB6PR7feeqvWr1+f82EBANlzDb5lWWpqatLmzZvl9/u1adMmhUIh3XzzzekzsVhMn376qV555RWVlpbq999/z+vQAICr5/pIp7u7WxUVFSovL5fX61VVVZU6OjpGnTlw4IDuu+8+lZaWSpLKysryMy0AIGuuX+Enk0n5/f70td/vV1dX16gzfX19kqQtW7bIsiytWrVK8+fPv+RzRaNRRaNRSVIkElEgEBjT8BOF1+tlFxexCwe7cLCL3MjoGb4by7IUi8W0detWJZNJbd26Vdu3b9cNN9ww6lw4HFY4HE5fx+PxXNz+Py8QCLCLi9iFg1042IWjsrIy6491faTj8/mUSCTS14lEQj6f75IzoVBIXq9XM2fO1E033aRYLJb1UACA3HMNfjAYVCwWU39/v0ZGRtTe3q5QKDTqzMKFC3X8+HFJ0rlz5xSLxVReXp6fiQEAWXF9pFNcXKyamho1NjbKsixVV1dr1qxZamlpUTAYVCgU0rx58/T999/rmWeeUVFRkdasWaOpU6eOx/wAgAx5bNu2C3Xzv77ZazqeTzrYhYNdONiFI6/P8AEAEwPBBwBDEHwAMATBBwBDEHwAMATBBwBDEHwAMATBBwBDEHwAMATBBwBDEHwAMATBBwBDEHwAMATBBwBDEHwAMATBBwBDEHwAMATBBwBDEHwAMATBBwBDEHwAMATBBwBDEHwAMATBBwBDEHwAMATBBwBDEHwAMATBBwBDEHwAMATBBwBDEHwAMATBBwBDEHwAMATBBwBDEHwAMERGwe/s7NT69ev19NNP69NPP73iuUOHDmn16tU6depUzgYEAOSGa/Aty1JTU5Pq6+u1a9cutbW1qbe395Jzf/zxh7788kvNnj07L4MCAMbGNfjd3d2qqKhQeXm5vF6vqqqq1NHRccm5lpYWPfTQQ5o0aVJeBgUAjI3X7UAymZTf709f+/1+dXV1jTrT09OjeDyuBQsW6LPPPrvi54pGo4pGo5KkSCSiQCCQ7dwTitfrZRcXsQsHu3Cwi9xwDb4by7K0b98+1dbWup4Nh8MKh8Pp63g8PtbbTwiBQIBdXMQuHOzCwS4clZWVWX+sa/B9Pp8SiUT6OpFIyOfzpa9TqZTOnDmjl19+WZJ09uxZvfbaa6qrq1MwGMx6MABAbrkGPxgMKhaLqb+/Xz6fT+3t7Vq3bl369ZKSEjU1NaWvGxoatHbtWmIPANcY1+AXFxerpqZGjY2NsixL1dXVmjVrllpaWhQMBhUKhcZjTgDAGHls27YLdfO+vr5C3fqawvNJB7twsAsHu3CM5Rk+/9IWAAxB8AHAEAQfAAxB8AHAEAQfAAxB8AHAEAQfAAxB8AHAEAQfAAxB8AHAEAQfAAxB8AHAEAQfAAxB8AHAEAQfAAxB8AHAEAQfAAxB8AHAEAQfAAxB8AHAEAQfAAxB8AHAEAQfAAxB8AHAEAQfAAxB8AHAEAQfAAxB8AHAEAQfAAxB8AHAEAQfAAxB8AHAEAQfAAxB8AHAEN5MDnV2dqq5uVmWZWnZsmVasWLFqNc///xzHThwQMXFxZo2bZqeeOIJzZgxIy8DAwCy4/oVvmVZampqUn19vXbt2qW2tjb19vaOOnPbbbcpEolo+/btWrRokd5///28DQwAyI5r8Lu7u1VRUaHy8nJ5vV5VVVWpo6Nj1Jm5c+dq8uTJkqTZs2crmUzmZ1oAQNZcH+kkk0n5/f70td/vV1dX1xXPt7a2av78+Zd9LRqNKhqNSpIikYgCgcDVzjsheb1ednERu3CwCwe7yI2MnuFn6uDBg+rp6VFDQ8NlXw+HwwqHw+nreDyey9v/ZwUCAXZxEbtwsAsHu3BUVlZm/bGuj3R8Pp8SiUT6OpFIyOfzXXLuhx9+0CeffKK6ujpNmjQp64EAAPnhGvxgMKhYLKb+/n6NjIyovb1doVBo1JnTp0/rnXfeUV1dncrKyvI2LAAge66PdIqLi1VTU6PGxkZZlqXq6mrNmjVLLS0tCgaDCoVCev/995VKpbRz505J///r18aNG/M+PAAgcx7btu1C3byvr69Qt76m8HzSwS4c7MLBLhx5fYYPAJgYCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhCD4AGILgA4AhvJkc6uzsVHNzsyzL0rJly7RixYpRrw8PD+vNN99UT0+Ppk6dqg0bNmjmzJl5GRgAkB3Xr/Aty1JTU5Pq6+u1a9cutbW1qbe3d9SZ1tZW3XDDDdq9e7fuv/9+ffDBB3kbGACQHdfgd3d3q6KiQuXl5fJ6vaqqqlJHR8eoM4cPH9bSpUslSYsWLdKxY8dk23ZeBgYAZMf1kU4ymZTf709f+/1+dXV1XfFMcXGxSkpKNDAwoGnTpo06F41GFY1GJUmRSESVlZVj/g1MFOzCwS4c7MLBLsZuXL9pGw6HFYlEFIlE9MILL4znra9p7MLBLhzswsEuHGPZhWvwfT6fEolE+jqRSMjn813xzIULFzQ0NKSpU6dmPRQAIPdcgx8MBhWLxdTf36+RkRG1t7crFAqNOnP33Xfr66+/liQdOnRId955pzweT14GBgBkp7ihoaHh3w4UFRWpoqJCu3fv1v79+3Xvvfdq0aJFamlpUSqVUmVlpW655RZ9++23+vDDD/Xzzz/rscceU2lpqevNb7/99lz9Pv7z2IWDXTjYhYNdOLLdhcfmx2kAwAj8S1sAMATBBwBDZPTWCmPB2zI43Hbx+eef68CBAyouLta0adP0xBNPaMaMGQWaNr/cdvGXQ4cOaefOndq2bZuCweA4Tzk+MtlFe3u7PvroI3k8Ht16661av359ASbNP7ddxONx7dmzR4ODg7IsSw8//LAWLFhQoGnz56233tKRI0dUVlamHTt2XPK6bdtqbm7W0aNHNXnyZNXW1mb2XN/OowsXLthPPfWU/euvv9rDw8P2c889Z585c2bUmf3799t79+61bdu2v/32W3vnzp35HKlgMtnFjz/+aKdSKdu2bfurr74yehe2bdtDQ0P2Sy+9ZNfX19vd3d0FmDT/MtlFX1+f/fzzz9sDAwO2bdv22bNnCzFq3mWyi7ffftv+6quvbNu27TNnzti1tbWFGDXvjh8/bp86dcp+9tlnL/v6d999Zzc2NtqWZdk//fSTvWnTpow+b14f6fC2DI5MdjF37lxNnjxZkjR79mwlk8lCjJp3mexCklpaWvTQQw9p0qRJBZhyfGSyiwMHDui+++5L/+RbWVlZIUbNu0x24fF4NDQ0JEkaGhrS9OnTCzFq3t1xxx3/+pOOhw8f1pIlS+TxeDRnzhwNDg7qt99+c/28eQ3+5d6W4Z8Ru9LbMkw0mezi71pbWzV//vzxGG3cZbKLnp4exePxCfnX9b/LZBd9fX2KxWLasmWLXnzxRXV2do73mOMik12sWrVK33zzjR5//HFt27ZNNTU14z3mNSGZTCoQCKSv3XryF75pew06ePCgenp69OCDDxZ6lIKwLEv79u3TI488UuhRrgmWZSkWi2nr1q1av3699u7dq8HBwUKPVRBtbW1aunSp3n77bW3atEm7d++WZVmFHus/I6/B520ZHJnsQpJ++OEHffLJJ6qrq5uwjzLcdpFKpXTmzBm9/PLLevLJJ9XV1aXXXntNp06dKsS4eZXp/yOhUEher1czZ87UTTfdpFgsNt6j5l0mu2htbdXixYslSXPmzNHw8PCEfCLgxufzKR6Pp6+v1JN/ymvweVsGRya7OH36tN555x3V1dVN2Oe0kvsuSkpK1NTUpD179mjPnj2aPXu26urqJuRP6WTy52LhwoU6fvy4JOncuXOKxWIqLy8vxLh5lckuAoGAjh07Jknq7e3V8PDwJe/Ka4JQKKSDBw/Ktm2dPHlSJSUlGX0/I+//0vbIkSN67733ZFmWqqurtXLlSrW0tCgYDCoUCunPP//Um2++qdOnT6u0tFQbNmyYkH+YJfddvPLKK/rll1904403Svr/H+6NGzcWeOr8cNvF3zU0NGjt2rUTMviS+y5s29a+ffvU2dmpoqIirVy5Uvfcc0+hx84Lt1309vZq7969SqVSkqQ1a9Zo3rx5BZ46915//XWdOHFCAwMDKisr0+rVqzUyMiJJWr58uWzbVlNTk77//ntdd911qq2tzej/D95aAQAMwTdtAcAQBB8ADEHwAcAQBB8ADEHwAcAQBB8ADEHwAcAQ/wM+gaFf9cHh+QAAAABJRU5ErkJggg==%0A)

By default matplotlib will attempt to place the legend in a suitable
position. If you would rather specify a position this can be done with
the loc= argument, e.g to place the legend in the upper left corner of
the plot, specify loc='upper left'

-   Plot a scatter plot correlating the GDP of Australia and New Zealand
-   Use either plt.scatter or DataFrame.plot.scatter

In [71]:

    plt.scatter(gdp_australia, gdp_nz)

Out[71]:

    <matplotlib.collections.PathCollection at 0x7fdc5fd5f6d8>

![](data:image/png;base64,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%0A)

In [72]:

    data.T.plot.scatter(x = 'Australia', y = 'New Zealand')

Out[72]:

    <matplotlib.axes._subplots.AxesSubplot at 0x7fdc5fd99860>

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAZwAAAENCAYAAAA7e9PfAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEgAACxIB0t1+/AAAADl0RVh0U29mdHdhcmUAbWF0cGxvdGxpYiB2ZXJzaW9uIDIuMS4yLCBodHRwOi8vbWF0cGxvdGxpYi5vcmcvNQv5yAAAIABJREFUeJzt3XtU1XW+//Hn5qq4EdnslKC8IFADRVC7UhzNCyc75prjMZczVpaWaQfLaTw5ardTpzQ9RZCJY0c8ZrZmungkqzmNLSTlKHlCEZqkxOtMhYqw0fZWkdv39wc/d5JiG4ovxH491motvx++l897b/Ll53v5fC2GYRiIiIh0ML/O7oCIiPgGBY6IiJhCgSMiIqZQ4IiIiCkUOCIiYgoFjoiImEKBIyIiplDgiIiIKRQ4IiJiCgWOiIiYIqCzO9DZKioq2ryN3W6nqqqqA3rT9flq7b5aN/hu7aq7dVFRUe3at0Y4IiJiCgWOiIiYQoEjIiKmUOCIiIgpFDgiImIKBY6IiJjC52+LFhHxFUdcdWQWVuA620hosD9zh0URaQ0y7fga4YiI+IjMwgr2VtVS4apnb1Utmdvb/hzij6HAERHxEa6zjS2Wv/3eckdT4IiI+IjQYP9LLnc0BY6IiI+YOyyKq+09iAoN5Cp7D+YOa98UNe2lmwZERHxEpDWIpWMHdtrxNcIRERFTKHBERMQUChwRETGFAkdEREyhwBEREVMocERExBQKHBERMYUCR0RETKHAERERU5gy00BVVRXZ2dmcOHECi8VCWloa48aN8/z8/fffZ926deTk5NC7d28Mw2DNmjXs3r2b4OBg0tPTiYmJAWDLli1s2LABgIkTJzJy5EgADh48SHZ2NnV1daSkpDB9+nQsFosZ5YmIiBdMCRx/f3+mTp1KTEwMZ86cYcGCBSQlJXHFFVdQVVXFZ599ht1u96y/e/dujh49yrJly9i3bx85OTksXrwYt9vN+vXrWbJkCQALFizA4XBgtVpZtWoVs2bNIi4ujueff56SkhJSUlLMKE9ERLxgyim18PBwzwilZ8+eREdH43Q6AVi7di133XVXi9HIzp07GTFiBBaLhfj4eE6dOkVNTQ0lJSUkJSVhtVqxWq0kJSVRUlJCTU0NZ86cIT4+HovFwogRIygqKjKjNBER8ZLpk3dWVlZy6NAhYmNjKSoqwmazMXDgwBbrOJ3OFiOeiIgInE4nTqeTiIgIT7vNZrto+7n1LyYvL4+8vDwAlixZ0uI43goICGjXdt2Br9buq3WD79auujtg3x2y11bU1taSkZHBtGnT8Pf3Jzc3lyeeeMLMLpCWlkZaWppnuaqqqs37sNvt7dquO/DV2n21bvDd2lV366Ki2vdaA9PuUmtoaCAjI4Phw4dz8803c+zYMSorK5k3bx6zZ8+murqa+fPnc+LECWw2W4uCq6ursdls2Gw2qqurPe1Op/Oi7efWFxGRrsOUwDEMg5UrVxIdHc348eMB6N+/Pzk5OWRnZ5OdnU1ERARLly6lT58+OBwOCgoKMAyD8vJyQkJCCA8PJzk5mdLSUtxuN263m9LSUpKTkwkPD6dnz56Ul5djGAYFBQU4HA4zShMRES+Zckpt7969FBQU0L9/f+bNmwfAlClTuP766y+6fkpKCsXFxcyZM4egoCDS09MBsFqt3HHHHSxcuBCASZMmYbVaAZgxYwYrVqygrq6O5ORk3aEmItLFWAzDMDq7E52poqKizdv46rld8N3afbVu8N3aVXfruvw1HBER8W0KHBERMYUCR0RETGH6g58iIj93R1x1ZBZW4DrbSGiwP3OHRRFpDersbnV5GuGIiLRRZmEFe6tqqXDVs7eqlsztbb/5yBcpcERE2sh1trHF8rffW5aLU+CIiLRRaLD/JZfl4hQ4IiJtNHdYFFfbexAVGshV9h7MHda+51J8jW4aEBFpo0hrEEvHDuzsbvzsaIQjIiKmUOCIiIgpFDgiImIKBY6IiJhCgSMiIqZQ4IiIiCkUOCIiYgoFjoiImEKBIyIipjBlpoGqqiqys7M5ceIEFouFtLQ0xo0bx7p169i1axcBAQH069eP9PR0evXqBUBubi75+fn4+fkxffp0kpOTASgpKWHNmjU0NTUxZswYJkyYAEBlZSVZWVm4XC5iYmJ4+OGHCQjQRAoiIl2FKSMcf39/pk6dSmZmJosWLWLTpk18/fXXJCUlkZGRwYsvvsjll19Obm4uAF9//TWFhYW89NJLPP7446xevZqmpiaamppYvXo1jz32GJmZmWzfvp2vv/4agDfeeIPbb7+dV155hV69epGfn29GaSIi4iVTAic8PJyYmBgAevbsSXR0NE6nk+uuuw5//+ZZVuPj43E6nQAUFRWRmppKYGAgffv2JTIykv3797N//34iIyPp168fAQEBpKamUlRUhGEY7NmzhyFDhgAwcuRIioqKzChNRES8ZPo5p8rKSg4dOkRsbGyL9vz8fFJTUwFwOp3ExcV5fmaz2TxhFBER4WmPiIhg3759uFwuQkJCPOF1/vrfl5eXR15eHgBLlizBbre3uYaAgIB2bdcd+Grtvlo3+G7tqrsD9t0he21FbW0tGRkZTJs2jZCQEE/7hg0b8Pf3Z/jw4R3eh7S0NNLS0jzLVVVVbd6H3W5v13bdga/W7qt1g+/WrrpbFxXVvtcxmHaXWkNDAxkZGQwfPpybb77Z075lyxZ27drFnDlzsFgsQPMIpbq62rOO0+nEZrNd0F5dXY3NZiM0NJTTp0/T2NjYYn0REek6TAkcwzBYuXIl0dHRjB8/3tNeUlLCxo0bmT9/PsHBwZ52h8NBYWEh9fX1VFZWcuTIEWJjYxk8eDBHjhyhsrKShoYGCgsLcTgcWCwWEhMT2bFjB9AcYg6Hw4zSRETES6acUtu7dy8FBQX079+fefPmATBlyhTWrFlDQ0MDzz77LABxcXHMnDmTK6+8kqFDhzJ37lz8/Py4//778fNrzsb77ruPRYsW0dTUxKhRo7jyyisBuOuuu8jKyuLNN99k0KBBjB492ozSRETESxbDMIzO7kRnqqioaPM2vnpuF3y3dl+tG3y3dtXdui5/DUdERHybAkdEREyhwBEREVMocERExBQKHBERMYWmUxaRTnHEVUdmYQWus42EBvszd1gUkdagzu6WdCCNcESkU2QWVrC3qpYKVz17q2rJ3N72RxTk50WBIyKdwnW2scXyt99blu5HgSMinSI02P+Sy9L9KHBEpFPMHRbF1fYeRIUGcpW9B3OHte/pdfn50E0DItIpIq1BLB07sLO7ISbSCEdEREzR6ginqanJqx2cm8VZRETkUloNnClTpni1g7feeusn64yIiHRfrQbO8uXLPX8uLi5mx44d/PM//7Nn6uqNGze2eHOniIjIpbQaOJdddpnnzx988AFLliyhV69eQPO7EGJiYli4cCG33nprx/dSRER+9ry6AHP69GnOnj3boq2uro7Tp093SKdERKT78eq26FtuuYVnn32W22+/nYiICKqrq/nwww+55ZZbOrp/IiLSTXgVOHfffTeRkZEUFhZSU1NDnz59GDt2LGlpaV4dpKqqiuzsbE6cOIHFYiEtLY1x48bhdrvJzMzk+PHjXHbZZfzud7/DarViGAZr1qxh9+7dBAcHk56eTkxMDABbtmxhw4YNAEycOJGRI0cCcPDgQbKzs6mrqyMlJYXp06djsVja8ZGIiEhH8Cpw/Pz8uPXWW9t9vcbf35+pU6cSExPDmTNnWLBgAUlJSWzZsoVrr72WCRMm8O677/Luu+9y9913s3v3bo4ePcqyZcvYt28fOTk5LF68GLfbzfr161myZAkACxYswOFwYLVaWbVqFbNmzSIuLo7nn3+ekpISUlJS2tVfERH56Xk900BpaSmHDx+mtra2Rfuvf/3rH9w2PDyc8PBwAHr27El0dDROp5OioiKefvppoPm03dNPP83dd9/Nzp07GTFiBBaLhfj4eE6dOkVNTQ179uwhKSkJq9UKQFJSEiUlJSQmJnLmzBni4+MBGDFiBEVFRQocEZEuxKvAWb16NZ988gmJiYkEBwf/qANWVlZy6NAhYmNjOXnypCeI+vTpw8mTJwFwOp3Y7XbPNhERETidTpxOJxEREZ52m8120fZz619MXl4eeXl5ACxZsqTFcbwVEBDQru26A1+t3VfrBt+tXXV3wL69WWnbtm288MILP7oTtbW1ZGRkMG3aNEJCQlr8zGKxmHLNJS0trcW1p6qqqjbv49yzSL7IV2v31brBd2tX3a2LimrfRKte3Rbdu3dvzzM47dXQ0EBGRgbDhw/3PDAaFhZGTU0NADU1NfTu3RtoHrmcX3B1dTU2mw2bzUZ1dbWn3el0XrT93PoiItJ1eBU448ePZ9myZZSXl3Ps2LEW/3nDMAxWrlxJdHQ048eP97Q7HA62bt0KwNatW7nxxhs97QUFBRiGQXl5OSEhIYSHh5OcnExpaSlutxu3201paSnJycmEh4fTs2dPysvLMQyDgoICHA5HWz8LERHpQF6dUsvJyQGap7j5Pm/mUtu7dy8FBQX079+fefPmAc1ztU2YMIHMzEzy8/M9t0UDpKSkUFxczJw5cwgKCiI9PR0Aq9XKHXfcwcKFCwGYNGmS5waCGTNmsGLFCurq6khOTtYNAyIiXYzFMAyjszvRmSoq2v4edV89twu+W7uv1g2+W7vqbl2HXsMRERH5sbw6pdbY2MimTZsoKyvD5XK1+NkzzzzTIR0TEZHuxasRztq1a8nLyyMhIYGDBw9y8803c/LkSRITEzu6fyIi0k14FTj/93//x2OPPca4cePw9/dn3LhxzJs3jz179nR0/0REpJvwKnDq6uo8T/IHBQVx9uxZoqOjOXz4cEf2TUREuhGvruFER0dz4MABYmNjiYmJ4Z133qFnz556uFJERLzmVeBMmzYNP7/mwdC9995LTk4OZ86cYebMmR3aOZHu7oirjszCClxnGwkN9mfusCgirUGd3S2RDuFV4MTGxnr+fPnll/Pkk092WIdEfElmYQV7q/7/DOyuejK3V7B07MBO7ZNIR2k1cD7//HOvdnDNNdf8ZJ0R8TWus40tlr/93rJId9Jq4PzhD3/4wY0tFgvLly//STsk4ktCg/3BVd9yWaSbajVwsrOzzeyHiE+aOyyKzO0VfHveNRyR7srrN36KyE8v0hqkazbiM7wKnNOnT/POO+94prY5f75Pb069iYiIePXgZ05ODocOHWLSpEm43W7uu+8+7HY7t99+e0f3T0REugmvRjifffYZmZmZhIaG4ufnx4033sjgwYNZunRpixeqiUjn0TM90tV5NcIxDIOQkBAAevTowenTp+nTpw9Hjx7t0M6JiPfOPdNT4apnb1Utmdvb/q4nkY7k1QhnwIABlJWVce2113L11VeTk5NDjx49uPzyyzu6fyLiJT3TI12dVyOcWbNmcdlllwEwffp0goKCOHXqFA899FCHdk5EvPf9Z3j0TI90NV6NcPr16+f5c1hYGA8++GCbDrJixQqKi4sJCwsjIyMDgMOHD7Nq1Srq6urw9/dnxowZxMbGYhgGa9asYffu3QQHB5Oenk5MTAwAW7ZsYcOGDQBMnDiRkSNHAnDw4EGys7Opq6sjJSWF6dOnY7FY2tRHkZ87PdMjXZ1XgWMYBps3b2b79u24XC5efPFFysrKOHHiBKmpqT+4/ciRI7nttttaPEz6xhtvMGnSJFJSUiguLuaNN97g6aefZvfu3Rw9epRly5axb98+cnJyWLx4MW63m/Xr17NkyRIAFixYgMPhwGq1smrVKmbNmkVcXBzPP/88JSUlpKSktPMjEfl50jM90tV5dUrtrbfe4uOPPyYtLY2qqioAIiIi2Lhxo1cHSUhIwGq1tmizWCycOXMGaH7OJzw8HICdO3cyYsQILBYL8fHxnDp1ipqaGkpKSkhKSsJqtWK1WklKSqKkpISamhrOnDlDfHw8FouFESNGUFRU5PUHICIi5vBqhLN161aWLl1K7969ycnJAaBv375UVla2+8D33nsvixYtYt26dTQ1NfHcc88B4HQ6sdvtnvUiIiJwOp04nU7PS+AAbDbbRdvPrd+avLw88vLyAFiyZEmLY3krICCgXdt1B75au6/WDb5bu+rugH17s1JTUxM9evRo0VZbW3tBW1t89NFH3HvvvQwZMoTCwkJWrlxpymsP0tLSSEtL8yyfG7G1hd1ub9d23YGv1u6rdYPv1q66WxcV1b7rg16dUktJSeH111+nvr55VlvDMHjrrbe44YYb2nVQaB413XzzzQAMHTqU/fv3A80jl/OLra6uxmazYbPZqK6u9rQ7nc6Ltp9bX0REuhavAueee+6hpqaGadOmcfr0ae655x6OHz/OnXfe2e4D22w2ysrKgOZ370RGRgLgcDgoKCjAMAzKy8sJCQkhPDyc5ORkSktLcbvduN1uSktLSU5OJjw8nJ49e1JeXo5hGBQUFOBwONrdL/FNR1x1/H7TYf7lvQP8ftNhjrrrOrtLIt2OxTh/Js4fcPLkSY4fP47dbqdPnz5eHyQrK8sz8WdYWBiTJ08mKiqKNWvW0NTURGBgIDNmzCAmJgbDMFi9ejWlpaUEBQWRnp7O4MGDAcjPzyc3Nxdovi161KhRABw4cIAVK1ZQV1dHcnIy9913n9e3RVdUtP1pbF8dakP3rf33mw5/9+ZN4Gp7jxZ3fHXXur3hq7Wr7ta195TaJQPnv//7vxkzZkyr4ZKTk8OMGTPadeCuQoHTNt219n957wAV570ILSo0kD/8arBnubvW7Q1frV11t65DruG8/fbbzJ8/ny+++OKiP//f//3fdh1UpKvRU/oiHe+SgRMcHMyvf/1rnn/+ed57770Lft6Gs3EiXdrcYVFcbe9BVGggV9l76Cl9kQ5wyduiLRYLo0ePZtCgQbz00kuUl5eTnp7umTla08dId6Gn9EU6nld3qQ0aNIilS5fS2NjIggUL+Nvf/tbR/RIRkW7Gq8ABCAkJYf78+YwePZqnnnqKjz/+uCP7JSIi3cwlT6ld7BrNhAkTiIuL4+WXX6a2tvYiW4mIiFzokoEzc+bMi7YnJiaydOlSNm/e3CGdEhGR7ueSp9R++ctftvqz8PBwJk2a9JN3SEREuievr+GIiIj8GAocERExhQJHRERM4VXg/M///A+HDx/u4K6IiEh35tUL2A4ePMgHH3zAmTNn+MUvfkFCQgIJCQkMGjRIsw2IiIhXvAqchx56CIDKykrKysooKytj/fr1ALz22msd1jkREek+vAocaJ7Gv6ysjD179rB3714uv/xyEhISOrJvIiLSjXgVOA888AA9evRgyJAh3HLLLcycOZOePXt2dN9ERKQb8SpwbrjhBr788kuKioo4deoUbrebhIQEbDZbR/dPxGtHXHVkFlbgOttIaLA/c4dFEWkN6uxuicj/51XgPPjggwCcOHGCL774grKyMnJycggNDeWVV17p0A6KeCuzsOK710S76sncXqFXDoh0IV5fwzl06JDnGs4XX3xBcHAwsbGxXm27YsUKiouLCQsLIyMjw9P+4YcfsmnTJvz8/Lj++uu5++67AcjNzSU/Px8/Pz+mT59OcnIyACUlJaxZs4ampibGjBnDhAkTgOabGbKysnC5XMTExPDwww8TEOB1adJNuM42tlj+9nvLItK5vPpbefr06YSEhPCLX/wCh8PBPffcQ2RkpNcHGTlyJLfddhvZ2dmets8//5ydO3fywgsvEBgYyMmTJwH4+uuvKSws5KWXXqKmpoZnn32Wl19+GYDVq1fzxBNPEBERwcKFC3E4HFxxxRW88cYb3H777QwbNoz//M//JD8/n1tvvbUtn4N0kp/yNFhosD+46lsui0iX4VXgLF26lL59+7b7IAkJCVRWVrZo++ijj/inf/onAgMDAQgLCwOgqKiI1NRUAgMD6du3L5GRkezfvx+AyMhI+vXrB0BqaipFRUVER0ezZ88efvvb3wLN4fbOO+8ocH4mfsrTYHOHRZG5vYJvzwsvEek6vAqcvn378s033/DJJ59w8uRJ7r//fr755hsaGhoYMGBAuw585MgRvvzyS958800CAwOZOnUqsbGxOJ1O4uLiPOvZbDacTicAERERnvaIiAj27duHy+UiJCQEf3//C9a/mLy8PPLy8gBYsmQJdru9zX0PCAho13bdwU9d+6mGwy2W3Q20e/92O6we2DEho+/c92pX3R2wb29W+uSTT8jJyeHmm29m+/bt3H///dTW1vLHP/6RJ598sl0Hbmpqwu12s2jRIg4cOEBmZibLly9v177aIi0tjbS0NM9yVVVVm/dht9vbtV138FPX3ivgwuWu+NnqO/e92lV366Ki2vcP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%0A)

### Exercises[¶](#Exercises) {#Exercises}

Fill in the blanks below to plot the minimum GDP per capita over time
for all the countries in Europe. Modify it again to plot the maximum GDP
per capita over time for Europe.

In [73]:

    data_europe = pd.read_csv('/home/mcubero/dataSanJose19/data/gapminder_gdp_europe.csv', index_col='country')
    data_europe.____.plot(label='min')
    data_europe.____
    plt.legend(loc='best')
    plt.xticks(rotation=90)

    ---------------------------------------------------------------------------
    AttributeError                            Traceback (most recent call last)
    <ipython-input-73-e4db3abbc459> in <module>()
          1 data_europe = pd.read_csv('/home/mcubero/dataSanJose19/data/gapminder_gdp_europe.csv', index_col='country')
    ----> 2 data_europe.____.plot(label='min')
          3 data_europe.____
          4 plt.legend(loc='best')
          5 plt.xticks(rotation=90)

    /usr/local/lib/python3.6/site-packages/pandas/core/generic.py in __getattr__(self, name)
       3612             if name in self._info_axis:
       3613                 return self[name]
    -> 3614             return object.__getattribute__(self, name)
       3615 
       3616     def __setattr__(self, name, value):

    AttributeError: 'DataFrame' object has no attribute '____'

Modify the example in the notes to create a scatter plot showing the
relationship between the minimum and maximum GDP per capita among the
countries in Asia for each year in the data set. What relationship do
you see (if any)?

In [0]:

    data_asia = pd.read_csv('/home/mcubero/dataSanJose19/data/gapminder_gdp_asia.csv', index_col='country')
    data_asia.describe().T.plot(kind='scatter', x='min', y='max')

You might note that the variability in the maximum is much higher than
that of the minimum. Take a look at the maximum and the max indexes:

In [0]:

    data_asia = pd.read_csv('/home/mcubero/dataSanJose19/data/gapminder_gdp_asia.csv', index_col='country')
    data_asia.max().plot()
    print(data_asia.idxmax())
    print(data_asia.idxmin())

### Saving your plot to a file[¶](#Saving-your-plot-to-a-file) {#Saving-your-plot-to-a-file}

If you are satisfied with the plot you see you may want to save it to a
file, perhaps to include it in a publication. There is a function in the
matplotlib.pyplot module that accomplishes this: savefig. Calling this
function, e.g. with

In [0]:

    plt.savefig('my_figure.png')

will save the current figure to the file my\_figure.png. The file format
will automatically be deduced from the file name extension (other
formats are pdf, ps, eps and svg).

Note that functions in plt refer to a global figure variable and after a
figure has been displayed to the screen (e.g. with plt.show) matplotlib
will make this variable refer to a new empty figure. Therefore, make
sure you call plt.savefig before the plot is displayed to the screen,
otherwise you may find a file with an empty plot.

When using dataframes, data is often generated and plotted to screen in
one line, and plt.savefig seems not to be a possible approach. One
possibility to save the figure to file is then to

-   save a reference to the current figure in a local variable (with
    plt.gcf)
-   call the savefig class method from that variable.

In [0]:

    fig = plt.gcf() # get current figure
    data.plot(kind='bar')
    fig.savefig('my_figure.png')

### Making your plots accessible[¶](#Making-your-plots-accessible) {#Making-your-plots-accessible}

Whenever you are generating plots to go into a paper or a presentation,
there are a few things you can do to make sure that everyone can
understand your plots.

-   Always make sure your text is large enough to read. Use the fontsize
    parameter in xlabel, ylabel, title, and legend, and tick\_params
    with labelsize to increase the text size of the numbers on your
    axes.
-   Similarly, you should make your graph elements easy to see. Use s to
    increase the size of your scatterplot markers and linewidth to
    increase the sizes of your plot lines.
-   Using color (and nothing else) to distinguish between different plot
    elements will make your plots unreadable to anyone who is
    colorblind, or who happens to have a black-and-white office printer.
    For lines, the linestyle parameter lets you use different types of
    lines. For scatterplots, marker lets you change the shape of your
    points. If you’re unsure about your colors, you can use Coblis or
    Color Oracle to simulate what your plots would look like to those
    with colorblindness.

### Key Points[¶](#Key-Points) {#Key-Points}

-   matplotlib is the most widely used scientific plotting library in
    Python.

-   Plot data directly from a Pandas dataframe.

-   Select and transform data, then plot it.

-   Many styles of plot are available: see the Python Graph Gallery for
    more options.

-   Can plot many sets of data together.

Programming Style[¶](#Programming-Style) {#Programming-Style}
========================================

15 minutes

Exercises (15 min)

#### Coding style[¶](#Coding-style) {#Coding-style}

Coding style helps us to understand the code better. It helps to
maintain and change the code. Python relies strongly on coding style, as
we may notice by the indentation we apply to lines to define different
blocks of code. Python proposes a standard style through one of its
first Python Enhancement Proposals (PEP), PEP8, and highlight the
importance of readability in the Zen of Python.

Keep in mind:

-   document your code
-   use clear, meaningful variable names
-   use white-space, not tabs, to indent lines

**Follow standard Python style in your code.**

-   [PEP8:](https://www.python.org/dev/peps/pep-0008/) a style guide for
    Python that discusses topics such as how you should name variables,
    how you should use indentation in your code, how you should
    structure your import statements, etc. Adhering to PEP8 makes it
    easier for other Python developers to read and understand your code,
    and to understand what their contributions should look like. The
    [PEP8 application and Python
    library](https://pypi.org/project/pep8/) can check your code for
    compliance with PEP8.
-   [Google style guide on
    Python](https://google.github.io/styleguide/pyguide.html) supports
    the use of PEP8 and extend the coding style to more specific
    structure of a Python code, which may be interesting also to follow.

#### Use assertions to check for internal errors.[¶](#Use-assertions-to-check-for-internal-errors.) {#Use-assertions-to-check-for-internal-errors.}

Assertions are a simple, but powerful method for making sure that the
context in which your code is executing is as you expect.

In [109]:

    def calc_bulk_density(mass, volume):
        '''Return dry bulk density = powder mass / powder volume.'''
        assert volume > 0
        return mass / volume

In [110]:

    calc_bulk_density(60, -50)

    ----------------------------------------------------------------------
    AssertionError                       Traceback (most recent call last)
    <ipython-input-110-b0873c16a0ba> in <module>()
    ----> 1 calc_bulk_density(60, -50)

    <ipython-input-109-fa5af01ee7ed> in calc_bulk_density(mass, volume)
          1 def calc_bulk_density(mass, volume):
          2     '''Return dry bulk density = powder mass / powder volume.'''
    ----> 3     assert volume > 0
          4     return mass / volume

    AssertionError: 

If the assertion is False, the Python interpreter raises an
AssertionError runtime exception. The source code for the expression
that failed will be displayed as part of the error message. To ignore
assertions in your code run the interpreter with the ‘-O’ (optimize)
switch. Assertions should contain only simple checks and never change
the state of the program. For example, an assertion should never contain
an assignment.

#### Use docstrings to provide online help.[¶](#Use-docstrings-to-provide-online-help.) {#Use-docstrings-to-provide-online-help.}

-   If the first thing in a function is a character string that is not
    assignd to a variable, Python attaches it to the function as thee
    online help.
-   Called a docstring (short fo "documentation string").

In [111]:

    def average(values):
        "Return average of values, or None if no values are supplied."

        if len(values) == 0:
            return None
        return sum(values) / len(values)

    help(average)

    Help on function average in module __main__:

    average(values)
        Return average of values, or None if no values are supplied.

Also, you can comment your code using multiline strings. These start and
end with three quote characters (either single or double) and end with
three matching characters.

In [112]:

    import this

    The Zen of Python, by Tim Peters

    Beautiful is better than ugly.
    Explicit is better than implicit.
    Simple is better than complex.
    Complex is better than complicated.
    Flat is better than nested.
    Sparse is better than dense.
    Readability counts.
    Special cases aren't special enough to break the rules.
    Although practicality beats purity.
    Errors should never pass silently.
    Unless explicitly silenced.
    In the face of ambiguity, refuse the temptation to guess.
    There should be one-- and preferably only one --obvious way to do it.
    Although that way may not be obvious at first unless you're Dutch.
    Now is better than never.
    Although never is often better than *right* now.
    If the implementation is hard to explain, it's a bad idea.
    If the implementation is easy to explain, it may be a good idea.
    Namespaces are one honking great idea -- let's do more of those!

In [77]:

    """This string spans
    multiple lines.

    Blank lines are allowed."""

Out[77]:

    'This string spans\nmultiple lines.\n\nBlank lines are allowed.'

### Exercises[¶](#Exercises) {#Exercises}

Highlight the lines in the code below that will be available as online
help. Are there lines that should be made available, but won’t be? Will
any lines produce a syntax error or a runtime error?

    "Find maximum edit distance between multiple sequences."
    # This finds the maximum distance between all sequences.

    def overall_max(sequences):
        '''Determine overall maximum edit distance.'''

        highest = 0
        for left in sequences:
            for right in sequences:
                '''Avoid checking sequence against itself.'''
                if left != right:
                    this = edit_distance(left, right)
                    highest = max(highest, this)

        # Report.
        return highest

Turn the comment on the following function into a docstring and check
that help displays it properly.

In [0]:

    def middle(a, b, c):
        # Return the middle value of three.
        # Assumes the values can actually be compared.
        values = [a, b, c]
        values.sort()
        return values[1]

Clean up this code!

1.  Read this short program and try to predict what it does.
2.  Run it: how accurate was your prediction?
3.  Refactor the program to make it more readable. Remember to run it
    after each change to ensure its behavior hasn’t changed.
4.  Compare your rewrite with your neighbor’s. What did you do the same?
    What did you do differently, and why?

<!-- -->

    n = 10
    s = 'et cetera'
    print(s)
    i = 0
    while i < n:
        # print('at', j)
        new = ''
        for j in range(len(s)):
            left = j-1
            right = (j+1)%len(s)
            if s[left]==s[right]: new += '-'
            else: new += '*'
        s=''.join(new)
        print(s)
        i += 1

### Key Points[¶](#Key-Points) {#Key-Points}

-   Follow standard Python style in your code.

-   Use docstrings to provide online help.


