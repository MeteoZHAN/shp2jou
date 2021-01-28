clear
clc

shp = shaperead('JieQu.shp'); %读取建筑shp文件

%% 写入.jou文件
fid = fopen('command.jou','w+');
count_point = 0;
mark(1,1) = 0;
r = 2;
for i = 1 : 156
    x = shp(i).X*110000; % unit:m
    y = shp(i).Y*110000; % unit:m
    plot(shp(i).X,shp(i).Y)
    for j = 1 : length(x)-2
        fprintf(fid,'vertex create coordinates %d %d %d\n',x(j),y(j),0); % 绘制点命令
        count_point = count_point + 1;
    end
    mark(r,1) = count_point;
    r = r + 1;
end

for i = 1: length(mark)-1
    for jj = mark(i,1)+1 : mark(i+1,1)-1
        fprintf(fid,'edge create straight "vertex.%d" "vertex.%d"\n',jj,jj+1); % 绘制线命令
        if jj == mark(i+1,1)-1
            fprintf(fid,'edge create straight "vertex.%d" "vertex.%d"\n',mark(i,1)+1,jj+1); % 连接首尾点命令
        end
    end
end

fclose(fid);
