-- Active: 1677135833192@@127.0.0.1@3306@btth01_cse485
--a
select baiviet.*, theloai.ten_tloai from baiviet, theloai
where baiviet.ma_tloai = theloai.ma_tloai
and theloai.ten_tloai like "Nhac tru tinh";

--b
select baiviet.*, tacgia.ten_tgia from baiviet, tacgia
where baiviet.ma_tgia = tacgia.ma_tgia
and tacgia.ten_tgia like "Nhacvietplus";

--c
select theloai.* from theloai
where theloai.ma_tloai not in (
    select baiviet.ma_tloai
    from baiviet
);



--d
select baiviet.ma_bviet, baiviet.tieude, baiviet.ten_bhat, tacgia.ten_tgia, theloai.ten_tloai, baiviet.ngayviet from baiviet, theloai, tacgia
where baiviet.ma_tgia = tacgia.ma_tgia and baiviet.ma_tloai = theloai.ma_tloai;

--e
select theloai.ten_tloai, count(*) as so_luong
from theloai
join baiviet
on baiviet.ma_tloai = theloai.ma_tloai
group by theloai.ma_tloai
having count(baiviet.ma_tloai) = (
select count(*) as so_luong
from theloai
left join baiviet
on baiviet.ma_tloai = theloai.ma_tloai
group by theloai.ten_tloai
order by so_luong DESC
limit 1
);


--f
select tacgia.ten_tgia, count(*) as so_luong
from tacgia
join baiviet
where baiviet.ma_tgia = tacgia.ma_tgia
group by tacgia.ma_tgia
having count(baiviet.ma_tgia) = (
select count(*) as so_luong
from baiviet
left join tacgia
on baiviet.ma_tgia = tacgia.ma_tgia
group by tacgia.ten_tgia
order by so_luong desc
limit 1
);

--g
select baiviet.* from baiviet
where baiviet.ten_bhat like "% yeu"
or baiviet.ten_bhat like "% thuong"
or baiviet.ten_bhat like "% anh" 
or baiviet.ten_bhat like "% em";

--h
select baiviet.* from baiviet
where (baiviet.ten_bhat like "% yeu"
or baiviet.ten_bhat like "% thuong"
or baiviet.ten_bhat like "% anh" 
or baiviet.ten_bhat like "% em") OR
(baiviet.tieude like "% yeu"
or baiviet.tieude like "% thuong"
or baiviet.tieude like "% anh"
or baiviet.tieude like "% em"
);

--i
create view vw_Music as
select baiviet.tieude, theloai.ten_tloai, tacgia.ten_tgia
from baiviet 
join theloai on baiviet.ma_tloai = theloai.ma_tloai 
join tacgia on baiviet.ma_tgia = tacgia.ma_tgia;



--j
create procedure sp_DSBaiViet(
    in ten_the_loai varchar(30)
    )
begin
    declare khong_ton_tai condition for sqlstate '45000';
    if EXISTS(select baiviet.* from baiviet, theloai 
        where baiviet.ma_tloai = theloai.ma_tloai
        and theloai.ten_tloai like ten_the_loai) = 0 
        then
        signal sqlstate '45000' set message_text = 'The loai khong ton tai';
    else
        (select baiviet.* from baiviet, theloai 
        where baiviet.ma_tloai = theloai.ma_tloai
        and theloai.ten_tloai like ten_the_loai);
    end if;
end;

call sp_DSBaiViet("Nhac tre");

alter table theloai
add column SLBaiViet int;

update theloai
set `SLBaiViet` = NULL;
update theloai a, (select theloai.ma_tloai, count(*) cnt
                    from theloai
                    join baiviet
                    on baiviet.ma_tloai = theloai.ma_tloai
                    group by theloai.ma_tloai) b
set a.`SLBaiViet` = b.cnt
where a.ma_tloai = b.ma_tloai;


--l
create table Users (
    id_taikhoan int not null AUTO_INCREMENT,
    tai_khoan varchar(100),
    mat_khau varchar(200),
    primary key (id_taikhoan)
);

-- delete from baiviet where baiviet.ma_bviet = 15;

-- insert into baiviet  (ma_bviet, tieude, ten_bhat, ma_tloai, tomtat, ma_tgia, ngayviet)
-- values(15, "Tình em", "Tình em", 2, "Em ơi em ở lại",1,now());

-- update baiviet
-- set ma_tloai = 4 where ma_bviet = 15;


