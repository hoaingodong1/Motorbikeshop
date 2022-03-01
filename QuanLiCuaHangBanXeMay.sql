CREATE DATABASE QuanLiCuaHangXeMay;
USE QuanLiCuaHangXeMay;

-- Các Cơ Sở của của cửa hàng
CREATE TABLE CoSo(
MaCoSo varchar(5) primary key,
TenCoSo varchar(30),
DiaChi varchar(70),
SoDT varchar(12));
INSERT INTO CoSo
VALUES 
('CoSo1','Cửa hàng Quốc Tiến','21 Lý Thái Tổ Thạc Gián - Thanh Khê - Đà Nẵng','0931929524'),
('CoSo2','Cửa hàng Tiến Thu','179 Phan Chu Trinh - Phước Ninh - Hải Châu - Đà Nẵng','0235854563'),
('CoSo3','Cửa hàng Hiếu Nga','296 Nguyễn Văn Linh - Đà Nẵng','0893254127');
-- Bảng bộ phận. Gồm có bán hàng, nhập hàng, CSKH, bảo hành sữa chữa, Nhân Viên trả góp
CREATE TABLE BoPhan
(
MaBP varchar(5) primary key,
TenBP varchar(30));
INSERT INTO BoPhan
VALUES 
('BP1','Chăm sóc khách hàng'),
('BP2','Bán hàng'),
('BP3','Nhập hàng'),
('BP4','Bảo hành sữa chữa');
 
-- Bảng Nhân Viên
-- Thêm procedure nếu nhân viên bán được hàng thì sẽ được ăn theo hoa hồng. Ví dụ như 10% sản phẩm bán được
CREATE TABLE NhanVien(
MaNV varchar(5) primary key,
TenNV varchar(30),
GioiTinh enum('Nam','Nữ','Khác'),
NgaySinh date,
SoDT varchar(12),
Email varchar(30),
DiaChi varchar(50),
Luong Decimal(10,2),
MaBP varchar(5),
MaCoSo varchar(5), -- Cơ sở làm việc của nhân viên đó
foreign key (MaCoSo) references CoSo(MaCoSo),
foreign key (MaBP) references BoPhan(MaBP) -- Khóa ngoại
);
INSERT INTO NhanVien
VALUES 
('NV1','Nguyễn Thị Ngọc Linh','Nữ','2002-06-09','0398521254','ngoclinhdangiu@gmail.com','101B Lê Hữu Trác, Sợn Trà',12000000,'BP1','CoSo1'),
('NV2','Hồ Thị Phượng','Nữ','2002-08-10','0398520154','hothiphuong@gmail.com','99 Tô Hiến Thành, Sơn Trà',10000000,'BP2','CoSo1'),
('NV3','Đàm Long Thiên','Nam','2002-05-12','0898523254','longthien@gmail.com','12 Cao Thắng, Hải Châu',1000000,'BP3','CoSo1'),
('NV4','Hoàng Tuấn Minh','Nam','2001-07-15','0234526871','tuanminhcute@gmail.com','08 Tiểu La, Hải Châu',8000000,'BP4','CoSo1'),
('NV5','Ngô Thị Luyên','Nữ','2002-07-10','0789251211','ngoluyen@gmail.com','09 Âu Cơ, Liên Chiểu',15000000,'BP1','CoSo1'),

('NV6','Đinh Thị Mỹ Tâm','Nữ','2002-05-07','0526895254','tamxindtcute@gmail.com','09 Hoàng Sa, Sơn Trà',7000000,'BP1','CoSo2'),
('NV7','Nguyễn Thị Khánh Linh','Nữ','2002-11-05','0235988125','khanhlinh@gmail.com','10 Hoài Thanh, Sơn Trà',6000000,'BP2','CoSo2'),
('NV8','Nguyễn Thị Tuyết Giang','Nữ','2002-03-05','0788521254','tuyetgiang@gmail.com','11 Lê Đại Hành, Cẩm Lệ',12000000,'BP3','CoSo2'),
('NV9','Hồ Quốc Trí','Nam','2002-08-09','0988524247','trihoquoc@gmail.com','12 Xô Viết Nghệ Tĩnh, Cẩm Lệ',14000000,'BP4','CoSo2'),
('NV10','Nguyễn Thanh Lâm','Nam','2002-03-02','0958521234','thanhlam@gmail.com','101 Lê Lợi, Thanh Khê',12000000,'BP2','CoSo2'),

