<?php
function createCartElement($productName, $productPrice, $productImg, $productId){
    echo "<form action='#' method='POST' class='cartForm'> 
            <div class='productCardCart'>
                <img src='$productImg'>
                <div class='text'>
                    <h1>$productName</h1>
                    <h5>".number_format($productPrice)." COP</h5>
                </div>
            </div>
            <input type='hidden' value='$productId' name='productId'>
            <button type='submit' name='removeProduct' class='removeItemButton'>
                <svg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='#ff4141'>
                    <path d='M12 0c-6.627 0-12 5.373-12 12s5.373 12 12 12 12-5.373 12-12-5.373-12-12-12zm4.597 17.954l-4.591-4.55-4.555 4.596-1.405-1.405 4.547-4.592-4.593-4.552 1.405-1.405 4.588 4.543 4.545-4.589 1.416 1.403-4.546 4.587 4.592 4.548-1.403 1.416z'/>
                </svg>
            </button>
        </form>
        <hr>";
}
?>