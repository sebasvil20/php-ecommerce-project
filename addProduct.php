<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles/global.css">
    <link rel="stylesheet" href="styles/addProducts.css">
    <title>Deckstore | Agregar producto</title>
</head>

<body>
    <?php include_once 'components/header.php';
    
        if(!isset($_SESSION)){
            session_start();
        }

        if(!isset($_SESSION['User'])){
            header('Location: login.php');
        }
    ?>
    <h1 class="product-section-title">Llena el formulario para agregar un nuevo producto</h1>
    <section class="form-container">
        <h2 class="title">Nuevo producto</h2>
        <form action="addProduct.php" method="POST">
            <div class="input-wrapper input-wrapper-full">
                <label for="">Nombre del producto*</label>
                <input type="text" name="productName" class="form-input form-input-full"
                    placeholder="Ingrese el nombre del producto" required>
            </div>
            <div class="input-wrapper input-wrapper-mid">
                <label for="">Marca*</label>
                <input type="text" name="productBrand" class="form-input form-input-full"
                    placeholder="Ingrese la marca del producto" required>
            </div>
            <div class="input-wrapper input-wrapper-mid">
                <label for="">Precio*</label>
                <input type="text" name="productPrice" class="form-input form-input-full"
                    placeholder="Ingrese precio del producto" pattern="[0-9]{4,}"
                    title="Utilice solo números en este campo, mínimo 4 dígitos" required>
            </div>
            <div class="input-wrapper input-wrapper-full">
                <label for="">Imagen del producto (URL)*</label>
                <input type="text" name="productImg" class="form-input form-input-full"
                    placeholder="Escriba la url de la imagen" required>
            </div>

            <div class="input-wrapper input-wrapper-full">

                <label for="">Categoria del producto*</label>
                <select name="selectCategory">
                    <option value="0">Seleccione una categoria</option>
                    <?php
                        include 'connection.php';

                        $getCategoriesQuery = "CALL get_all_categories() ";
                        $categoriesRows = $conn -> query($getCategoriesQuery);

                        while($row = mysqli_fetch_object($categoriesRows)){
                            echo "<option value=\"". $row -> idCategory ."\">". $row -> categoryName ."</option>";
                        }
                    ?>
                </select>
            </div>

            <button class="form-btn" type="submit" name="addProduct">
                Guardar producto
            </button>
        </form>
        <?php
            if (isset($_POST['addProduct'])){
                include 'connection.php';

                $productName = $_POST['productName'];
                $productBrand = $_POST['productBrand'];
                $productPrice = $_POST['productPrice'];
                $productImg = $_POST['productImg'];
                $selectedCategoryId = $_POST['selectCategory'];
                
                $saveNewProductQuery = "CALL add_new_product('$productName', '$productBrand', $productPrice, '$productImg', $selectedCategoryId)";

                if(mysqli_query($conn, $saveNewProductQuery)){
                    echo "<div class=\"msg success\">
                            Se ha guardado el producto correctamente
                        </div>";
                }
                else echo "<div class=\"msg error\">
                            Ha ocurrido un error intentelo nuevamente
                        </div>";
            }
        ?>
    </section>
    <?php include_once 'components/footer.php' ?>
</body>

</html>