('NV11','Ngô Thị Mỹ Hoài','Nữ','2002-11-29','0931950257','hoaingodong1@gmail.com','12 Nguyễn Du, Hải Châu',17000000,'BP1','CoSo3'),
('NV12','Ngô Đức Bảo','Nam','1998-04-12','0896521234','baocute123@gmail.com','50 Lý Tự Trọng, Hải Châu',15000000,'BP2','CoSo3'),
('NV13','Ngô Thị Hồng','Nữ','2002-10-01','0871235462','hongngodong@gmail.com','20 Hải Phòng, Thanh Khê',11000000,'BP3','CoSo3'),
('NV14','Ngô Thị Gạo','Nữ','2002-09-01','0915445554','gaodtnhat@gmail.com','30 Tố Hữu, Liên Chiểu', 7000000,'BP4','CoSo3'),
('NV15','Ngô Thị Mỹ Bơ','Nữ','2000-11-12','0245787877','bodethuong@gmail.com','20 Ngô Quyền, Sơn Trà',6000000,'BP3','CoSo3');

-- Bảng Khách Hàng
CREATE TABLE KhachHang(
MaKH varchar(5) primary key,
TenKH varchar(30),
NgaySinh date,
DiaChi varchar(70),
SoDT varchar(12)
);
INSERT INTO KhachHang(MaKH,TenKh,NgaySinh,DiaChi,SoDT)
VAlUES 
('KH1','Nguyễn Quốc Đạt','2001-08-12','99 Tô Hiến Thành','0125987215'),
('KH2','Hồ Thị Duyệt','1998-02-23','98 Tô Hiến Thành','0235256125'),
('KH3','Hồ Thị Ngọc Ánh','1998-02-03','22 Lê Hữu Trác','0235127417'),
('KH4','Đặng Xuân Vinh','2002-05-06','98 Tố Hữu, Liên Chiểu','0235442245'),
('KH5','Phạm Lê Thanh Vũ','2003-02-04','15 Tiểu La, Hải Châu','02354155411'),
('KH6','Lê Văn Lập','2000-12-04','10 Âu Cơ, Liên Chiểu','02354155411'),
('KH7','Nguyễn Thị Mỹ Linh','2001-10-04','02 Phan Chu Trinh, Hải Châu','02354155411'),
('KH8','Đoàn Thị Mỹ Hạnh','1988-08-02','10 Âu Cơ, Liên Chiểu','02354155411'),
('KH9','Hồ Thị Nguyệt','2000-01-04','123 Nguyễn Văn Linh, Sơn Trà','02354155411'),
('KH10','Nguyễn Thảo Nguyên','2000-10-05','15 Âu Cơ, Liên Chiểu','02354155411');
select * from KhachHang;
-- Bảng nhà cung cấp
CREATE TABLE NhaCungCap (
MaNCC varchar(5) primary key,
TenNCC varchar(30),
DiaChi varchar(50),
SoDT varchar(12)
);
INSERT INTO NhaCungCap
VALUES 
('NCC1','Công ty Hoài An','56 Lê Đình Lý, Thanh Khê','0254141236'),
('NCC2','Công ty Phát Đạt','12 Nguyễn Lương Bằng, Liên Chiểu','0232444401'),
('NCC3','Công ty Hoàng Gia','19 Tôn Đản, Cẩm Lệ','0235112454');
-- Bảng loại hàng. Xe máy hay phụ tùng xe máy. 
CREATE TABLE LoaiHang(
MaLoai varchar(5) primary key,
TenLoai varchar(30));

