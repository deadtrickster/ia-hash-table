(in-package :ia-hash-table.test)

(plan 1)

(ia-hash-table:enable-ia-syntax)

(subtest "Subtest ia-syntax"
 (let ((response (ia-hash-table:alist-ia-hash-table '(("name" . "John Smith")
                                                      ("age" . 34)
                                                      ("city" . "New York")
                                                      ("papers" . #((("title" . "title1")
                                                                     ("pages" . 243))
                                                                    (("title" . "title2")
                                                                     ("pages" . 650))))
                                                      ("account" . (("checking" . 36223)
                                                                    ("saving" . 468300)))))))

   (is #Iresponse.name "John Smith")

   (is #Iresponse.papers.[0].title "title1")
   (let ((index 1))     
     (is #Iresponse.papers.[index].title "title2"))

   (is #Iresponse.account?.saving 468300)

   (is #Iresponse.address NIL)

   (is-error #Iresponse.address.state 'error)

   (is #Iresponse.address?.state  NIL))

 (let ((nil-response))

   (is #Inil-response?.account.saving NIL)))

(finalize)
