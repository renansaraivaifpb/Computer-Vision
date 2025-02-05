vid = VideoReader("RoadTraffic.mp4");
vidWr = VideoWriter("RoadTrafficFiltered","MPEG-4");
vidWr.FrameRate = vid.FrameRate;
open(vidWr);

while hasFrame(vid)
 % Read a frame
 frame = readFrame(vid);
 % Remove noise using a 2D median filter
 frame(:,:,1) = medfilt2(frame(:,:,1));
 frame(:,:,2) = medfilt2(frame(:,:,2));
 frame(:,:,3) = medfilt2(frame(:,:,3));
 % Convert to grayscale
 frame = im2gray(frame);
 frame = imgaussfilt(frame);
 F = fspecial("average",6);
 frame = imfilter(frame, F);
 % Write frame to new video
 writeVideo(vidWr,frame);
end
close(vidWr);

vid = VideoReader("RoadTraffic.mp4");
backImg = readFrame(vid);
backImg = im2gray(backImg);
backImg = im2double(backImg);

AreaRegion = [];

vidWr2 = VideoWriter("Rotulado","MPEG-4");
vidWr2.FrameRate = vid.FrameRate;

open(vidWr2); % Abrindo o objeto de escrita de vídeo

while hasFrame(vid)
    % Read a frame (RGB)
    frame = readFrame(vid);
    
    % Aplicar filtro de ruído na imagem RGB
    frame(:,:,1) = medfilt2(frame(:,:,1));
    frame(:,:,2) = medfilt2(frame(:,:,2));
    frame(:,:,3) = medfilt2(frame(:,:,3));

    % Criar uma cópia em escala de cinza apenas para processamento
    grayFrame = im2gray(frame);

    % Aplicar filtro de suavização na imagem em escala de cinza
    F = fspecial("average",6);
    grayFrame = imfilter(grayFrame, F);

    % Segmentação dos carros a partir da imagem em escala de cinza
    mask = justCarWhite(grayFrame);
    
    % Filtrar regiões pequenas
    mask = bwpropfilt(mask, 'Area', [1200, 24000]);
    
    % Obter propriedades das regiões
    props = regionprops("table", mask, "BoundingBox");
    
    % Desenhar caixas delimitadoras na imagem RGB original
    if ~isempty(props) 
        frame = insertShape(frame, "Rectangle", props.BoundingBox, "Color", "red", "LineWidth", 5);
    end
    
    % Escrever o frame processado no vídeo mantendo RGB
    writeVideo(vidWr2, frame);
    
    imshow(frame); % Exibir frame colorido com detecção
end

close(vidWr2); % Fechar o arquivo de vídeo corretamente


carData = table(AreaRegion)

