dir.create("scripts")
dir.create("data_output")
dir.create("fig_output")

download.file("https://ndownloader.figshare.com/files/11492171",
              "data/SAFI_clean.csv", mode = "wb")
installed.packages()

install.packages("abind")
install.packages("here")
