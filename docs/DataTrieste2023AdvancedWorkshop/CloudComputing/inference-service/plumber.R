#* @param Sepal.Length
#* @param Sepal.Width
#* @param Petal.Length
#* @param Petal.Width
#* @post /predict
function(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) {
  library(e1071)
  input <- data.frame(Sepal.Length=c(as.numeric(Sepal.Length)),Sepal.Width=c(as.numeric(Sepal.Width)), 
		      Petal.Length=c(as.numeric(Petal.Length)), Petal.Width=c(as.numeric(Petal.Width)))
  my_model <- readRDS("model.rds")
  prediction <- predict(my_model, input)
  return(prediction)
}

