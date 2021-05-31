<section class="cart">
    <section class="detailedCart">
    <h1 class="cartTitle">Carrito</h1>
        <?php
            include 'connection.php';
            include 'cartCard.php';

            function searchForId($id, $array) {
                foreach ($array as $key => $val) {
                    if ($val['idProduct'] === $id) {
                        return $key;
                    }
                }
                return null;
             }
             
            if(isset($_POST['removeProduct'])){
                $productId = $_POST['productId'];
                unset($_SESSION['cart'][searchForId($productId, $_SESSION['cart'])]);
            }
            
            if(count($_SESSION['cart']) === 0){
                unset($_SESSION["cart"]);
                unset($_SESSION["totalCart"]);
            }

            $idProducts = array_column($_SESSION['cart'], 'idProduct');
            $_SESSION['totalCart'] = 0;

            foreach($idProducts as $singleProductID){
                $productInfo = $conn -> query("SELECT * FROM tproduct WHERE idProduct = $singleProductID");
                while($row = mysqli_fetch_object($productInfo)){
                    createCartElement($row -> productName, $row -> productPrice, $row -> productImg, $singleProductID);
                    $_SESSION['totalCart'] += $row -> productPrice;
                }
            };
            echo "<h3 class='total'>Total: " . number_format( $_SESSION['totalCart']) . " COP </h3>";
        ?>
    </section>
</section>