par(mfrow = c(3,2))
df %>%
  filter(dynamic < 1750) %>% 
  lm(data = ., dynamic ~ static) %>% 
  plot(which = 1:6)

qf(0.5, 2, 24)

augment(regmod) %>%
  filter(.cooksd < 1) %>% 
  lm(data = ., static ~ dynamic) %>% 
  plot(which = 1:6)

gvlma(lm(log(static) ~ dynamic, data = df), which =  1:6)

test_list = list()
test_list_2 = list()
for(j in 1:1000){  
  for (i in 1:1000) {
    x <- 1:1000
    y <- sapply(x, function(x){x + rnorm(mean = 0, sd = 50, n = 1)})
    printme <- gvlma(lm(y~x))$GlobalTest$DirectionalStat4$pvalue
    test_list$pval[i] <- printme
    # print(printme)
  }
  test_list_2[j] <- as.data.frame(test_list) %>% 
    filter(pval < 0.05) %>% 
    nrow()/i
  print(j)
}
