;;==============================================================================================;
;; tagbr.lsp                                                                                    ;
;;                                                                                              ;
;; Função de Tagueamento em Autolisp                                                            ;
;; Artefato originado de pesquisa e desenvolvimento                                             ;
;; para Práxis Engenharia e                                                                     ;
;; sem limites de uso.                                                                          ; 
;; Copyrigth 2012 - Sérgio Pereira                                                              ;
;; sergiopereira.br@hotmail.com                                                                 ;
;; Rio de Janeiro - Outubro de 2012                                                             ;
;;                                                                                              ;
;;==============================================================================================;
;;                                                                                              ;
;; Como utilizar esta função no AUTOCAD:                                                        ;
;;                                                                                              ;
;; a) Na linha de comando digite 'appload' e carregue este arquivo                              ;
;;    (tagbr.lsp) na pasta em que se encontra;                                                  ;
;;                                                                                              ;
;; b) Ativar o layer de trabalho e na linha de comando digite 'tagbr' para chamar esta função;  ;
;;                                                                                              ;
;; c) Siga o procedimento solicitado na linha de comando passo-a-passo para formar e formatar   ;
;;    a Tag:                                                                                    ;
;;                                                                                              ;
;;    i   - Informe o texto da parte fixa da Tag antes da numeração serial, se existir;         ;
;;                                                                                              ;
;;    ii  - Informe o valor do primeiro número da parte serial da tag, se não for 1;            ;
;;                                                                                              ;
;;    iii - Informe o texto da parte fixa da Tag, se necessário finalizando a Tag;              ;
;;                                                                                              ;
;; d) Altere a posição de inserção do texto em relação ao cursor, se precisar adequar;          ;
;;                                                                                              ;
;; e) Altere o tamanho da letra do texto, conforme a necessidade;                               ;
;;                                                                                              ;
;; f) Altere o ângulo de inclinação do texto, para uma melhor apresentação;                     ;
;;                                                                                              ;
;; g) Posicione o cursor no ponto desejado do desenho e clique com o botão esquerdo do          ;
;;    mouse para inserir a TAG repetindo este item até o término desse processo, para isso      ;
;;    tecle 'esc' ou 'enter' encerrando essa função.                                            ;
;;                                                                                              ;
;;==============================================================================================;
;;                                                                                              ;
;;      NOTAS de estilos de inserção do texto:                                                  ;
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
;;      Obs.: Referências ortogonais ao ângulo do texto e a posição do cursor.                  ;
;;                                                                                              ;
;;==============================================================================================;


(defun tag_br ()
  (while  (or (setq ponto (getpoint (strcat
                                    "\CLIQUE NO PONTO DE INSERÇÂO DA TAG ou [Esc] para cancelar<"
                                    TXTPREFX (itoa item) TXTSUFIX ">: "))))
      ;;(setq dim (getvar "dimscale")) 
        (command ".text" pTXT ponto dimx ang (strcat TXTPREFX (itoa item) TXTSUFIX )) 
          (setq item (1+ item))
  )
) 


(defun C:tagbr (/ i ponto s)
  
  (princ "\n***Práxis Engenharia - Função de Tagueamento -> (Prefixo)(Numeração)(Sufixo)***\n")
  
  (setq TXTPREFX (getstring "\Digite o Prefixo < >: "))

  (if (equal nil item) (setq item 1))
  (setq s (itoa item)) 
  (if (setq i (getint (strcat "\Inicio da Numeração <" s ">: "))) 
     (setq item i)       
  )

  (setq TXTSUFIX (getstring "\Digite o Sufixo < >: "))

  (setq pTXT "BL")
  (initget "BL ML TL BC M TC BR MR TR")
  (setq pTXT (getkword "\Digite o estilo de inserção (BL,ML,TL,BC,M,TC,BR,MR,TR) <BL>: "))
  (if (equal Nil pTXT) (setq pTXT "BL"))

  (setq dimx (getvar "dimscale"))
  (setq dimx (getreal (strcat"\Digite a altura do texto <" (rtos dimx) ">: ")))
  (if (equal nil dimx) (setq dimx (getvar "dimscale")))

  (setq ang 0)
  (setq ang (getreal (strcat"\Digite o ângulo de rotação <" (rtos 0) ">: ")))
  (if (equal nil ang) (setq ang 0))
  
  ;Layer
  ;Ponto de Ajuste do texto
  ;Altura do texto 
  ;Ângulo de rotação do texto

  (tag_br)
  (princ)
)

;;==============================================================================================;