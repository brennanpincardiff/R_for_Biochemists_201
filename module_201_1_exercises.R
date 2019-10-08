# Exercises

## ----figure_1j-----------------------------------------------------------
data_1j <- read_excel("file.xlsx", sheet_names[5])


## ----exercise_1_answer---------------------------------------------------
data_1j <- read_excel("file.xlsx", sheet_names[5])

# data in wide format...
# put into long tidy format... with gather and spread...
data_1j_l <- gather(data_1j, na.rm = TRUE)
# make the key a factor - important for graphing and stats
data_1j_l %>% mutate(key = factor(key, c("Control", "STIA"))) -> data_1j_lf




## ---- exercise_2_answer---------------------------------------------------------
 # bar plot
ggplot(data_1j_lf, aes(key, value)) +
     geom_bar(stat="identity")
 
#
data_1j_lf %>%
     group_by(key) %>%
     summarise(mean(value)) -> data_1j_stats
colnames(data_1j_stats) <- c("key", "mean")
  
# mean as a line and geom_jitter
ggplot(data_1j_stats, aes(key, mean)) +
     geom_point(shape = 95, size = 8) +
     geom_jitter(data=data_1j_lf,
     aes(key, value, colour=key), width = 0.1)
 
## 
## 


## ------- exercise_3_answer----------------------------------------------
ggplot(data_1j_lf, aes(key, value, colour=key)) +
    geom_boxplot() +
    geom_jitter(width = 0.1)

ggplot(data_1j_lf, aes(key, value, colour=key)) +
    geom_violin() +
    geom_jitter(width = 0.1)


## ---------whole_workflow_answer---------------------------------------------
data_1j %>%
    gather(na.rm = TRUE) %>%
    mutate(key = factor(key, c("Control", "STIA"))) %>%
    ggplot(aes(key, value, shape = key, colour=key)) +
    geom_boxplot(outlier.size=0) +
    geom_jitter(width = 0.1) +
    ylim(0,0.2) + 
    labs(x = "",
        y = "Bioluminescence", 
        title = "Figure 1j",
        subtitle = "Croft et al, Nature, 2019") +
    theme_classic() + theme(legend.position="none")