INSERT INTO LoaiHang
VALUES 
('ML1','Xe máy'),
('ML2','Phụ tùng');
-- Bảng mặt hàng, xe gì, phụ tùng gì
CREATE TABLE MatHang (
MaHang varchar(5) primary key,
MaLoai varchar(5),
TenHang varchar(40),
GiaBan decimal(15,2),
MaNCC varchar(5),
FOREIGN KEY (MaLoai) references LoaiHang(MaLoai),
Foreign key (MaNCC) references NhaCungCap(MaNCC)
);
INSERT INTO MatHang
VALUES 
('MH1','ML1','Honda Vario 2021',120000000.00,'NCC1'),
('MH2','ML1','Honda Lead 2021',100000000.00,'NCC1'),
('MH3','ML1','Honda Vision 2021',80000000.00,'NCC1'),
('MH4','ML1','Honda AirBlack 150 2020',70000000.00,'NCC2'),
('MH5','ML1','Yamaha Exciter 150 2021',60000000.00,'NCC2'),
('MH6','ML1','Honda Winner 150',30000000.00,'NCC2'),
('MH7','ML1','Honda Sh Mode 125',89000000.00,'NCC3'),
('MH8','ML1','Honda Wave Alpha 2020',40000000.00,'NCC3'),
('MH9','ML1','Yamaha Sirius 2021',35000000.00,'NCC3'),
('MH10','ML1','Vespa Sprint 2020',85000000.00,'NCC3'),

('MH11','ML2','Gác chân sau',550000.00,'NCC1'),
('MH12','ML2','Bao tay Ariete chính hãng 61/SSF',450000.00,'NCC1'),
('MH13','ML2','Nhớt Speed Master Pro Bike',1200000.00,'NCC1'),
('MH14','ML2','Nhông sên đĩa DID vàng',400000.00,'NCC2'),
('MH15','ML2','Vỏ Michellin 90/90',300000.00,'NCC2'),
('MH16','ML2','Bộ thắng đĩa xe Winner',410000.00,'NCC2'),
('MH17','ML2','Dây Curoa Lead',800000.00,'NCC3'),
('MH18','ML2','Dĩa tải Akei',1500000.00,'NCC3'),
('MH19','ML2','Ắc quy xe máy',3000000.00,'NCC3');

-- Bảng hóa đơn nhập
CREATE TABLE HoaDonNhap(
MaHDNhap varchar(5) primary key,
NgayNhap date,
MaNV varchar(5),
ChuThich varchar(50),
FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV) 
);

INSERT INTO HoaDonNhap
VALUES 
('HDN1','2021-08-09','NV3',''),
('HDN2','2021-05-06','NV8',''),
('NDN3','2021-06-01','NV13',''),
('NDN4','2021-01-30','NV13',''),
('NDN5','2021-07-07','NV3',''),
('NDN6','2021-10-15','NV8',''),
('NDN7','2021-10-11','NV13',''),
('NDN8','2021-08-12','NV3',''),
('NDN9','2021-10-20','NV3',''),
('NDN10','2021-07-25','NV8',''),
('HDN11','2021-01-02','NV3',''),
('HDN12','2021-05-07','NV8',''),
('NDN13','2021-07-08','NV13',''),
('NDN14','2021-09-30','NV8',''),
('NDN15','2021-02-27','NV3',''),
('NDN16','2021-10-17','NV8',''),
('NDN17','2021-11-11','NV13',''),
('NDN18','2021-02-17','NV13',''),
('NDN19','2021-04-08','NV3','');
Create table ChiTietHDN(
MaHDNhap varchar(5),
MaHang varchar(5),
DonGia decimal(15,2),
SoLuong int, -- Tạo query để tính tổng tiền hoặc bỏ thêm cột thành tiền rồi cho queri
FOREIGN KEY (MaHDNhap) references HoaDonNhap(MaHDNhap),
FOREIGN KEY (Mahang) references MatHang(MaHang)
);

INSERT INTO ChiTietHDN
Values 
('HDN1','MH1',100000000.00,5),
('HDN2','MH2',80000000.00,2),
('NDN3','MH3',75000000.00,3),
('NDN4','MH4',65000000.00,7),
('NDN5','MH5',50000000.00,3),
('NDN6','MH6',25000000.00,6),
('NDN7','MH7',84000000.00,1),
('NDN8','MH8',36000000.00,4),
('NDN9','MH9',32000000.00,2),
('NDN10','MH10',84000000,2),
('HDN11','MH11',500000.00,20),
('HDN12','MH12',400000.00,10),
('NDN13','MH13',1000000.00,2),
('NDN14','MH14',300000.00,3),
('NDN15','MH15',200000.00,5),
('NDN16','MH16',380000.00,6),
('NDN17','MH17',700000.00,2),
('NDN18','MH18',1200000,3),
('NDN19','MH19',1400000,4);

