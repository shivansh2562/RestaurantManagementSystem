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
                                <a href="sales_by_year.php"><i class="mdi mdi-view-dashboard"></i>Sales By Year</a>
                               
                            </li>
                             <li class="has-submenu">
                                <a href="max_customer_order.php"><i class="mdi mdi-view-dashboard"></i>Max Customer Orders</a>
                               
                            </li>
                             <li class="has-submenu">
                                <a href="expensive_dishes.php"><i class="mdi mdi-view-dashboard"></i>Expensive Dishes</a>
                               
                            </li>
                             <li class="has-submenu">
                                <a href="reservation_history.php"><i class="mdi mdi-view-dashboard"></i>Reservation History</a>
                               
                            </li>
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
