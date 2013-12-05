function setFontSize(fsize)
    set(gca,'fontsize',fsize);
    set(get(gca,'xlabel'),'fontsize',fsize)
    set(get(gca,'ylabel'),'fontsize',fsize)
    set(get(gca,'title'),'fontsize',fsize)
end