CREATE TABLE HDMuaHang(
MaHDMH varchar(5) primary key,
MaNV varchar(5),
MaKH varchar(5),
NgayMua date,
MaBaoHanh varchar(5),
foreign key (MaNV) references NhanVien(MaNV),
foreign key (MaKH) references KhachHang(MaKH) 
);
select* from hdmuahang;
INSERT INTO HDMuaHang
VALUES 
('HDM1','NV2','KH1','2021-08-09','BH1'),
('HDM2','NV7','KH2','2021-05-06','BH2'),
('HDM3','NV10','KH3','2021-04-10','BH3'),
('HDM4','NV12','KH4','2021-01-02','BH4'),
('HDM5','NV2','KH5','2021-05-08','BH5'),
('HDM6','NV7','KH6','2021-12-12','BH6');
CREATE TABLE HDMuaHangChiTiet(
MaHDMH varchar(5),
MaHang varchar(5),
SoLuong int,
MaGiamGia Decimal(5,2),
QuaTang varchar(50)
); 
ALTER TABLE HDMuaHangChiTiet ADD FOREIGN KEY (MaHDMH) REFERENCES HDMuaHang(MaHDMH);
ALTER TABLE HDMuaHangChiTiet ADD FOREIGN KEY (MaHang) REFERENCES MatHang(MaHang);

INSERT INTO HDMuaHangChiTiet(MaHDMH,MaHang,SoLuong)
VALUES
('HDM1','MH1',1),
('HDM2','MH2',1),
('HDM3','MH3',1),
('HDM4','MH4',1),
('HDM5','MH11',2),
('HDM6','MH15',2);

CREATE TABLE HoaDonTraGop(
MaHDTG varchar(5) primary key,
MaNV varchar(5),
MaKH varchar(5),
NgayTraGop date,
MaBaoHanh varchar(5),
foreign key (MaNV) references NhanVien(MaNV),
foreign key (MaKH) references KhachHang(MaKH) 
);

INSERT INTO HoaDonTraGop
VALUES
('HDTG1','NV2','KH7','2021-01-01','HD7'),
('HDTG2','NV7','KH8','2021-07-08','HD8'),
('HDTG3','NV10','KH9','2021-11-20','HD9'),
('HDTG4','NV12','KH10','2021-10-15','HD10');
-- Vì mua trả góp nên không có quà tặng gì cả, chỉ có mã giảm giá nếu có thôi
Create table ChiTietHDTG(
MaHDTG varchar(5),
MaHang varchar(5), 
SoLuong int,
MaGiamGia Decimal(5,2),
ThanhTien Decimal(10,2),
ThoiHanTra enum("3 tháng","6 tháng","9 tháng", "12 tháng","18 tháng"),
PhanTramTraTruoc decimal(5,2), 
TienHangThang decimal(10,2),
FOREIGN KEY (MaHDTG) REFERENCES HoaDonTraGop(MaHDTG),
FOREIGN KEY (MaHang) REFERENCES MatHang(MaHang)
);

insert into ChiTietHDTG(MaHDTG,MaHang,SoLuong,ThoiHanTra,PhanTramTraTruoc)
values
('HDTG1','MH7',1,'6 tháng',30.00),
('HDTG2','MH8',1,'9 tháng',50.00),
('HDTG3','MH9',1,'12 tháng',40.00),
('HDTG4','MH10',1,'18 tháng',35.00);

Create table BaoHanhnhacungcapnhacungcap
(
MaBH varchar(5),
MaKH varchar(5),
ThoiHanBH varchar(20),
NgayBatDau date,
DienGiai varchar(50)
-- Cái này cho thủ tục, tùy vào giá của xe, của linh kiện, sao cho hợp lí 
)







