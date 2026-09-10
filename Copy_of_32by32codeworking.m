% --- MATLAB Laser Image Sender (128-byte 1-bpp Monochrome for 32x32) ---
stm32_port = 'COM6'; % Your COM port
baud_rate = 115200;
image_filename = 'converted-image.jpg';

% 1. Read the image and check for transparency (alpha channel)
[img, ~, alpha] = imread(image_filename);

% 2. If it has a transparent background, flatten it onto a White background
if ~isempty(alpha)
    img = double(img) / 255;
    alpha = double(alpha) / 255;
    for c = 1:size(img,3)
        img(:,:,c) = img(:,:,c) .* alpha + 1.0 .* (1 - alpha);
    end
    img = uint8(img * 255);
end

% 3. Convert to grayscale
if size(img, 3) >= 3
    img = rgb2gray(img(:, :, 1:3));
end

% 4. Resize image to exactly 32x32
img = imresize(img, [32, 32]);

% 5. Convert to binary (Black & White) using a high threshold 
% 0.8 ensures light gray/shrunken lines turn Black instead of disappearing into White.
img_bw = imbinarize(img, 0.8); 

figure;
imshow(img_bw);
title('Transmitting: 32x32 Binary');

% 6. Pack 1024 pixels into exactly 128 bytes
payload = zeros(128, 1, 'uint8'); 
k = 1;
for r = 1:32 % 32 rows
    for byteCol = 1:4 % 4 bytes per row (4 * 8 = 32 pixels)
        byteVal = uint8(0);
        for bit = 0:7
            c = (byteCol - 1) * 8 + bit + 1;
            if img_bw(r, c)
                byteVal = bitset(byteVal, 8 - bit);
            end
        end
        payload(k) = byteVal;
        k = k + 1;
    end
end

% 7. Connect to STM32 and Send
disp(['Connecting to STM32 on ', stm32_port, '...']);
try
    s = serialport(stm32_port, baud_rate);
    pause(2);
catch ME
    disp(['Failed to connect: ', ME.message]);
    return;
end

disp('Sending 128 bytes to the STM32 Bridge...');
write(s, payload, 'uint8');
disp('Data sent! The laser transmission will take roughly 55 seconds.');
clear s;