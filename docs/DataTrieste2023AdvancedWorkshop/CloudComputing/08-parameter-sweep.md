# Parameter Sweep

We are going to do a parameter sweep using 3 virtual machines.
The First one needs to be named `head` - this will be used to access the others;
The other two machines will be named `worker1` and `worker2`

## Environment setup

After creating the 3 virtual machines, access the `head` virtual machine. In here we will need to install the `parallel-ssh` command line. 
In ordet to do that we need to run: 
```
$ sudo apt install pssh
```
Then, we need to copy our private key to the head node in order to access the worker nodes passwordlessly:

```
$ scp <your_private_key> ubuntu@<worker1_ip_address>:~/.ssh/id_rsa
$ scp <your_private_key> ubuntu@<worker2_ip_address>:~/.ssh/id_rsa
```
Than, we are going to check whether we are able to access the two machines without password. 
We do that by using the `ssh`:
```
$ ssh ubuntu@<worker1_ip_address>
```
Remember to run the `exit` command to disconnect from each machine.
```
$ ssh ubuntu@<worker2_ip_address>
```


Now, we will use the parallel-ssh command line to setup the environment. That means installing conda as well as the libraries needed.
As its names says, the parallel-ssh can run ssh connections in parallel.
First we need to create a file named hosts and this file must have the following content (you can use `nano` for this)
```
<worker1_ip_address>
<worker2_ip_address>
```
Then we will download the conda installer into the worker nodes:
```
$ parallel-ssh -i -h hosts -l ubuntu wget -c https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```
Now we need to install the miniconda environment manager. We are going to use the `-b` option so the installation 
should run _quietly_ (i.e. without generating any output)

```
$ parallel-ssh -i -h ssh_hosts_files -l ubuntu bash Miniconda3-latest-Linux-x86_64.sh -b
```
After installing we need to create a new envirnoment, that we will name `r-analysis` with the needed libraries:

```
$ parallel-ssh -i -h ssh_hosts_files -l ubuntu "/home/ubuntu/miniconda3/bin/conda -y create --name r-analysis r-base r-e1071 r-caret
```
We can check if everything went fine so far by running: 
```
$ parallel-ssh -i -h ssh_hosts_files -l ubuntu "source ~/miniconda3/bin/activate r-analysis; R --version"
```
This command is supposed to output the R version that has been installed in the worker nodes. It should look like this: 
```
[1] 08:43:55 [SUCCESS] 140.105.45.74
R version 4.2.0 (2022-04-22) -- "Vigorous Calisthenics"
Copyright (C) 2022 The R Foundation for Statistical Computing
Platform: x86_64-conda-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under the terms of the
GNU General Public License versions 2 or 3.
For more information about these matters see
https://www.gnu.org/licenses/.

[2] 08:43:55 [SUCCESS] 140.105.45.98
R version 4.2.0 (2022-04-22) -- "Vigorous Calisthenics"
Copyright (C) 2022 The R Foundation for Statistical Computing
Platform: x86_64-conda-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under the terms of the
GNU General Public License versions 2 or 3.
For more information about these matters see
https://www.gnu.org/licenses/.
```

Now we need to upload our analysis file to the worker nodes. Our anaysis will be a very simples `svm` algorithm.
So, we've developed the following code:
```r
library("e1071")
data(iris)
parameters = read.csv("parameters.csv")
kernel = as.character(parameters$kernel[[1]])
gamma = as.numeric(parameters$gamma[[1]])
train = sample(1:nrow(iris), round(nrow(iris)*0.75))
train_iris = iris[train,]
test_iris = iris[-train,]
svm1 = svm(Species ~., data = train_iris, kernel = kernel, gamma = gamma)
pred = predict(svm1, test_iris)
library(caret)
results = confusionMatrix(test_iris$Species, pred)
write.csv(as.matrix(results,what="overall"), "results.csv")
```
It reads the `svm` parameters from a file named `parameters.csv`. Thus, we will need two copies of this file, 
each containing a different set of parameters. Let's name these files `parameters1.csv` and `parameters2.csv`.
The content of this file should be:
```
kernel,gamma
radial,0.025
```
and 
```
kernel,gamma
radial,0.5
```

Now we will copy this two files to the workernodes. We will again use the `scp` command:
```
$ scp parameters1.csv ubuntu@<worker1_ip_address>:~/parameters.csv
```
and 
```
$ scp parameters2.csv ubuntu@<worker2_ip_address>:~/parameters.csv
```

Now we are finally ready to run our parallel analysis, again by using the `parallel-ssh` command:
```
$ parallel-ssh -i -h ssh_hosts_files -l ubuntu "source ~/miniconda3/bin/activate r-analysis; Rscript iris_analysis.R"
```
This analysis is not producing any output. It just saves the accuracy metrics to a file named `results.csv`. 
We need to copy those files back from the workernodes and compare them:
```
$ scp ubuntu@<worker1_ip_address>:~/results.csv results1.csv
```
and 
```
$ scp ubuntu@<worker2_ip_address>:~/results.csv results2.csv
```
Now we need to inspect the results and check which set of parameters gave the best accuracy:
```
$ cat results1.csv

"","V1"
"Accuracy",0.921052631578947
"Kappa",0.879746835443038
"AccuracyLower",0.786226708819382
"AccuracyUpper",0.98341352413547
"AccuracyNull",0.394736842105263
"AccuracyPValue",1.46731501462611e-11
"McnemarPValue",NA
```

and 
```
$ cat results2.csv

"","V1"
"Accuracy",0.947368421052632
"Kappa",0.91932059447983
"AccuracyLower",0.822509409652359
"AccuracyUpper",0.993561283284908
"AccuracyNull",0.394736842105263
"AccuracyPValue",7.82023378165494e-13
"McnemarPValue",NA
```

## Exercise
1. Change also the type of kernel used by the `svm`. Try with `linear` kernel.
2. Redo the same analysis by running a Tree Classifier using the `rpart` package;



