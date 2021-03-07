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


@;(get-ref "papers/test.scrbl")

@;(get-ref "papers/popl2020cbtb.scrbl")

@(for/list ([file (get-paper-details papers-path)]) @get-ref[file])

@;itemlist[@(for/list ([file (get-paper-details papers-path)]) @item{@get-ref[file])})]


