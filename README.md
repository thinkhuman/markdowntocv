# MarkdowntoCV

A lightweight tool for converting a resume written in markdown to web-ready HTML and print-ready PDF. Built with Linux in mind, but could run on most any platform that supports the dependencies.

## How it works
* **Style**: A CSS file (`css/resume.css`) and an HTML template (`templates/tohtml.html`) control the look and layout.
* **Convert**: Your resumse (`resume.md`) is turned into web-ready HTML (using `pandoc`) and print-ready PDF (using `wkhtmltopdf`). Styles are embedded in both the HTML and PDF so they're portable.
* **Build**:  A single `make` command runs the process (using the `Makefile`), creates the `dist` directory, and puts the output there (`resume.html` and `resume.pdf`).

## Dependencies
* [wkhtmltopdf](https://wkhtmltopdf.org/downloads.html):  `sudo apt install wkhtmltopdf`
* [pandoc](https://pandoc.org/installing.html):  `sudo apt install pandoc`
* [make](https://www.gnu.org/software/make/manual/html_node/index.html): (see instructions for your operating system.) Comes with Linux, but can be installed on MacOS and Windows.

That's all--no Python, Ruby, JavaScript, or anything else. If you can install a few programs and write plain text, you can use it.

## Instructions

1. Install `pandoc` and `wkhtmltopdf`. See installation instructions in the *Dependencies* section.
2. (If necessary) install `make`. Make is normally installed by default with Linux. 
3. Clone this repository, or just download the files to your local computer (see the `<> Code` button dropdown at the top right of the repo page).
4. Add your own resume to the project directory. Be sure to name it `resume.md`.
5. Add the following YAML front matter to your `resume.md` file, and fill it in:
```YAML
---
title: "yourtitlehere"
lang: en
resume_header:
  name: "your name"
  email: your@email.com
  site: https://yourwebsite.com
  linkedin: https://linkedin.com/yourlinkedinprofile
  tagline: Tagline to appear below your name on top of resume (e.g. "Awesome Engineer")
---
```
**NOTE**: All `resume_header` items are optional, and appear at the top of our resume to the right of your name/tagline. Delete any you like, but these are the defaults the template will look for. 

6. Write your resume (in markdown). [Here's a markdown cheat sheet](https://www.markdownlang.com/cheatsheet/).
7. Build your resume. You can do this as many times as you like, of course.

**NOTE**: New output files are not built unless you've made changes to your `resume.md`. No changes, no new output.


## Build commands (using the makefile)
* `make`: Make HTML and PDF
* `make html`: Make HTML only
* `make pdf` : Make PDF only
* `make clean`: Delete all existing output files (resume.pdf and resume.html) in the `dist` directory.