-- 1. Tạo view cho biết những mặt hàng chưa từng được bán trong năm 2021, bao gồm
-- mã hàng, tên hàng và giá bán 
Create view HangChuaBan_View
as
Select * from MatHang as M
where 
(M.MaHang not in
(select CT.MaHang KTTonKhoTimSPTimSP
from HDMuaHangChiTiet as CT
inner join HDMuaHang as HD on HD.MaHDMH=CT.MaHDMH
where year(HD.NgayMua)=2021)
and 
(M.MaHang not in
(select CTTG.MaHang 
from ChiTietHDTG as CTTG
inner join HoaDonTraGop as TG on TG.MaHDTG=CTTG.MaHDTG
where year(TG.NgayTraGop)=2021)
));
select * from HangChuaBan_View;

-- 2. Tạo view cho biết tất cả thông tin của những nhân viên thuộc bộ phận nhập hàng nhưng chưa nhập hàng bao giờ
create view NVChuaNhapHang_View
as
select *
from NhanVien
where 
(NhanVien.MaNV not in 
(select HoaDonNhap.MaNV
from HoaDonNhap)
and 
(NhanVien.MaBP in 
(select BoPhan.MaBP from BoPhan
where BoPhan.TenBP= 'Nhập hàng')))
; 
select * from NVChuaNhapHang_View;
-- 3. Tạo view cho biết thông tin chi tiết về hóa đơn nhập bao gồm mã hóa đơn, mã nhân viên, ngày nhập, mã hàng, đơn giá,
-- số lượng, thành tiền được sắp xếp theo ngày trong tháng 10
create view HoaDonNhap_View
as
select H.MaHDNhap,H.MaNV, H.NgayNhap, C.MaHang, C.DonGia,C.SoLuong,C.DonGia*C.SoLuong as ThanhTien
from HoaDonNhap as H
inner join ChiTietHDN as C
on C.MaHDNhap=H.MaHDNhap
where month(NgayNhap)=10 order by (NgayNhap);
select*from HoaDonNhap_View;
-- 4. In ra thông những khách hàng đã mua hàng trong tháng 7 với phương thức trả góp (mã, tên, ngày sinh, địa chỉ, số điện thoại)


Create view KhachHangMua_View
as
select * from KhachHang
where KhachHang.MaKH
in (select MaKH from
HoaDonTraGop where month(HoaDonTraGop.NgayTraGop)=7);
select * from KhachHangMua_View ;
-- 5. Tạo view cho biết tất cả thông tin của hóa đơn mua hàng chi tiết từ đâu năm đến bây giờ 
-- (Mã, Mã Nhân Viên,Mã Khách Hàng ngày mua, mã hàng, số lượng, đơn giá, mã giảm giá, thành tiền
-- quà tặng và mã bảo hành)
Create view HoaDonMua_View 
as
select H.MaHDMH,H.MaNV,H.MaKH, H.NgayMua, C.MaHang, C.SoLuong,M.GiaBan,C.MaGiamGia,(C.SoLuong*M.GiaBan)*(100-C.MaGiamGia)/100 as ThanhTien, C.QuaTang,H.MaBaoHanh
from 
HDMuaHang as H
inner join HDMuaHangChiTiet as C
on H.MaHDMH=C.MaHDMH
inner join MatHang as M
on M.MaHang=C.MaHang;
select * from HoaDonMua_View;
drop view HoaDonMua_View;
-- 6. Tạo view cho biết thông tin của hóa đơn trả góp, bao gồm (Mã Hóa Đơn, Mã Nhân viên, mã khách hàng,
-- Ngày bắt đầu trả góp, Mã hàng, số lượng, thành tiền, thời hạn trả, phần trăm trả trước, 
-- tiền hàng tháng cần trả
Create view HoaDonTG_View
as
select H.MaHDTG,H.MaNV,H.MaKH, H.NgayTraGop, C.MaHang, C.SoLuong,M.GiaBan,C.MaGiamGia,(C.SoLuong*M.GiaBan)*(100-C.MaGiamGia)/100 as ThanhTien, 
C.ThoiHanTra,C.PhanTramTraTruoc,C.TienHangThang, H.MaBaoHanh
from HoaDonTraGop as H
inner join ChiTietHDTG as C
on H.MaHDTG=C.MaHDTG
inner join MatHang as M
on M.MaHang=C.MaHang;
drop view HoaDonTG_View;
select * from HoaDonTG_View;
