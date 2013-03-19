opts_chunk$set(tidy=FALSE, fig.height=5, comment="",
               fig.path="../images/intro/intro-")
options(show.signif.stars=FALSE)
options(max.print=170)
render_markdown()
knit_hooks$set(output=function(x, options)
               paste0("\n\n```plain\n", x, "```\n\n"))
