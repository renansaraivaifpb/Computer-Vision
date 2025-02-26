import cv2
import numpy as np

# Inicializa a câmera
cap = cv2.VideoCapture(0)
cap.set(cv2.CAP_PROP_FRAME_WIDTH, 320)  # Resolução baixa para aliviar o Pi
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 240)
cap.set(cv2.CAP_PROP_FPS, 15)  # 15 FPS para desempenho

while True:
    ret, frame = cap.read()
    if not ret:
        print("Erro ao capturar o frame!")
        break

    # Imagem original
    original = frame.copy()

    # Converter para grayscale
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # Aplicar filtro GaussianBlur para reduzir ruído (útil antes do Canny)
    blur = cv2.GaussianBlur(gray, (5, 5), 0)

    # Filtro Canny para detecção de bordas
    canny = cv2.Canny(blur, 50, 150)

    # Threshold simples para binarização
    _, thresh = cv2.threshold(blur, 100, 255, cv2.THRESH_BINARY)

    # Exibir as janelas
    cv2.imshow("Original", original)
    cv2.imshow("Grayscale", gray)
    cv2.imshow("Canny", canny)
    cv2.imshow("Threshold", thresh)

    # Posicionar as janelas manualmente (ajuste conforme sua tela)
    cv2.moveWindow("Original", 0, 0)       # Canto superior esquerdo
    cv2.moveWindow("Grayscale", 330, 0)    # À direita da original
    cv2.moveWindow("Canny", 660, 0)        # Mais à direita
    cv2.moveWindow("Threshold", 990, 0)    # Última janela

    # Sair com a tecla 'q'
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Libera a câmera e fecha as janelas
cap.release()
cv2.destroyAllWindows()
