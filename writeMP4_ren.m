function writeMP4_ren(filename,mov)
    obj = VideoWriter(filename,'MPEG-4');
    open(obj);
    writeVideo(obj,mov);
    close(obj);
end