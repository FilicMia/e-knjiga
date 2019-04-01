## Enviroment setup

1. First you need to install R.
For writing and executing R/RMarkdown code I recommend installing RStudio IDE as well. It is specalized to work with R and 
all connected with R.  [The instalation](https://happygitwithr.com/install-r-rstudio.html) of R and RStudio is pretty easy: 
    1. Install a pre-compiled binary of R for your OS from here:
    https://cloud.r-project.org
    2. Install RStudio Desktop.
    3. Update your R packages: write 
    
    ```
    update.packages(ask = FALSE, checkBuilt = TRUE)
    ``` 
    in R terminal.
2. Install RMarkdown and Shiny package 
```
install.packages("shiny")
install.packages("rmarkdown")
``` 
3. Now everything is set to create your first RMarkdown + Shiny interactive document!


## Creating your first interactive document

Note:

1. I recomend to create one shiny application per one interactive snippet.