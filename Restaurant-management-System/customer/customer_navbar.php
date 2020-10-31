<?php

if (!isset($_COOKIE['user_type'])) {
   
     header("Location: http://localhost/labourse/login.php");
    die();
}

?>

  <div class="navbar-custom">
                <div class="container">
                    <div id="navigation">
                        <!-- Navigation Menu-->
                        <ul class="navigation-menu">

                            <li class="has-submenu">
                                <a href="dashboard.php"><i class="mdi mdi-view-dashboard"></i>Dashboard</a>
                               
                            </li>
                             <li class="has-submenu">
                                <a href="reservation_history.php"><i class="mdi mdi-view-dashboard"></i>Reservation History</a>
                            </li>
                            <li class="has-submenu">
                                <a href="allocate_table.php"><i class="mdi mdi-view-dashboard"></i>Allocate table</a>
                            </li>
                            <li class="has-submenu">
                                <a href="place_order.php"><i class="mdi mdi-view-dashboard"></i>Place Order</a>
                            </li>
                             <li class="has-submenu">
                                <a href="add_order_items.php"><i class="mdi mdi-view-dashboard"></i>Add or update items to your order</a>
                            </li>
                            <li class="has-submenu">
                                <a href="get_amount.php"><i class="mdi mdi-view-dashboard"></i>Calculate Bill</a>
                               
                            </li>
                            <li class="has-submenu">
                                <a href="payment_after_discount.php"><i class="mdi mdi-view-dashboard"></i>Payment After Discount</a>
                               
                            </li>
                             <li class="has-submenu">
                                <a href="payment_after_offer.php"><i class="mdi mdi-view-dashboard"></i>Payment After OFFER</a>
                               
                           
                             
                             <li class="has-submenu">
                                <a href="../logout.php" class="btn btn-md btn-danger">logout</a>
                               
                            </li>
                           
                           
                           

                         
                        </ul>
                        <!-- End navigation menu -->
                    </div> <!-- end #navigation -->
                </div> <!-- end container -->
            </div> <!-- end navbar-custom -->
        </header>
        <!-- End Navigation Bar-->
