<?php 
include("../configs/DBConnection.php");
include("../model/Article.php");

class ArticleService
{
    public function getAllArticle()
    {
        $dbConn = new DBConnection();
        $conn = $dbConn->getConnection();

        $stmt = $conn->prepare("SELECT * FROM tacgia");

        $stmt->setFetchMode(PDO::FETCH_ASSOC);
        $stmt->execute();
        while ($row = $stmt->fetch())
        {
            echo $row['ma_tgia'],"\n";
            echo $row['ten_tgia'],"\n";
            echo $row['hinh_tgia'], "\n";
            echo '</br>';
        }
    }
}

$as = new ArticleService();
$as->getAllArticle();

?>