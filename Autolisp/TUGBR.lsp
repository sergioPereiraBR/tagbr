;;http://www.rotinasautolisp.blogspot.com/
;;esta rotina desenha um c�rculo e dentro dele coloca um n�mero. 
;;sendo repetida a chamada da rotina, os n�meros s�o introduzidos de forma sequencial 
;;em qualquer altura � poss�vel redefinir o n�mero que se pretende. 
;;para cada n�mero � necess�rio repetir a chamada da rotina. 
;;para se alterar o tamanho do c�rculo/texto, deve-se alterar previamente o valor da vari�vel DIMScALE 
;;� importante que se esteja a trabalhar com o texto no style standart 
;;esta rotina � deveras �til para numerar elementos como materiais, equipamentos, etc. 
;; 
;; 
;; 
;; 
(defun TAG_BR () 
  (setq pit (getpoint "\PONTO DE INSER��O DA TAG")) 
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
;;Para se eliminar a cria��o e atribui��o da layer "Bolhas_Anota��es" 
;;deve-se eliminar as duas anteriores linhas de c�digo. 
  (TAG_BR) 
  (princ) 
)