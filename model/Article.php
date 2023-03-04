<?php 

class Article
{
    private $tieude;
    private $noidung;
    private $tomtat;

    private $tacgia;
    
    private $theloai;

    public function __construct($tieude, $theloai, $tomtat, $noidung,  $tacgia)
    {
        $this->tieude = $tieude;
        $this->theloai = $theloai;
        $this->tomtat = $tomtat;
        $this->noidung = $noidung;
        $this->tacgia = $tacgia;
    }

    public function getTieuDe()
    {
        return $this->tieude;
    }
    public function getTheLoai()
    {
        return $this->theloai;
    }
    public function getTomTat()
    {
        return $this->tomtat;
    }
    public function getNoiDung()
    {
        return $this->noidung;
    }

    public function getTacGia()
    {
        return $this->tacgia;
    }
    
}


?>