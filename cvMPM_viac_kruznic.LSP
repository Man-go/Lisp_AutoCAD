;;;Autor: Fomenko Dmitriy
;;;Stavebná fakulta STU, LS 2019/2020, odbor MPM1
;;;AutoCAD 2020 EN or CZ
;;;Program nakresli n-kruznic
;;;Farbu kruznici nastavim cislom od 1 do 255

(defun c:cvMPM (/ stred polomer farba_kruznica farba pocet_kruznic uchop)		;definovanie funkcie
  (princ "\nProgram nakresli n-kruznic.")

  (setq farba (getvar "cecolor"))
  (setq uchop (getvar "osmode")) ; vypiname uchopny body

  ;;(princ "\nZadaj pocet kruznic:")
  ;;(setq pocet_kruznic (getpoint))
  (while ( or (< pocet_kruznic 1) (> pocet_kruznic 1000))
  	(setq pocet_kruznic (getint "\nZadaj pocet kruznic (1-1000):"))
  )   
  
  ;;(princ "\nZadaj farbu kruznice:")
  ;;(setq stred (getpoint))
  (while ( or (< farba_kruznica 1) (> farba_kruznica 255))
  	(setq farba_kruznica (getint "\nZadaj farbu kruznice (1-255):"))
  )  

  
  ;;(princ "\nZadaj stred kruznice:")
  ;;(setq stred (getpoint))
  (setq stred (getpoint "\nZadaj stred kruznice:"))

  
  ;;(princ "\nZadaj polomer kruznice:")
  ;;(setq stred (getpoint))
  (while (<= polomer 0)
  (setq polomer (getdist stred "\nZadaj polomer kruznice:"))
  )


  
  (setvar "osmode" 0)
  
  (repeat pocet_kruznic ;cykusl pro n-kruznic
    (command "_color" farba_kruznica)
    (command "_circle" stred polomer)

    
    (setq novy_stred (list (+ (* 2 polomer) (nth 0 stred)) (nth 1 stred) (nth 2 stred)))
    (setq stred novy_stred)

    (setq farba_kruznica  (+ farba_kruznica 1))

    (if (> farba_kruznica 255)
      (setq farba_kruznica 1)
    )   
  )


  (command "_zoom" "_extents")
  (command "_regenall")
  (command "_color" farba)

  (setvar "osmode" uchop)
)