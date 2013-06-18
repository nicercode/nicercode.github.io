

# based on code from http://cat.hackingisbelieving.org/blog/2012/08/13/r-markdown-with-octopress/
# prepares files for publication on Octopress
# setting publsih = TRUE will push plots to _posts folder, images to images folder, and delete 
# similar files in the wd, if they exist

knit_post <- function(input, publish =FALSE, base.url ="/", published.post.dir = "../_posts", published.image.dir = "../images", width=160){
  require(knitr)
  
  opts_knit$set(width =width)  
  opts_knit$set(base.url = base.url)
  
  
  fig.path <- paste0(sub(".Rmd$", "", basename(input)), "/")
  output   <- sub(".Rmd", ".md", basename(input))

  if(publish){
    output=file.path(published.post.dir, output)
    fig.path=file.path(published.image.dir, fig.path)
  }
     
  opts_chunk$set(fig.path = fig.path)
  opts_chunk$set(fig.cap = "center")
  
  render_jekyll()
  knit(input, output = output, envir = parent.frame())

  if(publish){  #cleanup local files once published
    #list files to be renmoved
    image.dir <- sub(paste0(published.image.dir,"/"), "",  fig.path )
    files <- c(sub(paste0(published.post.dir,"/"), "", output), #post
             dir(image.dir, full.names = TRUE), #figures
              image.dir) #image  dir
#    tmp<-file.remove(files[file.exists(files)])
  }
  }