import cv2
import subprocess
import numpy as np

# Inicia a câmera usando libcamera-vid e escreve para stdout
cmd = "libcamera-vid -t 0 --inline -n --width 640 --height 480 --framerate 30 --codec yuv420 --output -"
pipe = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)

# Definir o tamanho do frame (640x480 com 1.5 bytes por pixel no formato YUV420)
frame_size = int(640 * 480 * 1.5)

while True:
    raw_data = pipe.stdout.read(frame_size)
    if len(raw_data) != frame_size:
        break
    
    # Converter YUV420 para RGB
    yuv_frame = np.frombuffer(raw_data, dtype=np.uint8).reshape((int(640 * 1.5), 480))
    frame = cv2.cvtColor(yuv_frame, cv2.COLOR_YUV2BGR_I420)

    # Mostrar a imagem
    cv2.imshow("Camera", frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cv2.destroyAllWindows()
pipe.terminate()
