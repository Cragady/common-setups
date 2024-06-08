# LaTex

`sudo apt-get install texlive`

Or for full:

`sudo apt-get install texlive-full`

https://askubuntu.com/questions/956006/pregenerating-context-markiv-format-this-may-take-some-time-takes-forever

Hit enter a ton if it gets stuck. It may be waiting for input. Usually prompts give default setups anyway, so no foul hopefully.

Usage:

`pdflatex test.tex`

## Maybe don't do full

(Includes Pandoc)

`sudo apt-get install pandoc texlive-latex-base texlive-fonts-recommended texlive-extra-utils texlive-latex-extra`

The above includes Markdown to pdf/html functionality. As an example:

```sh
pandoc MANUAL.txt -o example13.pdf
pandoc MANUAL.md -o example13.pdf
```
