# Google Colab Warmup

Google Colaboratory (Colab) allows you to execute code on Google's cloud
servers, meaning you can leverage the power of Google hardware, including GPUs
and TPUs, regardless of the power of your machine. 

During this exercise we will get familiarised with the Colab platform. We will
also exercise our R knowledge by building a few data visualizations 

## Log Onto Google Colab
* Point your browser at the [Google Colab]([https://colab.to/r](https://colab.research.google.com/)
  site.
* If you are not signed in, use the _Sign In_ button on the top right of
  the screen. 
* You will be presented with a popup box that allows importing a file or
  starting a new file. Hit the _Cancel_ button and take some time to read
  the _"What is Colaboratory?"_ document located [here](https://colab.research.google.com/notebooks/intro.ipynb#scrollTo=5fCEDCU_qrC0). 
* Once you have a general understanding of what Colab is, proceed to the
  next section.

## Upload Base Notebook Built during the class
* Upload a file from the _File_ menu using the _Upload Notebook_ option. 
* You will see a popup that looks like this:
<img src="https://github.com/CODATA-RDA-DataScienceSchools/Materials/blob/master/docs/SouthAfrica2021/Colab_Open.png" width="800"/>

* Click the _GitHub_ link on the top bar menu.
* Enter this link:
  `https://github.com/CODATA-RDA-DataScienceSchools/Materials/blob/master/docs/SouthAfrica2021/Colab_R_Demo.ipynb`
  into the search field.
* This will open the Google Colaboratory Demo Notebook we will
  be looking at during this lesson.
* Don't forget to reconnect the kernel by using the "Connect" button at the
  top right of the notebook as can be seen at the image:
![Connect Kernel Image](connect_kernel.png)
* Also, don't forget to download the Economical Indicators dataset
  (`Economy_Data.csv`) from the [kaggle competition page](https://www.kaggle.com/docstein/brics-world-bank-indicators)
    * This dataset must be uploaded to the google colab using the upload functionality as can be seen in the image:
![Upload File Image](file_upload.png)

## Further Explore the Dataset
* Create a [bar plot](http://www.sthda.com/english/wiki/ggplot2-barplots-quick-start-guide-r-software-and-data-visualization)
  to show the growth in GDP over the years for `SouthAfrica`;
* The dataset contains several economical indicators. Select the data from
  a specific country (Brazil, Rusia, India, China or South Africa) and
  create a visualization to show data about `Agriculture, forestry, and
  fishing, value added per worker (constant 2010 US$)` and the `GDP per
  capita (constant 2010 US$)`. The idea is to try to correlate the growth
  in GDP to the growth in value added in Agriculture, forestry and fishing;
* Using the Climate change indicators of the csv file at the [BRICS World Bank Indicators](https://www.kaggle.com/docstein/brics-world-bank-indicators)
  * Select the data regarding the CO2 emissions (`CO2 emissions (kt)`);
  * Create a plot to show the evolution of the CO2 emissions over the
    years for all 5 countries;
  * Select one of the countries and create a plot to show how the
    CO2 emissions evolve over time when compared to the GDP per capita.
    This [link](https://www.r-graph-gallery.com/line-chart-dual-Y-axis-ggplot2.html) 
    can be useful for adding a second Y-axis to your plot.

[Return to CI Overview](00-Hands_on_Exercise_Overview.md)
