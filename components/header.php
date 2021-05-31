<nav>
    <a href="/phpSena/ecommercedb">
        <img src="https://i.ibb.co/SmRcPz2/image-1-removebg-preview.png" alt="" class="logo">
    </a>
    <ul>
        <li><a href="/phpSena/ecommercedb" class="menu-link">Inicio</a></li>
        <li class="menu-link dropdown">
            Categorías
            <img src="img/downarrow.svg" alt="down arrow" class="down-arrow">
            <div class="dropdown-content">
                <ul class="dropdown-list">
                    <?php
                        include 'connection.php';
                        
                        $getCategoriesQuery = "CALL get_all_categories() ";
                        $categoriesRows = $conn -> query($getCategoriesQuery);

                        while($row = mysqli_fetch_object($categoriesRows)){
                            echo '<a href="/phpSena/ecommercedb/?categoryId='. $row -> idCategory.'">'. $row -> categoryName .'</a>';
                        }
                    ?>
                </ul>
            </div>
        </li>
        <li class="menu-link dropdown">
            Agregar
            <img src="img/downarrow.svg" alt="down arrow" class="down-arrow">
            <div class="dropdown-content">
                <ul class="dropdown-list">
                    <a href="addProduct.php">Producto</a>
                    <a href="#!">Categoría</a>
                </ul>
            </div>
        </li>
        <?php 
            
            if(!isset($_SESSION)){
                session_start();
            }

            if(!isset($_SESSION['User'])){
                echo "<li><a href='login.php' class='menu-link'>Login</a></li>";
            }
            else{
                echo "<li><a href='userProfile.php' class='menu-link user'>". $_SESSION['User'] -> name ."</a></li>";
            }
        ?>
        
    </ul>
</nav>