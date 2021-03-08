#lang scribble/manual

@(require racket/runtime-path
          racket/dict
          racket/path)
@; Code here
@(define (path-string->string p-str)
  (if (string? p-str)
      p-str
      (path->string p-str)))

@; make-submod-path : path-string?
@(define (make-submod-path script-filename)
  (list 'submod
        (list 'file (path-string->string script-filename))))

@; get-ref : path-string?
@(define (get-ref script-filename)
  (dynamic-require (make-submod-path script-filename)
                   'ref
                   (λ () #f)))

@(define (paper-file? f)
   (equal? (path-get-extension f) #".scrbl"))


@(define-runtime-path papers-path "papers")

@(define (get-paper-details paper-path)
   (filter paper-file?
    (for/list ([filename (in-list (directory-list paper-path #:build? #f))])
      (build-path paper-path filename)
      )))


@title{Racket Papers}

Some research papers for the @(hyperlink "https://racket-lang.org/" "Racket") ecosystem of languages, tools and libraries.

@section{Introduction}

This is an attempt to collate research papers relating to the Racket ecosystem of tools including the Racket language, DrRacket IDE, @tt{raco} command line tools, Slideshow, Scribble and other tools and languages built with Racket.

To add a new publication create a PR to add a new file to the @tt{papers} folder with the following text

@codeblock|{
  #lang at-exp s-exp "bib.rkt"
  @title{Typed Dataspace Actors}
  @author{Caldwell, Garnock-Jones, Felleisen}
  @date{2020} 
  @location{Journal of Functional Programming}
  @url{https://www2.ccs.neu.edu/racket/pubs/cgjf-jfp20.pdf}
  @category{paper}
  @note{Also see the actual JFP version: http://dx.doi.org/10.1017/S0956796820000246}
}|


@section{Acknowlegements}

Thank you to all the Racketeers.

@section{Papers}


@(for/list ([file (get-paper-details papers-path)]) @get-ref[file])



