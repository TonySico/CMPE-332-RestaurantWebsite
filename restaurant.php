<!DOCTYPE html>

<head>
    <link href="basic.css" type="text/css" rel="stylesheet">
</head>

<html>

    <body>
        <center>
            <h1>Restaurant</h1>
            <nav>
                <a class="active" href="restaurant.php">Home</a> |
                <a href="">CSS</a> |
                <a href="">JavaScript</a> |
                <a href="">Python</a>
            </nav>
        </center>

        <form action=restaurant.php" method="post">
            <p>First name:</p>
            <input type="text" name="firstname">
            <br>
            <p>Last name: </p>
            <input type="text" name="lastname">
            <input type="submit">
        </form>

        <table>
            <tr><th>First Name</th><th>Surname</th></tr>
            <?php
            $givenName = $_POST["firstname"];
            $surname = $_POST["lastname"];
            echo "<td>", $givenName, "</td><td>", $surname,
            "</td>"
            ?>
        </table>

    </body>

</html>
