# R

[Site](https://cran.r-project.org/bin/linux/ubuntu/fullREADME.html)

## File Extensions: 

* `.r`
* `.R`
* `.Rd`
* `.rdata`
* `.rhistory`
* `.rds`
* `.rda`

## Install

`sudo apt-get install r-base r-base-dev`

The original installation was not pointed to a name that looked like a ubuntu naming convention for the repo. May have to fix an install.

The site describes how to get the latest version of R, so similar steps may have been followed in the past.

## RMarkdown

[GitHub](https://github.com/rstudio/rmarkdown)

This has a dependency on pandoc, but that's already installed with LaTeX.

File Extension: `.Rmd`

To do the following, open the R repl in your terminal.

[CRAN](https://cran.r-project.org/)
```R
install.packages("rmarkdown")
```

[Remotes package](https://remotes.r-lib.org/)
```R
# install.packages("pak")
pak::pak('rstudio/rmarkdown')
```

Load, if needed
```
library(rmarkdown)
library("rmarkdown") # Equivalent
```

## pdftools

[GitHub](https://github.com/ropensci/pdftools)

### Deps

Bionic/Focal
```sh
sudo add-apt-repository -y ppa:cran/poppler
sudo apt-get update
sudo apt-get install -y libpoppler-cpp-dev
```

Other versions of Deb/Ubuntu
```sh
sudo apt-get install libpoppler-cpp-dev
```

```sh
sudo apt-get install libcurl4-openssl-dev
```

### Install / Usage

```R
install.packages("pdftools")
```

```R
library(pdftools)
download.file("http://arxiv.org/pdf/1403.2805.pdf", "1403.2805.pdf", mode = "wb")
txt <- pdf_text("1403.2805.pdf")

# first page text
cat(txt[1])

# second page text
cat(txt[2])
```

```R
# Table of contents
toc <- pdf_toc("1403.2805.pdf")

# Show as JSON
jsonlite::toJSON(toc, auto_unbox = TRUE, pretty = TRUE)
```

```R
# Author, version, etc
info <- pdf_info("1403.2805.pdf")

# Table with fonts
fonts <- pdf_fonts("1403.2805.pdf")
```

```R
# renders pdf to bitmap array
bitmap_pre <- pdf_render_page("1403.2805.pdf", page = 1)

# save bitmap image
# Did not work, needs packages, using magick instead
# png::writePNG(bitmap, "page.png")
# webp::write_webp(bitmap, "page.webp")

# Needs Magick (below)
bitmap = image_read(bitmap_pre)
image_write(bitmap, "page.png", "png")
image_write(bitmap, "page.webp", "webp")


```

```R
txt <- pdf_text("http://arxiv.org/pdf/1406.4806.pdf")

# some tables
cat(txt[18])
cat(txt[19])
```

## Magick (Image Manipulation)

[Package](https://cran.r-project.org/web/packages/magick/vignettes/intro.html#:~:text=The%20magick%20package%20provide%20a,an%20overwhelming%20amount%20of%20functionality.)

`sudo apt-get install libmagick++-dev`

```R
install.packages("magick")
library(magick)
```

## Other Cool Things

### Reticulate

[Package](https://cran.r-project.org/web/packages/reticulate/index.html)

### Rcpp

[Package](https://cran.r-project.org/web/packages/Rcpp/index.html)

### DB Interfaces

Aside from R's built-in:

* `DBI`
* `RMySQL`
* `RSQLite`
* `RODBC`
