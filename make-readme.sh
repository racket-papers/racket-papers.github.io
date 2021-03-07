#!/bin/bash
scribble --html --dest html --dest-name html/index.html racket-papers.scrbl
scribble --markdown --dest-name README.md racket-papers.scrbl
