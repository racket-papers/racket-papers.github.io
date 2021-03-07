#lang racket/base

(require racket/format
         scribble/manual
         (for-syntax racket/base
                     syntax/parse))


(provide (except-out (all-from-out racket/base)
                     #%module-begin)
         
         (rename-out [module-begin #%module-begin])
         title
         author
         date
         location
         url
         category
         note)
 
(define-syntax (author stx)
  (syntax-parse stx
    [(_ expr) #`(define #,(syntax-local-introduce #'l-author) expr)]))

(define-syntax (title stx)
  (syntax-parse stx
    [(_ expr) #`(define #,(syntax-local-introduce #'l-title) expr)]))

(define-syntax (date stx)
  (syntax-parse stx
    [(_ expr) #`(define #,(syntax-local-introduce #'l-date) expr)]))

(define-syntax (location stx)
  (syntax-parse stx
    [(_ expr) #`(define #,(syntax-local-introduce #'l-location) expr)]))

(define-syntax (url stx)
  (syntax-parse stx
    [(_ expr) #`(define #,(syntax-local-introduce #'l-url) expr)]))

(define-syntax (category stx)
  (syntax-parse stx
    [(_ expr) #`(define #,(syntax-local-introduce #'l-category) expr)]))

(define-syntax (note stx)
  (syntax-parse stx
    [(_) #`(define #,(syntax-local-introduce #'l-note) "")] ; matches on no args
    [(_ expr) #`(define #,(syntax-local-introduce #'l-note) expr)]))


(define-syntax (module-begin stx)
  (syntax-parse stx
    [(_ expr ...)
     #`(#%module-begin
        (require scribble/manual)
        (provide ref)
        expr
        ...

        (define ref
          (elem
           (bold (hyperlink l-url l-title))
           (elem l-author)
           (elem l-location)
           (elem l-date)
           (elem l-category)
           (elem l-note)
           (linebreak))
          ))]))

