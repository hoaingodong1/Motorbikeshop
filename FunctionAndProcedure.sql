CREATE DEFINER=`root`@`localhost` FUNCTION `TongNVBP`(MaBoPhan varchar(5)) RETURNS int(11)
BEGIN
	return
    (select count(MaNV) from 
    NhanVien
    where MaBoPhan=NhanVien.MaBP
    group by (MaBP)
    );
END
CREATE DEFINER=`root`@`localhost` FUNCTION `TimGiaSP`(IdMatHang varchar(5)) RETURNS decimal(15,2)
BEGIN

RETURN 
(select GiaBan from MatHang
where MatHang.MaHang=IdMatHang);
END
CREATE DEFINER=`root`@`localhost` FUNCTION `KTHangTonKho`(IDHang varchar(5)) RETURNS int(11)
BEGIN
	declare tong int;
    if IDHang in (select MaHang from ChiTietHDN) then
		set tong = (select C.SoLuong-H.SoLuong
		from ChiTietHDN as C, HDMuaHangChiTiet as H
		where C.MaHang=H.MaHang and C.MaHang=IDHang);
	end if;
    if IDHang in (select MaHang from ChiTietHDTG) then
		set tong = (select C.SoLuong-H.SoLuong
		from ChiTietHDTG as C, HDMuaHangChiTiet as H
		where C.MaHang=H.MaHang and C.MaHang=IDHang);
	end if; 
    if tong is null then 
		set tong = (select C.SoLuong from 
        ChiTietHDN as C
        where C.MaHang=IDHang);
	end if;
RETURN tong;
END
CREATE DEFINER=`root`@`localhost` FUNCTION `DoanhThu`(nam int, thang int) RETURNS decimal(25,2)
BEGIN
	return (select sum(ThanhTien)
    from HoaDonMua_View
    where year(HoaDonMua_View.NgayMua)=nam
    and month(HoaDonMua_View.NgayMua)=thang);
END
CREATE DEFINER=`root`@`localhost` PROCEDURE `TinhTienTraGop`()
BEGIN
	update HoaDonTG_View
    set TienHangThang=ThanhTien*(100-PhanTramTraTruoc)/100/12
    +ThanhTien*(100-PhanTramTraTruoc)/100*3.4/100;
END
CREATE DEFINER=`root`@`localhost` PROCEDURE `TinhLuong`()
BEGIN
	update NhanVien
    inner join HoaDonMua_View
    on HoaDonMua_View.MaNV=NhanVien.MaNV
    set Luong = Luong + ThanhTien*2/100;
END
CREATE DEFINER=`root`@`localhost` PROCEDURE `TimSanPhamTheoGia`(IN GiaThapNhat DECIMAL(15,2), IN GiaCaoNhat DECIMAL(15,2))
begin
SELECT * from MatHang
where MatHang.GiaBan BETWEEN GiaThapNhat and GiaCaoNhat;
end
CREATE DEFINER=`root`@`localhost` PROCEDURE `SanPhamCuaNCC`(IdNCC varchar(5))
BEGIN
	select* from
    MatHang
    where MatHang.MaNCC=IdNCC;
END
CREATE DEFINER=`root`@`localhost` PROCEDURE `QuaTang`()
BEGIN
	update HDMuaHangChiTiet as C
    join HDMuaHang as H
    on H.MaHDMH=C.MaHDMH
    join KhachHang as K
    on K.MaKH=H.MaKH
    set QuaTang='Mũ bảo hiểm, Áo khoác, Voucher'
    where month(K.NgaySinh)=month(H.NgayMua);
    update HDMuaHangChiTiet as C
    set QuaTang='Mũ bảo hiểm'
    where C.QuaTang is null;
END
CREATE DEFINER=`root`@`localhost` PROCEDURE `MaGiamGia`()
BEGIN
	update HDMuaHangChiTiet as C
    join HDMuaHang as H
    on H.MaHDMH=C.MaHDMH
    join KhachHang as K
    on K.MaKH=H.MaKH
    set MaGiamGia=5
    where month(K.NgaySinh)=month(H.NgayMua);
    update HDMuaHangChiTiet as C
    set MaGiamGia=0
    where C.MaGiamGia is null;
    
    update ChiTietHDTG as C
    join HoaDonTraGop as H
    on H.MaHDTG=C.MaHDTG
    join KhachHang as K
    on K.MaKH=H.MaKH
    set MaGiamGia=5
    where month(K.NgaySinh)=month(H.NgayTraGop);
    update ChiTietHDTG as C
    set MaGiamGia=0
    where C.MaGiamGia is null;
    

END
CREATE DEFINER=`root`@`localhost` PROCEDURE `HoaDonKhachHang`(IdKH varchar(5))
BEGIN
	select * from HoaDonMua_View
    where HoaDonMua_View.MaKH=IdKH;
    select * from HoaDonTG_View
	where HoaDonTG_View.MaKH=IdKH;
END
CREATE TRIGGER `KTPhanTramTraGop` BEFORE INSERT ON `chitiethdtg`
 FOR EACH ROW if new.PhanTramTraTruoc <20 or new.PhanTramTraTruoc > 70 then 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Phần trăm trả trước phải lớn hơn 20 và nhỏ hơn 70 %';
end IF
CREATE TRIGGER `ChenBaoHanh` AFTER INSERT ON `hdmuahang`
 FOR EACH ROW insert into BaoHanh
values(new.MaBaoHanh,new.MaKH,'12 tháng',new.NgayMua,'Chỉ bảo hành do lỗi của nhà sản xuất')
CREATE TRIGGER `KiemTraNgay` BEFORE INSERT ON `hoadonnhap`
 FOR EACH ROW if new.NgayNhap>now() then 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'nhap ngay qua voi ngay hien tai';
end IF