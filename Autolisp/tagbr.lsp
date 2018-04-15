;;==============================================================================================;
;; tagbr.lsp                                                                                    ;
;;                                                                                              ;
;; Fun��o de Tagueamento em Autolisp                                                            ;
;; Artefato originado de pesquisa e desenvolvimento                                             ;
;; para Pr�xis Engenharia e                                                                     ;
;; sem limites de uso.                                                                          ; 
;; Copyrigth 2012 - S�rgio Pereira                                                              ;
;; sergiopereira.br@hotmail.com                                                                 ;
;; Rio de Janeiro - Outubro de 2012                                                             ;
;;                                                                                              ;
;;==============================================================================================;
;;                                                                                              ;
;; Como utilizar esta fun��o no AUTOCAD:                                                        ;
;;                                                                                              ;
;; a) Na linha de comando digite 'appload' e carregue este arquivo                              ;
;;    (tagbr.lsp) na pasta em que se encontra;                                                  ;
;;                                                                                              ;
;; b) Ativar o layer de trabalho e na linha de comando digite 'tagbr' para chamar esta fun��o;  ;
;;                                                                                              ;
;; c) Siga o procedimento solicitado na linha de comando passo-a-passo para formar e formatar   ;
;;    a Tag:                                                                                    ;
;;                                                                                              ;
;;    i   - Informe o texto da parte fixa da Tag antes da numera��o serial, se existir;         ;
;;                                                                                              ;
;;    ii  - Informe o valor do primeiro n�mero da parte serial da tag, se n�o for 1;            ;
;;                                                                                              ;
;;    iii - Informe o texto da parte fixa da Tag, se necess�rio finalizando a Tag;              ;
;;                                                                                              ;
;; d) Altere a posi��o de inser��o do texto em rela��o ao cursor, se precisar adequar;          ;
;;                                                                                              ;
;; e) Altere o tamanho da letra do texto, conforme a necessidade;                               ;
;;                                                                                              ;
;; f) Altere o �ngulo de inclina��o do texto, para uma melhor apresenta��o;                     ;
;;                                                                                              ;
;; g) Posicione o cursor no ponto desejado do desenho e clique com o bot�o esquerdo do          ;
;;    mouse para inserir a TAG repetindo este item at� o t�rmino desse processo, para isso      ;
;;    tecle 'esc' ou 'enter' encerrando essa fun��o.                                            ;
;;                                                                                              ;
;;==============================================================================================;
;;                                                                                              ;
;;      NOTAS de estilos de inser��o do texto:                                                  ;
;;                                                                                              ;
;;      BL = (Bottom Left)  De baixo para cima e da esquerda para direita                       ;
;;      ML = (Middle Left)  Do meio e da esquerda para direita                                  ;
;;      TL = (Top Left)     De cima para baixo                                                  ;
;;      BC = (Bottom Center)Centralizado e de baixo para cima                                   ;
;;      M  = (Middle)       Centralizado                                                        ;
;;      TC = (Top Ceter)    Centralizado e de cima para baixo                                   ;
;;      BR = (Bottom Right) De baixo para cima e da direita para esquerda                       ;
;;      MR = (Middle Right) Do meio e da direita para esquerda                                  ;
;;      TR = (Top Right)    De cima para baixo e da direita para esquerda                       ;
;;                                                                                              ;
;;      Obs.: Refer�ncias ortogonais ao �ngulo do texto e a posi��o do cursor.                  ;
;;                                                                                              ;
;;==============================================================================================;


(defun tag_br ()
  (while  (or (setq ponto (getpoint (strcat
                                    "\CLIQUE NO PONTO DE INSER��O DA TAG ou [Esc] para cancelar<"
                                    TXTPREFX (itoa item) TXTSUFIX ">: "))))
      ;;(setq dim (getvar "dimscale")) 
        (command ".text" pTXT ponto dimx ang (strcat TXTPREFX (itoa item) TXTSUFIX )) 
          (setq item (1+ item))
  )
) 


(defun C:tagbr (/ i ponto s)
  
  (princ "\n***Pr�xis Engenharia - Fun��o de Tagueamento -> (Prefixo)(Numera��o)(Sufixo)***\n")
  
  (setq TXTPREFX (getstring "\Digite o Prefixo < >: "))

  (if (equal nil item) (setq item 1))
  (setq s (itoa item)) 
  (if (setq i (getint (strcat "\Inicio da Numera��o <" s ">: "))) 
     (setq item i)       
  )

  (setq TXTSUFIX (getstring "\Digite o Sufixo < >: "))

  (setq pTXT "BL")
  (initget "BL ML TL BC M TC BR MR TR")
  (setq pTXT (getkword "\Digite o estilo de inser��o (BL,ML,TL,BC,M,TC,BR,MR,TR) <BL>: "))
  (if (equal Nil pTXT) (setq pTXT "BL"))

  (setq dimx (getvar "dimscale"))
  (setq dimx (getreal (strcat"\Digite a altura do texto <" (rtos dimx) ">: ")))
  (if (equal nil dimx) (setq dimx (getvar "dimscale")))

  (setq ang 0)
  (setq ang (getreal (strcat"\Digite o �ngulo de rota��o <" (rtos 0) ">: ")))
  (if (equal nil ang) (setq ang 0))
  
  ;Layer
  ;Ponto de Ajuste do texto
  ;Altura do texto 
  ;�ngulo de rota��o do texto

  (tag_br)
  (princ)
)

;;==============================================================================================;