function [ bz ] = jacConst_LGR_FD_B( bz, nb, nz, b, x0, xf, u0, uf, p, t0, tf, e, vdat, data )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

idx=data.FD.index.b;nfd=size(idx,2);
et0=e*data.FD.vector.b.et0;etf=e*data.FD.vector.b.etf;ep=e*data.FD.vector.b.ep;et=e.*data.FD.vector.b.et;
ex0=e*data.FD.vector.b.ex0;eu0=e*data.FD.vector.b.eu0;
exf=e*data.FD.vector.b.exf;euf=e*data.FD.vector.b.euf;

if data.options.adaptseg==1 
    for i=1:nfd
        t_segment_p=data.t_segment+et(i,:)';
        t_segment_m=data.t_segment-et(i,:)';
        bp=b(x0+ex0(:,i),xf+exf(:,i),u0+eu0(:,i),uf+euf(:,i),p+ep(:,i),t0+et0(:,i),tf+etf(:,i),vdat,data.options,t_segment_p);
        bm=b(x0-ex0(:,i),xf-exf(:,i),u0-eu0(:,i),uf-euf(:,i),p-ep(:,i),t0+et0(:,i),tf-etf(:,i),vdat,data.options,t_segment_m);
        bz=bz+sparse(1:nb,idx(:,i),(bp-bm)/(2*e),nb,nz);
    end
else
    for i=1:nfd
    bp=b(x0+ex0(:,i),xf+exf(:,i),u0+eu0(:,i),uf+euf(:,i),p+ep(:,i),t0+et0(:,i),tf+etf(:,i),vdat,data.options,[]);
    bm=b(x0-ex0(:,i),xf-exf(:,i),u0-eu0(:,i),uf-euf(:,i),p-ep(:,i),t0+et0(:,i),tf-etf(:,i),vdat,data.options,[]);
    bz=bz+sparse(1:nb,idx(:,i),(bp-bm)/(2*e),nb,nz);
    end
end



end

