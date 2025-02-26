import cv2

# Define o pipeline do GStreamer
pipeline = (
    "libcamerasrc ! video/x-raw,width=640,height=480,framerate=30/1 ! "
    "videoconvert ! appsink"
)

# Inicia a captura de vídeo
cap = cv2.VideoCapture(pipeline, cv2.CAP_GSTREAMER)

if not cap.isOpened():
    print("Erro ao abrir a câmera.")
    exit()

while True:
    ret, frame = cap.read()
    if not ret:
        break

    # Exibe o frame
    cv2.imshow("Camera", frame)

    # Verifica se a tecla 'q' foi pressionada para sair
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Libera os recursos
cap.release()
cv2.destroyAllWindows()
