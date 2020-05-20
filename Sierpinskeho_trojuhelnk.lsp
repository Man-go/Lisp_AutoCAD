;;;Autor: Fomenko Dmitriy
;;;Stavebná fakulta STU, LS 2019/2020, odbor MPM1
;;;AutoCAD 2020 EN or CZ
;;;Program nakresli Sierpinského trojúhelník
;;;Je potrebne nastavit fraktalnu hodnotu. Pri hodnote 10 to fungovalo velmi pomaly, pretoze fraktal bol pomerne velky.
;;;Alebo mam len velmi pomaly pocitac. Preto som obmedzil hodnotu od 0 do 20
;;;pomocou mysi urcime vrcholy trojuholnika


(defun c:serp (/ level bod1 bod2 bod3 draw uchop)
  (defun draw (x1 y1 x2 y2 x3 y3 n / x1_new y1_new x2_new y2_new x3_new y3_new)
    (if (> n 0)
      (progn ;viac príkazov tam, kde sa ocakáva iba jeden prikaz
    (setq x1_new (/ (+ x1 x2) 2)) ;vypocitame nove suradnice
    (setq y1_new (/ (+ y1 y2) 2))
    (setq x2_new (/ (+ x2 x3) 2))
    (setq y2_new (/ (+ y2 y3) 2))
    (setq x3_new (/ (+ x3 x1) 2))
    (setq y3_new (/ (+ y3 y1) 2))
    (command "_line" (list x1_new y1_new) (list x2_new y2_new) (list x3_new y3_new) "_c")
    (draw x1 y1 x1_new y1_new x3_new y3_new (1- n))
    (draw x2 y2 x2_new y2_new x1_new y1_new (1- n))
    (draw x3 y3 x3_new y3_new x2_new y2_new (1- n))
      );_ konec progn
    );_ konec if
  );_ konec defun
  (setq uchop (getvar "osmode")) ; vypiname uchopny body
  (setvar "cmdecho" 0) ;vypneme pomucku
  (while (or (< level 0) (> level 20)) ;dostavame hodnoty vrchol a dimenze fraktalu
    (setq level (getint "\nDimenze fraktala (0-20): "))
  )
  (command "_line"
       (setq bod1 (getpoint "\nPrvy bod: ")) ;Potrebujem trojuholnik, takze musite nastavit tri vrcholy
       (setq bod2 (getpoint bod1 "\nDruhy bod: "))
       (setq bod3 (getpoint bod2 "\nTreti bod: "))
       "_c"
  );_ konec command
  (setvar "osmode" 0)
  (draw (car bod1) (cadr bod1) (car bod2) (cadr bod2) (car bod3) (cadr bod3) level) ;volame f-ce pre kreslenie, posielame suradnice vrchol a dimenze fraktalu do funkcii pro kresleni
  (setvar "osmode" uchop)
  (princ)
);_ konec defun
(princ "\nZadajte v prikazovem riadku: (serp)")