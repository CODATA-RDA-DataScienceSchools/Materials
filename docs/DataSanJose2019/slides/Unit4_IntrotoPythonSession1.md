Session 1[¶](#Session-1) {#Session-1}
========================

Plotting and programming with Python 3[¶](#Plotting-and-programming-with-Python-3) {#Plotting-and-programming-with-Python-3}
----------------------------------------------------------------------------------

### Open a Jupyter Notebook[¶](#Open-a-Jupyter-Notebook) {#Open-a-Jupyter-Notebook}

(10 minutes)

[http://swcarpentry.github.io/python-novice-gapminder/01-run-quit/index.html](http://swcarpentry.github.io/python-novice-gapminder/01-run-quit/index.html)

Once you have your Notebook open let\`s start with the session.

Heo

Variables and Assignment[¶](#Variables-and-Assignment) {#Variables-and-Assignment}
======================================================

(15 min)

Exercises (10min)

Variables are names for determined values.

Note:

-   To assing the value to a variable use = like this:

    *variable = value*

-   The variable is created when a value is assingned.

For example let's type in our names and ages:

In [2]:

    age = 21
    name = 'Mariana'
    ejemplo= 5+5
    print(age, name, ejemplo)

    21 Mariana 10

In [4]:

    #1variable = 1
    variable1 = 1

### Variable names[¶](#Variable-names) {#Variable-names}

-   **Only letters, digits and underscore \_ (for long names)**

-   **Do not start with a digit**

-   It is possible to start with an underscore like `__real_age`, but
    this has a special meaning.

(We won't do that yet)

### Display values with:[¶](#Display-values-with:) {#Display-values-with:}

    print()

This built-in function prints values as text

Examples:

In [5]:

    print('My name is', name, ', I am ', age)

    My name is Mariana , I am  21

### Please remember that variables *must be created* before they are used![¶](#Please-remember-that-variables-must-be-created-before-they-are-used!) {#Please-remember-that-variables-must-be-created-before-they-are-used!}

Otherwise Python reports an error

In [8]:

    cat_name = "Salem"
    print(cat_name)

    Salem

Be aware that it is the **order of execution** of cells that is
important in a Jupyter notebook, **not the order in which they appear**.

Python will remember all the code that was run previously, including any
variables you have defined, irrespective of the order in the notebook.
Therefore if you define variables lower down the notebook and then
(re)run cells further up, those defined further down will still be
present.

### Variables can be reused[¶](#Variables-can-be-reused) {#Variables-can-be-reused}

In [9]:

    age = age + 1 
    print('Next year I will be', age)

    Next year I will be 22

Also, you can index to get a single character from a string.

-   'AB' != 'BA' -\> ordering matters, because we can treat the string
    as a list of characters.

-   Python uses zero-based indexing.

-   Use square brackets to get a character in a specific position.

<!-- -->

    atom_name = 'helium'
    print(atom_name[0])

In [11]:

    atom_name = 'helium'
    print(atom_name)
    print(atom_name[0])

    helium
    h

### Slicing to get a substring![¶](#Slicing-to-get-a-substring!) {#Slicing-to-get-a-substring!}

-   **Quick concepts**

    -   Substring:A part of a string. (1 to n number of characters)
    -   Element: An item on a list. In a string, the elements are the
        characters.
    -   Slice: part of a string (or any list-like thing)

How to slice strings:

-   **[start:stop]**, where **start** is replaced with the index of the
    **first element** we want and **stop** is replaced with the index of
    the **element just after the last element we want**.

-   Taking a slice does not change the contents of the original string.
    Instead, the slice is a copy of part of the original string.

In [13]:

    atom_name = 'sodium'
    print(atom_name[0:3])

    # Use len to find the lenght of a string
    print(len('helium'))

    sod
    6

### Final considerations:[¶](#Final-considerations:) {#Final-considerations:}

-   Python is case-sensitive upper- and lower-case letters are
    different. Name != name are different variables.

-   Use meaningful variable names

<!-- -->

    flabadab = 42
    ewr_422_yY = 'Ahmed'
    print(ewr_422_yY, 'is', flabadab, 'years old')

In [15]:

    hola = 1

    HOLA= 2
    print(hola, HOLA)

    1 2

Excercises[¶](#Excercises) {#Excercises}
--------------------------

-   What is the final value of position in the program below? (Try to
    predict the value without running the program, then check your
    prediction.)

<!-- -->

    initial = 'left'
    position = initial
    initial = 'right'

In [18]:

    initial = 'left'
    position = initial
    initial = 'right'
    print(initial, position)

    right left

-   If you assign **`a = 123`**, what happens if you try to get the
    second digit of a via **`a[1]`**?

In [19]:

    a = 123
    a[1]

    ----------------------------------------------------------------------
    TypeError                            Traceback (most recent call last)
    <ipython-input-19-d77b277d0f9d> in <module>()
          1 a = 123
    ----> 2 a[1]

    TypeError: 'int' object is not subscriptable

-   What does the following program print?

<!-- -->

    atom_name = 'carbon'
    print('atom_name[1:3] is:', atom_name[1:3])

In [20]:

    atom_name = 'carbon'
    print('atom_name[1:3] is:', atom_name[1:3])

    atom_name[1:3] is: ar

1.What does thing[low:high] do?

2.What does thing[low:] (without a value after the colon) do?

3.What does thing[:high] (without a value before the colon) do?

4.What does thing[:] (just a colon) do?

5.What does thing[number:some-negative-number] do?

6.What happens when you choose a high value which is out of range?
(i.e., try atom\_name[0:15])

KEY POINTS - Variable and Assignment[¶](#KEY-POINTS---Variable-and-Assignment) {#KEY-POINTS---Variable-and-Assignment}
==============================================================================

Use variables to store values.

Use print to display values.

Variables persist between cells.

Variables must be created before they are used.

Variables can be used in calculations.

Use an index to get a single character from a string.

Use a slice to get a substring.

Use the built-in function len to find the length of a string.

Python is case-sensitive.

Use meaningful variable names.

Data Types and Type Conversion[¶](#Data-Types-and-Type-Conversion) {#Data-Types-and-Type-Conversion}
==================================================================

(10 min)

Exercises (10min)

### Every value has a type.[¶](#Every-value-has-a-type.) {#Every-value-has-a-type.}

Existing types are:

-   Integer `(int)`: positive or negative whole numbers
-   Floating point numbers `(float)`: real numbers
-   Character string `(str)`: text
    -   Written in either single or double quotes (but they have to
        match)

Use the built-in function `type` to find out what type a value or
variable has

    print(type(variable))

In [22]:

    print(type(52))

    fitness = 'average'
    print(type(fitness))

    <class 'float'>
    <class 'str'>

### Operations or methods for a given type[¶](#Operations-or-methods-for-a-given-type) {#Operations-or-methods-for-a-given-type}

Types control what operations (or methodds) can be performed on a given
value

-   A value’s type determines what the program can do to it.

In [23]:

    #This works
    print(5 - 3)

    2

In [24]:

    #This works?
    print('hello' - 'h')

    ----------------------------------------------------------------------
    TypeError                            Traceback (most recent call last)
    <ipython-input-24-c60e4b1b64d0> in <module>()
          1 #This works?
    ----> 2 print('hello' - 'h')

    TypeError: unsupported operand type(s) for -: 'str' and 'str'

-   Operators that can be used on strings

    -   +
    -   \*

    "Adding" characters strings concatenates them.

In [26]:

     full_name = 'Ahmed'+ 'Walsh'
    print(full_name)

    AhmedWalsh

Multiplying a character string by an integer N creates a new string that
consists of that character string repeated N times.

In [27]:

    separator = '=' * 10
    print(separator)

    ==========

-   **Try function len on strings and numbers**

In [28]:

    #Text
    print(len(full_name))

    10

In [29]:

    #Number
    print(len(256))

    ----------------------------------------------------------------------
    TypeError                            Traceback (most recent call last)
    <ipython-input-29-00ccdb9afd37> in <module>()
          1 #Number
    ----> 2 print(len(256))

    TypeError: object of type 'int' has no len()

Excercises[¶](#Excercises) {#Excercises}
--------------------------

1.  What type of value is 3.4? How can you find out?

1.  What type of value is 3.25 + 4?

1.  What type of value (integer, floating point number, or character
    string) would you use to represent each of the following? Try to
    come up with more than one good answer for each problem. For
    example, in \# 1, when would counting days with a floating point
    variable make more sense than using an integer?

Number of days since the start of the year.

Time elapsed from the start of the year until now in days.

Serial number of a piece of lab equipment.

A lab specimen’s age Current population of a city.

Average population of a city over time.

1.  Which of the following will return the floating point number `2.0`?
    Note: there may be more than one right answer.

<!-- -->

    first = 1.0
    second = "1"
    third = "1.1"

1.first + float(second)

2.float(second) + float(third)

3.first + int(third)

4.first + int(float(third))

5.int(first) + int(float(third))

1.  2.0 \* second

Key Points - Data Types and Type Conversion[¶](#Key-Points---Data-Types-and-Type-Conversion) {#Key-Points---Data-Types-and-Type-Conversion}
============================================================================================

-   Every value has a type.

-   Use the built-in function type to find the type of a value.

-   Types control what operations can be done on values.

-   Strings can be added and multiplied.

-   Strings have a length (but numbers don’t).

-   Must convert numbers to strings or vice versa when operating on
    them.

-   Can mix integers and floats freely in operations.

-   Variables only change value when something is assigned to them.

STRETCHING TIME![¶](#STRETCHING-TIME!) {#STRETCHING-TIME!}
======================================

Numpy[¶](#Numpy) {#Numpy}
================

[NumPy](https://numpy.org/) is the fundamental package for scientific
computing with Python. It contains among other things:

-   a powerful N-dimensional array object

-   sophisticated (broadcasting) functions

-   tools for integrating C/C++ and Fortran code

-   useful linear algebra, Fourier transform, and random number
    capabilities

Besides its obvious scientific uses, NumPy can also be used as an
efficient multi-dimensional container of generic data. Arbitrary
data-types can be defined. This allows NumPy to seamlessly and speedily
integrate with a wide variety of databases.

We can create random numers easily

In [34]:

    import numpy as np

In [30]:

    from numpy import random

    r = random.randint(1, 35)
    print(r)

    26

A very useful data structure, very similar to lists with a few
exceptions such as:

-   The number of elements in the array cannot be changed. (This means
    we cant .append() or remove)
-   All element in the arrays must be the type of variables
-   Once the array is created we can't change the data type.

Advantages over lists:

-   Arrays can be n-dimensional (vector, matrix, tensor)
-   Supports arithmetic algebraic
-   Arrays work faster than lists

In [32]:

    mylist = [1,2,3,4 ]
    mylist

Out[32]:

    [1, 2, 3, 4]

In [35]:

     np.array(mylist)

Out[35]:

    array([1, 2, 3, 4])

In [36]:

    mymatrix = [[1,2,3], [4,5,6], [7,8,9]]
    mymatrix

Out[36]:

    [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

In [37]:

    m = np.array(mymatrix)
    m

Out[37]:

    array([[1, 2, 3],
           [4, 5, 6],
           [7, 8, 9]])

In [38]:

     type(m)

Out[38]:

    numpy.ndarray

There are many ways to create an array, let's try some:

Let's asume `a` is any numpy array.

  Function        Description
  --------------- ----------------------------------------------------------------------------------------
  `a.shape`       Returns a tuple with the numer of elements per dimension
  `a.ndim`        Number of dimension
  `a.size`        Number of elements in an array
  `a.dtype`       Data type of the elements in the array
  `a.T`           Transposes the array
  `a.flat`        Collapses the array in 1 dimension
  `a.copy()`      Returns a copy of the array
  `a.fill()`      Fills the array with a determined value
  `a.reshape()`   Returns an array with the same data but in the shape we indicate
  `a.resize()`    Changes the shape of the array, but this does not creates a copy of the original array
  `a.sort()`      Reorders the array

In [43]:

    # Try some!
    print(m.dtype)
    print(m)

    int64
    [[1 2 3]
     [4 5 6]
     [7 8 9]]

Slicing, but in arrays[¶](#Slicing,-but-in-arrays) {#Slicing,-but-in-arrays}
--------------------------------------------------

It's more flexible. Slicings follows this structure:

`beginning:end:step`

In [52]:

    a = np.linspace(0, 10, 11)
    #blank spaces mean "everthing" 

    # all 
    print(a[1:11])

    [ 1.  2.  3.  4.  5.  6.  7.  8.  9. 10.]

In [0]:

     #  3 to 8
    print(a[3:8])

    #  1 to 9 with steps of size 2 (odd)
    print(a[1:11:2])

    [3. 4. 5. 6. 7.]
    [1. 3. 5. 7. 9.]

In [54]:

    # conditionals 
    print(a[a > 4])

    [ 5.  6.  7.  8.  9. 10.]

Exercises[¶](#Exercises) {#Exercises}
------------------------

Try it yourself

1.  Create a non squared matrix, and print the dimensions (.shape)
2.  Use .reshape to change the shape of the array
3.  Try . size is equal to np.prod(a.shape)

Built-in Functions and Help[¶](#Built-in-Functions-and-Help) {#Built-in-Functions-and-Help}
============================================================

(10 min)

Exercises (10 min)

Arguments in a function

-   A function may take zero or more arguments

-   An **argument** is a value passed into a function

For example some of the functions we used so far have arguments

-   **`len`** takes exactly one argument

<!-- -->

    len(_x_)

-   **int, str and float** create a new value from an existing one

-   **print** takes zero or more arguments

    -   With no arguments prints a blank line
    -   Must use the parethesis to use the function

<!-- -->

    print('before')
    print()
    print('after')

### Commonly-used built-in functions include `max`, `min` and `round`[¶](#Commonly-used-built-in-functions-include-max,-min-and-round) {#Commonly-used-built-in-functions-include-max,-min-and-round}

-   `max()`
-   `min()`
-   `round()`

You can also combine some functions

    print(max(1, 2, 3))
    print(min('a', 'A', '0'))

But these functions may only work for certain (combination of)
arguments.

For example:

-   max and min must be given at least one argument.

    -   “Largest of the empty set” is a meaningless question.
-   And they must be given things that can meaningfully be compared.

In [59]:

    print(max(1,4,6,9,100000))
    print(min('a', 'A', 0))

    100000

    ----------------------------------------------------------------------
    TypeError                            Traceback (most recent call last)
    <ipython-input-59-4a37fdd5cb05> in <module>()
          1 print(max(1,4,6,9,100000))
    ----> 2 print(min('a', 'A', 0))

    TypeError: '<' not supported between instances of 'int' and 'str'

### Functions may have default values for some arguments[¶](#Functions-may-have-default-values-for-some-arguments) {#Functions-may-have-default-values-for-some-arguments}

-   `round` will round off a floating-point number.
-   By default, rounds to zero decimal places.

In [61]:

    round(3.712)

    # We can specify the number of decimal places we want. Let's try:

    round(3.712, 2 )

Out[61]:

    3.71

### You can use the built-in function `help` to get help for a function.[¶](#You-can-use-the-built-in-function-help-to-get-help-for-a-function.) {#You-can-use-the-built-in-function-help-to-get-help-for-a-function.}

-   Every built-in has online documentation.

In [62]:

    help(round)

    Help on built-in function round in module builtins:

    round(...)
        round(number[, ndigits]) -> number
        
        Round a number to a given precision in decimal digits (default 0 digits).
        This returns an int when called with one argument, otherwise the
        same type as the number. ndigits may be negative.

In [63]:

    help(max)

    Help on built-in function max in module builtins:

    max(...)
        max(iterable, *[, default=obj, key=func]) -> value
        max(arg1, arg2, *args, *[, key=func]) -> value
        
        With a single iterable argument, return its biggest item. The
        default keyword-only argument specifies an object to return if
        the provided iterable is empty.
        With two or more arguments, return the largest argument.

### Python reports a syntax error when it can’t understand the source of a program.[¶](#Python-reports-a-syntax-error-when-it-can’t-understand-the-source-of-a-program.) {#Python-reports-a-syntax-error-when-it-can’t-understand-the-source-of-a-program.}

    # Forgot to close the quote marks around the string.
    name = 'Feng

Try it!

In [66]:

    name = 'Feng'
    print(name)

    Feng

-   The message indicates a problem on first line of the input (“line
    1”).
    -   In this case the “ipython-input” section of the file name tells
        us that we are working with input into IPython, the Python
        interpreter used by the Jupyter Notebook.
-   The -6- part of the filename indicates that the error occurred in
    cell 6 of our Notebook.
-   Next is the problematic line of code, indicating the problem with a
    \^ pointer.

### Python reports a runtime error when something goes wrong while a program is executing.[¶](#Python-reports-a-runtime-error-when-something-goes-wrong-while-a-program-is-executing.) {#Python-reports-a-runtime-error-when-something-goes-wrong-while-a-program-is-executing.}

In [68]:

    age = 53
    remaining = 100 - age # mis-spelled 'age'
    print(remaining)

    47

-   Fix syntax errors by reading the source and runtime errors by
    tracing execution.

### Getting help in Jupyter[¶](#Getting-help-in-Jupyter) {#Getting-help-in-Jupyter}

There are 2 ways to get help in a Jupyter Notebook

1.  Place the cursor anywhere in the function invocation (i.e., the
    function name or its parameters), hold down ***`shift`***, and press
    ***`tab`***.

2.  Or type a function name with a question mark after it.

Every function returns something

-   Every function call produces some result.
-   If the function doesn’t have a useful result to return, it usually
    returns the special value `None`.

In [69]:

    max?

In [70]:

    result = print('example')
    print('result of print is', result)

    example
    result of print is None

Excercises[¶](#Excercises) {#Excercises}
--------------------------

### What happens when...[¶](#What-happens-when...) {#What-happens-when...}

1.  Explain in simple terms the order of operations in the following
    program: when does the addition happen, when does the subtraction
    happen, when is each function called, etc.
2.  What is the final value of radiance?

In [71]:

    radiance = 1.0
    radiance = max(2.1, 2.0 + min(radiance, 1.1 * radiance - 0.5))
    # The value is ... 2.6
    print(radiance)

    2.6

### Spot the Difference![¶](#Spot-the-Difference!) {#Spot-the-Difference!}

1.  Predict what each of the print statements in the program below will
    print.
2.  Does max(len(rich), poor) run or produce an error message? If it
    runs, does its result make any sense?

<!-- -->

    easy_string = "abc"
    print(max(easy_string))
    rich = "gold"
    poor = "tin"
    print(max(rich, poor))
    print(max(len(rich), len(poor)))

### Why not?[¶](#Why-not?) {#Why-not?}

Why don’t max and min return None when they are given no arguments?

KEY POINTS[¶](#KEY-POINTS) {#KEY-POINTS}
--------------------------

-   Use comments to add documentation to programs.

-   A function may take zero or more arguments.

-   Commonly-used built-in functions include max, min, and round.

-   Functions may only work for certain (combinations of) arguments.

-   Functions may have default values for some arguments.

-   Use the built-in function help to get help for a function.

-   The Jupyter Notebook has two ways to get help.

-   Every function returns something.

-   Python reports a syntax error when it can’t understand the source of
    a program.

-   Python reports a runtime error when something goes wrong while a
    program is executing.

-   Fix syntax errors by reading the source code, and runtime errors by
    tracing the program’s execution.

Libraries[¶](#Libraries) {#Libraries}
========================

10 min

Most of the power of a programming language is in its libraries.

-   Library = collection of files (modules) that functions for use by
    other programs.

-   The Python standard library is an extensive suite of modules that
    comes with Python itself.

Other libraries available in PyPI (the Python Package Index).

A program must import a library module before using it.

-   Use import to load a library module into a program’s memory.
-   Then refer to things from the module as module\_name.thing\_name.
    Python uses . to mean “part of”.

In [72]:

    import math

    print('pi is', math.pi)
    print('cos(pi) is', math.cos(math.pi))

    pi is 3.141592653589793
    cos(pi) is -1.0

We can also use help() to learn about the content of a library module,
just like we do with functions!

In [73]:

    help(math)

    Help on module math:

    NAME
        math

    MODULE REFERENCE
        https://docs.python.org/3.6/library/math
        
        The following documentation is automatically generated from the Python
        source files.  It may be incomplete, incorrect or include features that
        are considered implementation detail and may vary between Python
        implementations.  When in doubt, consult the module reference at the
        location listed above.

    DESCRIPTION
        This module is always available.  It provides access to the
        mathematical functions defined by the C standard.

    FUNCTIONS
        acos(...)
            acos(x)
            
            Return the arc cosine (measured in radians) of x.
        
        acosh(...)
            acosh(x)
            
            Return the inverse hyperbolic cosine of x.
        
        asin(...)
            asin(x)
            
            Return the arc sine (measured in radians) of x.
        
        asinh(...)
            asinh(x)
            
            Return the inverse hyperbolic sine of x.
        
        atan(...)
            atan(x)
            
            Return the arc tangent (measured in radians) of x.
        
        atan2(...)
            atan2(y, x)
            
            Return the arc tangent (measured in radians) of y/x.
            Unlike atan(y/x), the signs of both x and y are considered.
        
        atanh(...)
            atanh(x)
            
            Return the inverse hyperbolic tangent of x.
        
        ceil(...)
            ceil(x)
            
            Return the ceiling of x as an Integral.
            This is the smallest integer >= x.
        
        copysign(...)
            copysign(x, y)
            
            Return a float with the magnitude (absolute value) of x but the sign 
            of y. On platforms that support signed zeros, copysign(1.0, -0.0) 
            returns -1.0.
        
        cos(...)
            cos(x)
            
            Return the cosine of x (measured in radians).
        
        cosh(...)
            cosh(x)
            
            Return the hyperbolic cosine of x.
        
        degrees(...)
            degrees(x)
            
            Convert angle x from radians to degrees.
        
        erf(...)
            erf(x)
            
            Error function at x.
        
        erfc(...)
            erfc(x)
            
            Complementary error function at x.
        
        exp(...)
            exp(x)
            
            Return e raised to the power of x.
        
        expm1(...)
            expm1(x)
            
            Return exp(x)-1.
            This function avoids the loss of precision involved in the direct evaluation of exp(x)-1 for small x.
        
        fabs(...)
            fabs(x)
            
            Return the absolute value of the float x.
        
        factorial(...)
            factorial(x) -> Integral
            
            Find x!. Raise a ValueError if x is negative or non-integral.
        
        floor(...)
            floor(x)
            
            Return the floor of x as an Integral.
            This is the largest integer <= x.
        
        fmod(...)
            fmod(x, y)
            
            Return fmod(x, y), according to platform C.  x % y may differ.
        
        frexp(...)
            frexp(x)
            
            Return the mantissa and exponent of x, as pair (m, e).
            m is a float and e is an int, such that x = m * 2.**e.
            If x is 0, m and e are both 0.  Else 0.5 <= abs(m) < 1.0.
        
        fsum(...)
            fsum(iterable)
            
            Return an accurate floating point sum of values in the iterable.
            Assumes IEEE-754 floating point arithmetic.
        
        gamma(...)
            gamma(x)
            
            Gamma function at x.
        
        gcd(...)
            gcd(x, y) -> int
            greatest common divisor of x and y
        
        hypot(...)
            hypot(x, y)
            
            Return the Euclidean distance, sqrt(x*x + y*y).
        
        isclose(...)
            isclose(a, b, *, rel_tol=1e-09, abs_tol=0.0) -> bool
            
            Determine whether two floating point numbers are close in value.
            
               rel_tol
                   maximum difference for being considered "close", relative to the
                   magnitude of the input values
                abs_tol
                   maximum difference for being considered "close", regardless of the
                   magnitude of the input values
            
            Return True if a is close in value to b, and False otherwise.
            
            For the values to be considered close, the difference between them
            must be smaller than at least one of the tolerances.
            
            -inf, inf and NaN behave similarly to the IEEE 754 Standard.  That
            is, NaN is not close to anything, even itself.  inf and -inf are
            only close to themselves.
        
        isfinite(...)
            isfinite(x) -> bool
            
            Return True if x is neither an infinity nor a NaN, and False otherwise.
        
        isinf(...)
            isinf(x) -> bool
            
            Return True if x is a positive or negative infinity, and False otherwise.
        
        isnan(...)
            isnan(x) -> bool
            
            Return True if x is a NaN (not a number), and False otherwise.
        
        ldexp(...)
            ldexp(x, i)
            
            Return x * (2**i).
        
        lgamma(...)
            lgamma(x)
            
            Natural logarithm of absolute value of Gamma function at x.
        
        log(...)
            log(x[, base])
            
            Return the logarithm of x to the given base.
            If the base not specified, returns the natural logarithm (base e) of x.
        
        log10(...)
            log10(x)
            
            Return the base 10 logarithm of x.
        
        log1p(...)
            log1p(x)
            
            Return the natural logarithm of 1+x (base e).
            The result is computed in a way which is accurate for x near zero.
        
        log2(...)
            log2(x)
            
            Return the base 2 logarithm of x.
        
        modf(...)
            modf(x)
            
            Return the fractional and integer parts of x.  Both results carry the sign
            of x and are floats.
        
        pow(...)
            pow(x, y)
            
            Return x**y (x to the power of y).
        
        radians(...)
            radians(x)
            
            Convert angle x from degrees to radians.
        
        sin(...)
            sin(x)
            
            Return the sine of x (measured in radians).
        
        sinh(...)
            sinh(x)
            
            Return the hyperbolic sine of x.
        
        sqrt(...)
            sqrt(x)
            
            Return the square root of x.
        
        tan(...)
            tan(x)
            
            Return the tangent of x (measured in radians).
        
        tanh(...)
            tanh(x)
            
            Return the hyperbolic tangent of x.
        
        trunc(...)
            trunc(x:Real) -> Integral
            
            Truncates x to the nearest Integral toward 0. Uses the __trunc__ magic method.

    DATA
        e = 2.718281828459045
        inf = inf
        nan = nan
        pi = 3.141592653589793
        tau = 6.283185307179586

    FILE
        /usr/local/lib/python3.6/lib-dynload/math.cpython-36m-x86_64-linux-gnu.so

Import specific items from a library module to shorten programs.

-   Use from ... import ... to load only specific items from a library
    module.
-   Then refer to them directly without library name as prefix.

In [74]:

    from math import cos, pi

    print('cos(pi) is', cos(pi))

    cos(pi) is -1.0

Create an alias for a library module when importing it to shorten
programs.

-   Use import ... as ... to give a library a short alias while
    importing it.
-   Then refer to items in the library using that shortened name.

Exercises[¶](#Exercises) {#Exercises}
------------------------

### Exploring the Math Module[¶](#Exploring-the-Math-Module) {#Exploring-the-Math-Module}

-   What function from the math module can you use to calculate a square
    root without using sqrt?
-   Since the library contains this function, why does sqrt exist?

### Locating the Right Module[¶](#Locating-the-Right-Module) {#Locating-the-Right-Module}

You want to select a random character from a string:

    bases = 'ACTTGCTTGAC'

1.  Which standard library module could help you?
2.  Which function would you select from that module? Are there
    alternatives?
3.  Try to write a program that uses the function.

In [78]:

    from random import randrange
    bases = 'ACTTGCTTGAC'
    print(bases[randrange(len(bases))])

    A

### Jigsaw Puzzle (Parson’s Problem)[¶](#Jigsaw-Puzzle-(Parson’s-Problem)) {#Jigsaw-Puzzle-(Parson’s-Problem)}

Rearrange the following statements so that a random DNA base is printed
and its index in the string. Not all statements may be needed. Feel free
to use/add intermediate variables.

In [ ]:

    bases="ACTTGCTTGAC"
    import math
    import random
    ___ = random.randrange(n_bases)
    ___ = len(bases)
    print("random base ", bases[___], "base index", ___)

### Importing with aliases[¶](#Importing-with-aliases) {#Importing-with-aliases}

1.  Fill in the blanks so that the program below prints 90.0.
2.  Rewrite the program so that it uses import without as.
3.  Which form do you find easier to read?

In [80]:

    import math as m
    angle = m.degrees(m.pi / 2)
    print(angle)

    90.0

### Importing Specific Items[¶](#Importing-Specific-Items) {#Importing-Specific-Items}

1.  Fill in the blanks so that the program below prints 90.0.
2.  Do you find this version easier to read than preceding ones?
3.  Why wouldn’t programmers always use this form of import?

In [ ]:

    ____ math import ____, ____
    angle = degrees(pi / 2)
    print(angle)

### Reading Error Messages[¶](#Reading-Error-Messages) {#Reading-Error-Messages}

1.  Read the code below and try to identify what the errors are without
    running it.
2.  Run the code, and read the error message. What type of error is it?

In [79]:

    from math import log
    log(0)

    ----------------------------------------------------------------------
    ValueError                           Traceback (most recent call last)
    <ipython-input-79-d72e1d780bab> in <module>()
          1 from math import log
    ----> 2 log(0)

    ValueError: math domain error

Keypoints[¶](#Keypoints) {#Keypoints}
------------------------

-   Most of the power of a programming language is in its libraries.
-   A program must import a library module in order to use it.
-   Use help to learn about the contents of a library module.
-   Import specific items from a library to shorten programs.
-   Create an alias for a library when importing it to shorten programs.

Data Frames[¶](#Data-Frames) {#Data-Frames}
============================

Reading tabular data into DataFrame[¶](#Reading-tabular-data-into-DataFrame) {#Reading-tabular-data-into-DataFrame}
----------------------------------------------------------------------------

(15 min)

Exercises (10 min)

### Pandas[¶](#Pandas) {#Pandas}

A widely know library for statistics, particularly on tabular data.

-   Borrows many features from R´s dataframes.

Dataframe: A 2-dimensional table whose columns have names and
potentially have different data types.

In [81]:

    #Let's import pandas
    import pandas as pd

    data = pd.read_csv('/home/mcubero/dataSanJose19/data/gapminder_gdp_oceania.csv')
    print(data)

           country  gdpPercap_1952  gdpPercap_1957  gdpPercap_1962  \
    0    Australia     10039.59564     10949.64959     12217.22686   
    1  New Zealand     10556.57566     12247.39532     13175.67800   

       gdpPercap_1967  gdpPercap_1972  gdpPercap_1977  gdpPercap_1982  \
    0     14526.12465     16788.62948     18334.19751     19477.00928   
    1     14463.91893     16046.03728     16233.71770     17632.41040   

       gdpPercap_1987  gdpPercap_1992  gdpPercap_1997  gdpPercap_2002  \
    0     21888.88903     23424.76683     26997.93657     30687.75473   
    1     19007.19129     18363.32494     21050.41377     23189.80135   

       gdpPercap_2007  
    0     34435.36744  
    1     25185.00911  

#### File not found[¶](#File-not-found) {#File-not-found}

Our lessons store their data files in a data sub-directory, which is why
the path to the file is data/gapminder\_gdp\_oceania.csv. If you forget
to include data/, or if you include it but your copy of the file is
somewhere else, you will get a runtime error that ends with a line like
this:

    ERROR
    OSError: File b'gapminder_gdp_oceania.csv' does not exist

### Use index\_col to specify that a column’s values should be used as row headings.[¶](#Use-index_col-to-specify-that-a-column’s-values-should-be-used-as-row-headings.) {#Use-index_col-to-specify-that-a-column’s-values-should-be-used-as-row-headings.}

-   Row headings are numbers (0 and 1 in this case).
-   Really want to index by country.
-   Pass the name of the column to read\_csv as its index\_col parameter
    to do this.

In [84]:

    data = pd.read_csv('/home/mcubero/dataSanJose19/data/gapminder_gdp_oceania.csv', index_col='country')
    data

Out[84]:

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

country

Australia

10039.59564

10949.64959

12217.22686

14526.12465

16788.62948

18334.19751

19477.00928

21888.88903

23424.76683

26997.93657

30687.75473

34435.36744

New Zealand

10556.57566

12247.39532

13175.67800

14463.91893

16046.03728

16233.71770

17632.41040

19007.19129

18363.32494

21050.41377

23189.80135

25185.00911

Use DataFrame.info to explore a little the dataframe

In [85]:

    data.info()

    <class 'pandas.core.frame.DataFrame'>
    Index: 2 entries, Australia to New Zealand
    Data columns (total 12 columns):
    gdpPercap_1952    2 non-null float64
    gdpPercap_1957    2 non-null float64
    gdpPercap_1962    2 non-null float64
    gdpPercap_1967    2 non-null float64
    gdpPercap_1972    2 non-null float64
    gdpPercap_1977    2 non-null float64
    gdpPercap_1982    2 non-null float64
    gdpPercap_1987    2 non-null float64
    gdpPercap_1992    2 non-null float64
    gdpPercap_1997    2 non-null float64
    gdpPercap_2002    2 non-null float64
    gdpPercap_2007    2 non-null float64
    dtypes: float64(12)
    memory usage: 208.0+ bytes

What we know?

-   ***data*** is a DataFrame
-   It has two rows named 'Australia' and 'New Zealand'
-   There are Twelve columns, each of which has two actual 64-bit
    floating point values.
-   No null values, aka no missing observations.
-   Uses 208.0 bytes of memory

### The DataFrame.columns variable stores information about the dataframe's columns[¶](#The-DataFrame.columns-variable-stores-information-about-the-dataframe's-columns) {#The-DataFrame.columns-variable-stores-information-about-the-dataframe's-columns}

-   Note that this is data, not a method.
    -   Like math.pi.
    -   So do not use () to try to call it.
-   Called a member variable, or just member.

*data* is the dataframe, not a method, don't use () to try to call it.

In [86]:

    print(data.columns)

    Index(['gdpPercap_1952', 'gdpPercap_1957', 'gdpPercap_1962', 'gdpPercap_1967',
           'gdpPercap_1972', 'gdpPercap_1977', 'gdpPercap_1982', 'gdpPercap_1987',
           'gdpPercap_1992', 'gdpPercap_1997', 'gdpPercap_2002', 'gdpPercap_2007'],
          dtype='object')

Use DataFrame.T to transpose a dataframe

-   Sometimes want to treat columns as rows and vice versa.
-   Transpose (written .T) doesn’t copy the data, just changes the
    program’s view of it.
-   Like columns, it is a member variable.

In [87]:

    print(data.T)
    data.T

    country           Australia  New Zealand
    gdpPercap_1952  10039.59564  10556.57566
    gdpPercap_1957  10949.64959  12247.39532
    gdpPercap_1962  12217.22686  13175.67800
    gdpPercap_1967  14526.12465  14463.91893
    gdpPercap_1972  16788.62948  16046.03728
    gdpPercap_1977  18334.19751  16233.71770
    gdpPercap_1982  19477.00928  17632.41040
    gdpPercap_1987  21888.88903  19007.19129
    gdpPercap_1992  23424.76683  18363.32494
    gdpPercap_1997  26997.93657  21050.41377
    gdpPercap_2002  30687.75473  23189.80135
    gdpPercap_2007  34435.36744  25185.00911

Out[87]:

country

Australia

New Zealand

gdpPercap\_1952

10039.59564

10556.57566

gdpPercap\_1957

10949.64959

12247.39532

gdpPercap\_1962

12217.22686

13175.67800

gdpPercap\_1967

14526.12465

14463.91893

gdpPercap\_1972

16788.62948

16046.03728

gdpPercap\_1977

18334.19751

16233.71770

gdpPercap\_1982

19477.00928

17632.41040

gdpPercap\_1987

21888.88903

19007.19129

gdpPercap\_1992

23424.76683

18363.32494

gdpPercap\_1997

26997.93657

21050.41377

gdpPercap\_2002

30687.75473

23189.80135

gdpPercap\_2007

34435.36744

25185.00911

### Use DataFrame.describe to get summary statistics about data[¶](#Use-DataFrame.describe-to-get-summary-statistics-about-data) {#Use-DataFrame.describe-to-get-summary-statistics-about-data}

DataFrame.describe() gets the summary statistics of only the columns
that have numerical data. All other columns are ignored, unless you use
the argument include='all'

In [89]:

    data.describe()

Out[89]:

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

count

2.000000

2.000000

2.000000

2.000000

2.00000

2.000000

2.000000

2.000000

2.000000

2.000000

2.000000

2.000000

mean

10298.085650

11598.522455

12696.452430

14495.021790

16417.33338

17283.957605

18554.709840

20448.040160

20894.045885

24024.175170

26938.778040

29810.188275

std

365.560078

917.644806

677.727301

43.986086

525.09198

1485.263517

1304.328377

2037.668013

3578.979883

4205.533703

5301.853680

6540.991104

min

10039.595640

10949.649590

12217.226860

14463.918930

16046.03728

16233.717700

17632.410400

19007.191290

18363.324940

21050.413770

23189.801350

25185.009110

25%

10168.840645

11274.086022

12456.839645

14479.470360

16231.68533

16758.837652

18093.560120

19727.615725

19628.685413

22537.294470

25064.289695

27497.598692

50%

10298.085650

11598.522455

12696.452430

14495.021790

16417.33338

17283.957605

18554.709840

20448.040160

20894.045885

24024.175170

26938.778040

29810.188275

75%

10427.330655

11922.958888

12936.065215

14510.573220

16602.98143

17809.077557

19015.859560

21168.464595

22159.406358

25511.055870

28813.266385

32122.777857

max

10556.575660

12247.395320

13175.678000

14526.124650

16788.62948

18334.197510

19477.009280

21888.889030

23424.766830

26997.936570

30687.754730

34435.367440

### Not particularly useful with just two records, but very helpful when there are thousands[¶](#Not-particularly-useful-with-just-two-records,-but-very-helpful-when-there-are-thousands) {#Not-particularly-useful-with-just-two-records,-but-very-helpful-when-there-are-thousands}

### Exercises[¶](#Exercises) {#Exercises}

Read the data in `gapminder_gdp_americas.csv` (should be in the same
directory as `gapminder_gdp_oceania.csv`)

##### Tip[¶](#Tip) {#Tip}

check the parameters to define the index.

Inspect the data.

Use the function help(americas.head) and help(americas.tail) the answer:

1.  What method callwill display the first three rows of this data?
2.  What method call will display the last three columns of this data?

#### Reading files in other directories[¶](#Reading-files-in-other-directories) {#Reading-files-in-other-directories}

The data for your current project is stored in a file called
microbes.csv, which is located in a folder called field\_data. You are
doing analysis in a notebook called analysis.ipynb in a sibling folder
called thesis:

    your_home_directory
    +-- field_data/
    |   +-- microbes.csv
    +-- thesis/
        +-- analysis.ipynb

What value(s) should you pass to read\_csv to read microbes.csv in
analysis.ipynb?

### Writing Data[¶](#Writing-Data) {#Writing-Data}

As well as the read\_csv function for reading data from a file, Pandas
provides a to\_csv function to write dataframes to files. Applying what
you’ve learned about reading from files, write one of your dataframes to
a file called processed.csv. You can use help to get information on how
to use to\_csv.

In [96]:

    data2 = data.copy()
    #pd.to_csv
    #data2.to_csv?
    data2.to_csv('/home/mcubero/dataSanJose19/data/processed.csv')

### Key Points[¶](#Key-Points) {#Key-Points}

-   Use the Pandas library to get basic statistics out of tabular data.

-   Use index\_col to specify that a column’s values should be used as
    row headings.

-   Use DataFrame.info to find out more about a dataframe.

-   The DataFrame.columns variable stores information about the
    dataframe’s columns.

-   Use DataFrame.T to transpose a dataframe.

-   Use DataFrame.describe to get summary statistics about data.

STRETCHING TIME![¶](#STRETCHING-TIME!) {#STRETCHING-TIME!}
--------------------------------------

Recap[¶](#Recap) {#Recap}
================

### Feedback & questions[¶](#Feedback-&-questions) {#Feedback-&-questions}
