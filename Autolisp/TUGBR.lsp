;;http://www.rotinasautolisp.blogspot.com/
;;esta rotina desenha um círculo e dentro dele coloca um número. 
;;sendo repetida a chamada da rotina, os números são introduzidos de forma sequencial 
;;em qualquer altura é possível redefinir o número que se pretende. 
;;para cada número é necessário repetir a chamada da rotina. 
;;para se alterar o tamanho do círculo/texto, deve-se alterar previamente o valor da variável DIMScALE 
;;é importante que se esteja a trabalhar com o texto no style standart 
;;esta rotina é deveras útil para numerar elementos como materiais, equipamentos, etc. 
;; 
;; 
;; 
;; 
(defun TAG_BR () 
  (setq pit (getpoint "\PONTO DE INSERÇÃO DA TAG")) 
    (setq dimsc (getvar "dimscale")) 
      (command ".circle" pit (* 0.1875 dimsc)) 
        (command ".text" "M" pit (* 0.175 dimsc) 0 item) 
) 
;; 
(defun C:TAGBR (/ i pt s dimsc) 
  (setq s (itoa (setq item (if item (1+ item) 1)))) 
    (if (setq i (getint (strcat "\nItem <" s ">: "))) 
      (setq item i) 
)
 
  (command "layer" "new" "TAGBR-ELE-TUG" "color" "103" "TAGBR-ELE-TUG" "s") 
  (command "layer" "set" "TAGBR-ELE-TUG" "") 
;;Para se eliminar a criação e atribuição da layer "Bolhas_Anotações" 
;;deve-se eliminar as duas anteriores linhas de código. 
  (TAG_BR) 
  (princ) 
)