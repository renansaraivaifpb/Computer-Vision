import cv2
import subprocess
import numpy as np

# Inicia a captura da câmera usando libcamera-vid com saída MJPEG
cmd = "libcamera-vid -t 0 --inline -n --width 640 --height 480 --framerate 30 --codec mjpeg --output -"
pipe = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

# Loop de captura de frames
while True:
    # Lê os dados brutos da saída do pipe
    raw_data = pipe.stdout.read(640 * 480 * 3)  # 3 bytes por pixel para MJPEG
    if len(raw_data) == 0:
        break

    # Converte os dados brutos em um array numpy
    frame = np.frombuffer(raw_data, dtype=np.uint8)

    # Decodifica o frame MJPEG
    frame = cv2.imdecode(frame, cv2.IMREAD_COLOR)

    if frame is not None:
        # Exibe o frame
        cv2.imshow("Camera", frame)

        # Verifica se a tecla 'q' foi pressionada para sair
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

# Libera os recursos
cv2.destroyAllWindows()
pipe.terminate()
